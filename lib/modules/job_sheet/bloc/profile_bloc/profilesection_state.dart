import 'package:equatable/equatable.dart';
import 'package:local_shout_billing/models/profile_information_model.dart';
import 'package:local_shout_billing/models/update_profile.dart';

enum ProfileSectionStatus {
  initial,
  loading,
  success,
  failure,
  profileUpdate,
  passwrordLoading,
  passwordUpdated,
  submitFailure,
  passwordFailure,
  sending,
  updating,
  updated
}
enum LogoutStatus {
  initial,
  loading,
  success,
  failure,
}
class ProfileSectionState extends Equatable {
  final ProfileSectionStatus? status;
   final LogoutStatus? logoutStatus;
  final ProfileInformationModel? profileModel;
  final UpdateProfileModel? updateProfileModel;
  final String? errorMessage;
  final String? passwordErrorMessage;
  const ProfileSectionState({
    this.status = ProfileSectionStatus.initial,
      this.logoutStatus = LogoutStatus.initial,
    this.profileModel = ProfileInformationModel.empty,
    this.updateProfileModel = UpdateProfileModel.empty,
    this.errorMessage,
    this.passwordErrorMessage,
  });

  @override
  List<Object> get props => [
        status!,
        logoutStatus!,
        profileModel!,
        updateProfileModel!,
      ];

  ProfileSectionState copyWith({
    ProfileSectionStatus? status,
    LogoutStatus? logoutStatus,
    ProfileInformationModel? profileModel,
    UpdateProfileModel? updateProfileModel,
    String? errorMessage,
    String? passwordErrorMessage,
  }) {
    return ProfileSectionState(
      status: status ?? this.status,
      logoutStatus: logoutStatus ?? this.logoutStatus,  
      profileModel: profileModel ?? this.profileModel,
      updateProfileModel: updateProfileModel ?? this.updateProfileModel,
      errorMessage: errorMessage ?? this.errorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
    );
  }
}
