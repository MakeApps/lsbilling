part of 'staff_bloc.dart';

enum CreateStaffStatus {
  initial,
  loading,
  deleting,
  delete,
  creating,
  created,
  adding,
  added,
  success,
  failure,
  error,
}

class StaffState extends Equatable {
  final CreateStaffStatus? staffStatus;
  final List<StaffModel> staffList;
  final int? lastTimestamp;
  final bool? hasReachedMax;
  final String? errorMessage;
  final Map<String, List<String>> fieldErrors;
  const StaffState({
    this.staffStatus = CreateStaffStatus.initial,
    this.staffList = const [],
    this.lastTimestamp,
    this.hasReachedMax = false,
    this.errorMessage,
    this.fieldErrors = const {},
  });

  @override
  List<Object> get props => [
        staffStatus!,
        staffList,
        hasReachedMax!,
        errorMessage ?? '',
      ];
  StaffState copyWith({
    CreateStaffStatus? staffStatus,
    List<StaffModel>? staffList,
    int? lastTimestamp,
    bool? hasReachedMax,
    String? errorMessage,
    Map<String, List<String>>? fieldErrors,
  }) {
    return StaffState(
      staffStatus: staffStatus ?? this.staffStatus,
      staffList: staffList ?? this.staffList,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      fieldErrors: fieldErrors ?? this.fieldErrors,
    );
  }
}
