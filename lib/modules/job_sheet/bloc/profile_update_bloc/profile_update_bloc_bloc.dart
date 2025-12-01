import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/models/staff_profile_model.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_update_bloc/profile_update_bloc_event.dart';
import 'package:http/http.dart' as http;
import '../../../../config/constants.dart';
import '../../../../models/update_profile.dart';
import '../../../../network/repositories/jobs_sheet_repository.dart';
import '../../../login/pages/login_page.dart';
import 'profile_update_bloc_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(const EditState()) {
    on<EditAdminEvent>(_onEditAdminEvent);
    on<EditStaffEvent>(_onEditStaffEvent);
    on<UpdateProfileFormEvent>(_onUpdateProfile);
    on<UpdateStaffEvent>(_onUpdateStaffEvent);
    on<UpdateGstGlag>(_onUpdateGstFlag);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();
  Future<void> _onEditAdminEvent(
      EditAdminEvent event, Emitter<EditState> emit) async {
    emit(state.copyWith(status: EditStatus.loading));

    // if network is online.
    bool isConnected = await app_instance.networkCheck.isInternetConnected();
    if (isConnected) {
      dynamic jwtToken = await app_instance.storage.read(key: "token");

      Map<String, Object> jsonData = {
        "token": jwtToken.toString(),
        "id": event.id.toString(),
      };
      final result =
          await app_instance.jobSheetRepository.getUpdatedProfile(jsonData);

      if (result != null && result.isNotEmpty) {
        emit(state.copyWith(
          status: EditStatus.success,
          updateProfileModel: UpdateProfileModel.fromJson(result),
        ));
      } else {
        emit(state.copyWith(
          status: EditStatus.failure,
          updateProfileModel: UpdateProfileModel.empty,
        ));
      }
    } else {
      dynamic getUpdateDataFromLocally =
          await app_instance.updateDataStore.getUpdatedDataFromLocal();
      dynamic decodeUpdateddata = jsonDecode(getUpdateDataFromLocally);

      dynamic savedUpdatedData = decodeUpdateddata['company'];
      UpdateProfileModel profileUpdatedData =
          UpdateProfileModel.fromJson(savedUpdatedData);
      return emit(
        state.copyWith(
            status: EditStatus.success, updateProfileModel: profileUpdatedData),
      );
    }
  }

  _onUpdateProfile(
      UpdateProfileFormEvent event, Emitter<EditState> emit) async {
    emit(state.copyWith(status: EditStatus.updating));
    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "formData": jsonEncode(event.formData)
    };

    final result = await app_instance.jobSheetRepository
        .updateCompany(jsonData, event.id.toString());
    if (result['status'] == "Success") {
      emit(state.copyWith(status: EditStatus.updated));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: EditStatus.success));
      if (event.profileImage.path.isNotEmpty) {
        callProfileImageUploadApi(
            event.profileImage, jwtToken, event.id.toString(), 'company_logo');
      }
    } else {
      emit(state.copyWith(status: EditStatus.failed));
    }
  }

  _onUpdateStaffEvent(UpdateStaffEvent event, Emitter<EditState> emit) async {
    try {
      emit(state.copyWith(staffStatus: EditStaffStatus.updating));

      // Read token from secure storage
      dynamic jwtToken = await app_instance.storage.read(key: "token");
      Map<String, Object> jsonData = {
        "token": jwtToken.toString(),
        "formData": jsonEncode(event.formData),
      };

      dynamic result = await app_instance.jobSheetRepository
          .updatestaffData(jsonData, event.id.toString());

      if (result['status'] == "Success") {
        emit(state.copyWith(staffStatus: EditStaffStatus.updated));

        await Future.delayed(const Duration(seconds: 1));
        emit(state.copyWith(staffStatus: EditStaffStatus.success));
      } else {
        String? errorMessage;
        String? errorpasswordMessage;
        if (result.containsKey('args') &&
            result['args'] is List &&
            result['args'].isNotEmpty) {
          final firstArg = result['args'][0];
          if (firstArg is Map && firstArg.containsKey('confirmPassword')) {
            final confirmPassword = firstArg['confirmPassword'];
            if (confirmPassword is List && confirmPassword.isNotEmpty) {
              errorMessage = confirmPassword[0];
            }
          }
          if (firstArg is Map && firstArg.containsKey('password')) {
            final password = firstArg['password'];
            if (password is List && password.isNotEmpty) {
              errorpasswordMessage = password[0];
            }
          }
        }

        // Emit the state with the error message and the field-specific errors
        emit(state.copyWith(
            staffStatus: EditStaffStatus.failure,
            errorMessage: errorMessage ?? "something went to wrong",
            errorpasswordMessage: errorpasswordMessage));
      }
    } catch (e) {
      // Handle any unexpected errors (e.g., network failure)
      emit(state.copyWith(
          staffStatus: EditStaffStatus.failed, errorMessage: e.toString()));
    }
  }

  // updateGstFlag
  _onUpdateGstFlag(UpdateGstGlag event, Emitter<EditState> emit) async {
    emit(state.copyWith(status: EditStatus.updating));
    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "gst_flag": event.gstFlag.toString()
    };
    if (event.gstFlag == "1") {
      Fluttertoast.showToast(
          msg: "GST On Successfully",
          backgroundColor: successDarkColor,
          textColor: whiteColor);
    } else {
      Fluttertoast.showToast(
          msg: "GST Off Successfully",
          backgroundColor: successDarkColor,
          textColor: whiteColor);
    }
    dynamic result = await app_instance.jobSheetRepository
        .updateGstFlag(jsonData, event.id.toString());
    if (result['status'] == "Success") {
      // emit(state.copyWith(status: EditStatus.success));
      add(EditAdminEvent(id: event.id, status: EditStatus.success));
    }
  }

  callProfileImageUploadApi(
      File imageFile, String token, String id, String imageType) async {
    List<int> profileImage = [];
    const host = Constants.hostname;
    const protocol = Constants.protocol;

    var uri = Uri.parse(
        "$protocol://$host/update_company_logo/$id/$imageType/${DateTime.now().microsecondsSinceEpoch}");

    var request = http.MultipartRequest("PUT", uri);
    profileImage = await File(imageFile.path).readAsBytes();

    dynamic modifiedFileName = generateUniqeFileName(imageFile.path);
    request.files.add(http.MultipartFile.fromBytes(imageType, profileImage,
        filename: modifiedFileName));
    request.headers.addAll({
      'Accept': 'application/json, text/plain',
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    var imageSendResponse = await request.send();
    if (imageSendResponse.statusCode == 200) {}
  }

  generateUniqeFileName(originalFileName) {
    dynamic timestamp = DateTime.now().microsecondsSinceEpoch;
    dynamic randomString = Random().nextInt(900000) + 100000;
    return "$timestamp-$randomString.jpg";
  }

  FutureOr<void> _onEditStaffEvent(
      EditStaffEvent event, Emitter<EditState> emit) async {
    emit(
      state.copyWith(staffStatus: EditStaffStatus.loading),
    );
    // if network is online.
    bool isConnected = await app_instance.networkCheck.isInternetConnected();
    if (isConnected) {
      dynamic token = await app_instance.storage.read(key: "token");

      Map<String, Object> jsonData = {
        "token": token.toString(),
        "id": event.id.toString(),
      };
      final result =
          await app_instance.jobSheetRepository.getStaffData(jsonData);

      if (result != null && result.isNotEmpty) {
        emit(
          state.copyWith(
            staffStatus: EditStaffStatus.success,
            staffModel: StaffProfileModel.fromJson(result),
          ),
        );
      } else {
        emit(
          state.copyWith(
            staffStatus: EditStaffStatus.failure,
            staffModel: StaffProfileModel.empty,
          ),
        );
      }
    } else {
      dynamic getStaffUpdatedData =
          await app_instance.staffUpdatedStore.getStaffUpdatedDataFromLocal();
      dynamic decodeStaffUpdateData = jsonDecode(getStaffUpdatedData);

      dynamic savedStaffUpdatingData = decodeStaffUpdateData['users'];
      StaffProfileModel staffProfileUpdatedData =
          StaffProfileModel.fromJson(savedStaffUpdatingData);
      emit(
        state.copyWith(
            staffStatus: EditStaffStatus.success,
            staffModel: staffProfileUpdatedData),
      );
    }
  }
}
