part of 'staff_bloc.dart';

sealed class StaffEvent extends Equatable {
  const StaffEvent();

  @override
  List<Object> get props => [];
}

class FetchStaffList extends StaffEvent {
  final int? timestamp;
  final String? searchKeyword;
  final String? direction;
  final String? lastRecordUpdatedTime;
  final CreateStaffStatus? createStaffStatus;
  const FetchStaffList({
    this.timestamp,
    this.searchKeyword,
    this.direction,
    this.lastRecordUpdatedTime,
    required this.createStaffStatus,
  });
}

class DeleteStaffRecord extends StaffEvent {
  final String id;
  const DeleteStaffRecord({required this.id});
}

class CreateStaff extends StaffEvent {
  final Map<String, dynamic>? formData;

  const CreateStaff({
    this.formData,
  });
}
