import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/models/profile_information_model.dart';
import 'package:local_shout_billing/modules/login/pages/login_page.dart';
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
import 'profile_section_event.dart';
import 'profilesection_state.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

class ProfileSectionBloc
    extends Bloc<ProfileSectionEvent, ProfileSectionState> {
  ProfileSectionBloc() : super(const ProfileSectionState()) {
    on<FetchProfileInfo>(_onFetchProfileInfo);
    // on<UpdateProfilePage>(_onUpdateProfilePage);
    on<UpdatePassword>(_onUpdatePassword);
    on<LogoutUser>(_onLogoutUser);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();

  _onFetchProfileInfo(
      FetchProfileInfo event, Emitter<ProfileSectionState> emit) async {
    emit(
      state.copyWith(
          status: (event.profileStatus == ProfileSectionStatus.success)
              ? ProfileSectionStatus.success
              : ProfileSectionStatus.loading),
    );
    // if network is online.
    bool isConnected = await app_instance.networkCheck.isInternetConnected();
    if (isConnected) {
      dynamic token = await app_instance.storage.read(key: "token");

      Map<String, String> jsonData = {
        'token': token.toString(),
      };
      final result = await jobSheetRepository.profileInformation(jsonData);
      if (result != null && result.isNotEmpty) {
        final roleId = result['role_id'];
        await app_instance.appConfig.secureStorage.write(
          key: 'roleId',
          value: roleId.toString(),
        );
        final staffId = result['id'];
        await app_instance.appConfig.secureStorage.write(
          key: 'staffId',
          value: staffId.toString(),
        );

        // final workshopType = result['company_type'];
        // await app_instance.appConfig.secureStorage.write(
        //   key: 'companyType',
        //   value: workshopType.toString(),
        // );
        return emit(
          state.copyWith(
            status: ProfileSectionStatus.success,
            profileModel: ProfileInformationModel.fromJson(result),
          ),
        );
      } else {
        return emit(
          state.copyWith(
            status: ProfileSectionStatus.failure,
          ),
        );
      }
    } else {
      dynamic getProfileDataFromLocally =
          await app_instance.profileDataStore.getProfiledata();
      dynamic decodedProfileData = jsonDecode(getProfileDataFromLocally);
      dynamic savedUserData = decodedProfileData['user'];
      ProfileInformationModel profileData =
          ProfileInformationModel.fromJson(savedUserData);
      return emit(
        state.copyWith(
            status: ProfileSectionStatus.success, profileModel: profileData),
      );
    }
  }

  // Future<void> _onUpdateProfilePage(
  //     UpdateProfilePage event, Emitter<ProfileSectionState> emit) async {
  //   emit(state.copyWith(status: ProfileSectionStatus.loading));
  //   dynamic jwtToken = await app_instance.storage.read(key: "token");

  //   Map<String, Object> jsonData = {
  //     "token": jwtToken.toString(),
  //     "id": event.id.toString(),
  //   };
  //   final updateProfileDetails =
  //       await app_instance.jobSheetRepository.getUpdatedProfile(jsonData);

  //   if (updateProfileDetails != null && updateProfileDetails.isNotEmpty) {
  //     emit(
  //       state.copyWith(
  //         status: ProfileSectionStatus.success,
  //         updateProfileModel: UpdateProfileModel.fromJson(updateProfileDetails),
  //       ),
  //     );
  //   } else {
  //     emit(
  //       state.copyWith(
  //         status: ProfileSectionStatus.failure,
  //         updateProfileModel: UpdateProfileModel.empty,
  //       ),
  //     );
  //   }
  // }

  Future<void> _onUpdatePassword(
      UpdatePassword event, Emitter<ProfileSectionState> emit) async {
    emit(
      state.copyWith(status: ProfileSectionStatus.passwrordLoading),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    try {
      Map<String, Object> jsonData = {
        "token": token.toString(),
        "formData": jsonEncode({
          'password': event.password,
          'confirmPassword': event.confPassword,
        }),
      };
      final result =
          await jobSheetRepository.updatePassword(jsonData, event.id);
      if (result != null && result['status'] == 'Success') {
        emit(
          state.copyWith(status: ProfileSectionStatus.passwordUpdated),
        );
      } else {
        String? confirmPasswordErrorMessage;
        String? passwordErrorMessage;
        String? generalErrorMessage;

        if (result != null &&
            result['args'] != null &&
            result['args'] is List) {
          final args = result['args'][0];

          if (args is Map) {
            //  Case 1: Password mismatch
            if (args['_schema'] != null &&
                args['_schema'] is List &&
                args['_schema'].isNotEmpty) {
              generalErrorMessage = args['_schema'][0];
              // clear password error when mismatch occurs
              passwordErrorMessage = null;
            }

            //  Case 2: Missing password
            if (args['password'] != null &&
                args['password'] is List &&
                args['password'].isNotEmpty) {
              passwordErrorMessage = args['password'][0];
            }

            //  Case 3: Missing confirm password
            if (args['confirmPassword'] != null &&
                args['confirmPassword'] is List &&
                args['confirmPassword'].isNotEmpty) {
              confirmPasswordErrorMessage = args['confirmPassword'][0];
            }
          }
        }

        emit(state.copyWith(
          status: ProfileSectionStatus.passwordFailure,
          errorMessage: generalErrorMessage ?? confirmPasswordErrorMessage,
          passwordErrorMessage: passwordErrorMessage,
        ));
      }
    } catch (e) {
      print("Error: $e");
      emit(
        state.copyWith(),
      );
    }
  }

  Future<void> _onLogoutUser(
    LogoutUser event,
    Emitter<ProfileSectionState> emit,
  ) async {
    emit(state.copyWith(logoutStatus: LogoutStatus.loading));

    try {
      String? token = await app_instance.storage.read(key: "token");

      if (token != null) {
        await jobSheetRepository.logoutUser(token);

        emit(
          state.copyWith(logoutStatus: LogoutStatus.success),
        );
        await app_instance.storage.delete(key: 'token');
        await app_instance.runningAppIsarServices.cleanDb();
      } else {
        print("Token not found.");
        emit(
          state.copyWith(logoutStatus: LogoutStatus.failure),
        );
      }
    } catch (e) {
      print('Error in logout: $e');
      emit(
        state.copyWith(logoutStatus: LogoutStatus.failure),
      );
    }
  }
}
