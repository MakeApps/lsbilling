part of 'vendor_details_bloc.dart';

sealed class VendorDetailsEvent extends Equatable {
  const VendorDetailsEvent();

  @override
  List<Object> get props => [];
}
class GetVendorsData extends VendorDetailsEvent {
  final String id;
  const GetVendorsData({required this.id});
}

class UpdateEditVendor extends VendorDetailsEvent {
  final Map<String, dynamic>? formData;
  final String? id;
  const UpdateEditVendor({this.formData, required this.id});
}
