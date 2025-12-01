part of 'edit_staff_details_bloc.dart';

class EditStaffDetailsEvent extends Equatable {
  const EditStaffDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetStaffDetails extends EditStaffDetailsEvent {
  final String id;
  const GetStaffDetails({required this.id});
}
class UpdateStaffData extends EditStaffDetailsEvent {
  final Map<String, dynamic>? formData;
  final String id;
  const UpdateStaffData({this.formData, required this.id});
}
