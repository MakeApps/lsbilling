import 'dart:io';

import 'package:equatable/equatable.dart';

import 'profile_update_bloc_state.dart';

class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object?> get props => [];
}

class EditAdminEvent extends EditEvent {
  final String id;
  final EditStatus status;

  const EditAdminEvent({
    required this.id,
    this.status = EditStatus.initial,
  });
}

class EditStaffEvent extends EditEvent {
  final String id;
  final EditStaffStatus status;

  const EditStaffEvent({
    required this.id,
    this.status = EditStaffStatus.initial,
  });
}

class UpdateProfileFormEvent extends EditEvent {
  final Map<String, dynamic>? formData;
  final File profileImage;
  final String id;

  const UpdateProfileFormEvent(
      {this.formData, required this.profileImage, required this.id});
}

class UpdateStaffEvent extends EditEvent {
  final Map<String, dynamic>? formData;
  final String id;

  const UpdateStaffEvent({this.formData, required this.id});
}

class UpdateGstGlag extends EditEvent {
  final String? gstFlag;
  final String id;

  const UpdateGstGlag({required this.gstFlag, required this.id});
}
