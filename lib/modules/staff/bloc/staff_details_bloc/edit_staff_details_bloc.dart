import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/get_staff_details_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'edit_staff_details_event.dart';
part 'edit_staff_details_state.dart';

class EditStaffDetailsBloc
    extends Bloc<EditStaffDetailsEvent, EditStaffDetailsState> {
  EditStaffDetailsBloc() : super(const EditStaffDetailsState()) {
    on<GetStaffDetails>(_onGetStaffDetails);
    on<UpdateStaffData>(_onUpdateStaffData);
  }

  FutureOr<void> _onGetStaffDetails(
      GetStaffDetails event, Emitter<EditStaffDetailsState> emit) async {
    emit(
      state.copyWith(
        editStaffStatus: EditStaffDetailsStatus.loadingDetails,
        staffDetailsModel: StaffDetailsModel.empty,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };
    final result =
        await app_instance.jobSheetRepository.getStaffDetails(jsonData);

    if (result != null && result.isNotEmpty) {
      emit(
        state.copyWith(
          editStaffStatus: EditStaffDetailsStatus.successfullyLoadDetails,
          staffDetailsModel: StaffDetailsModel.fromJson(result),
        ),
      );
    } else {
      emit(
        state.copyWith(
          editStaffStatus: EditStaffDetailsStatus.failure,
          staffDetailsModel: StaffDetailsModel.empty,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateStaffData(
      UpdateStaffData event, Emitter<EditStaffDetailsState> emit) async {
    try {
      emit(
        state.copyWith(editStaffStatus: EditStaffDetailsStatus.updating),
      );

      // Read token from secure storage
      dynamic jwtToken = await app_instance.storage.read(key: "token");
      Map<String, Object> jsonData = {
        "token": jwtToken.toString(),
        "formData": jsonEncode(event.formData),
      };

      dynamic result = await app_instance.jobSheetRepository
          .updateStaffsDetails(jsonData, event.id.toString());
      log("---------$result");
      if (result['status'] == "Success") {
        emit(
          state.copyWith(editStaffStatus: EditStaffDetailsStatus.updated),
        );

        await Future.delayed(
          const Duration(seconds: 1),
        );
        emit(
          state.copyWith(
              editStaffStatus: EditStaffDetailsStatus.updatedSuccessfully),
        );
      } else {
        String? errorMessage;
        String? errorpasswordMessage;
        String? errorConfirmMessage;

        if (result.containsKey('args') &&
            result['args'] is List &&
            result['args'].isNotEmpty) {
          final firstArg = result['args'][0];

          // Case 1: empty field error
          if (firstArg is Map) {
            if (firstArg.containsKey('password') &&
                firstArg['password'] is List &&
                firstArg['password'].isNotEmpty) {
              errorpasswordMessage = firstArg['password'][0];
            }
            if (firstArg.containsKey('confirmPassword') &&
                firstArg['confirmPassword'] is List &&
                firstArg['confirmPassword'].isNotEmpty) {
              errorConfirmMessage = firstArg['confirmPassword'][0];
            }
          }

          // Case 2: password mismatch
          if (firstArg is Map &&
              firstArg.containsKey('_schema') &&
              firstArg['_schema'] is List &&
              firstArg['_schema'].isNotEmpty) {
            errorMessage = firstArg['_schema'][0];
          }
        }

        emit(state.copyWith(
            editStaffStatus: EditStaffDetailsStatus.failedUpdate,
            errorMessage: errorMessage,
            errorpasswordMessage: errorpasswordMessage,
            errorConfirmMessage: errorConfirmMessage));
      }
    } catch (e) {
      emit(state.copyWith(
          editStaffStatus: EditStaffDetailsStatus.failedUpdate,
          errorMessage: e.toString()));
    }
  }
}
