import 'package:equatable/equatable.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profilesection_state.dart';

class ProfileSectionEvent extends Equatable {
  const ProfileSectionEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileInfo extends ProfileSectionEvent {
  final ProfileSectionStatus? profileStatus;
  const FetchProfileInfo({this.profileStatus});
}

class UpdateProfilePage extends ProfileSectionEvent {
  final String? id;
  const UpdateProfilePage({required this.id});
}

class UpdatePassword extends ProfileSectionEvent {
  final String id;
  final String password;
  final String confPassword;
  const UpdatePassword({
    required this.id,
    required this.password,
    required this.confPassword,
  });
}

class LogoutUser extends ProfileSectionEvent {
  const LogoutUser();
}
