part of 'edit_staff_details_bloc.dart';

enum EditStaffDetailsStatus {
  initial,
  loading,
  loadingDetails,
  successfullyLoadDetails,
  updating,
  updated,
  updatedSuccessfully,
  failedUpdate,
  failure,
}

class EditStaffDetailsState extends Equatable {
  final EditStaffDetailsStatus? editStaffStatus;
  final StaffDetailsModel? staffDetailsModel;
  final String? errorMessage;
  final String? errorpasswordMessage;
  final String? errorConfirmMessage;
  const EditStaffDetailsState({
    this.editStaffStatus = EditStaffDetailsStatus.initial,
    this.staffDetailsModel = StaffDetailsModel.empty,
    this.errorMessage,
    this.errorpasswordMessage,
    this.errorConfirmMessage,
  });

  @override
  List<Object> get props => [
        editStaffStatus!,
        staffDetailsModel!,
        errorMessage ?? '',
        errorpasswordMessage ?? '',
        errorConfirmMessage ?? '',
      ];

  EditStaffDetailsState copyWith({
    EditStaffDetailsStatus? editStaffStatus,
    StaffDetailsModel? staffDetailsModel,
    String? errorMessage,
    String? errorpasswordMessage,
    String? errorConfirmMessage,
  }) {
    return EditStaffDetailsState(
      editStaffStatus: editStaffStatus ?? this.editStaffStatus,
      staffDetailsModel: staffDetailsModel ?? this.staffDetailsModel,
      errorMessage: errorMessage ?? this.errorMessage,
      errorpasswordMessage: errorpasswordMessage ?? this.errorpasswordMessage,
      errorConfirmMessage: errorConfirmMessage ?? this.errorConfirmMessage,
    );
  }
}
