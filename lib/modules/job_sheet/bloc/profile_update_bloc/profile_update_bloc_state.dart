import 'package:equatable/equatable.dart';
import 'package:local_shout_billing/models/staff_profile_model.dart';

import '../../../../models/update_profile.dart';

enum EditStatus {
  initial,
  loading,
  success,
  failed,
  updating,
  updated,
  sending,
  loaded,
  failure,
}

enum EditStaffStatus {
  initial,
  loading,
  success,
  failed,
  updating,
  updated,
  sending,
  loaded,
  failure,
}

class EditState extends Equatable {
  final EditStatus? status;
  final EditStaffStatus? staffStatus;
  final UpdateProfileModel? updateProfileModel;
  final StaffProfileModel? staffModel;
  final String? errorMessage;
  final String? errorpasswordMessage;

  const EditState(
      {this.status = EditStatus.initial,
      this.staffStatus = EditStaffStatus.initial,
      this.updateProfileModel,
      this.staffModel,
      this.errorMessage,
      this.errorpasswordMessage});

  @override
  List<Object?> get props => [
        status,
        staffStatus,
        updateProfileModel,
        staffModel,
        errorMessage ?? '',
        errorpasswordMessage
      ];

  EditState copyWith({
    EditStatus? status,
    EditStaffStatus? staffStatus,
    UpdateProfileModel? updateProfileModel,
    StaffProfileModel? staffModel,
    String? errorMessage,
    String? errorpasswordMessage,
  }) {
    return EditState(
      status: status ?? this.status,
      staffStatus: staffStatus ?? this.staffStatus,
      updateProfileModel: updateProfileModel ?? this.updateProfileModel,
      staffModel: staffModel ?? this.staffModel,
      errorMessage: errorMessage ?? this.errorMessage,
      errorpasswordMessage: errorpasswordMessage ?? this.errorpasswordMessage,
    );
  }
}
