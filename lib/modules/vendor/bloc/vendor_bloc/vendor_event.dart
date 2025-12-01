part of 'vendor_bloc.dart';

class VendorEvent extends Equatable {
  const VendorEvent();

  @override
  List<Object> get props => [];
}

class FetchVendorList extends VendorEvent {
  final int? timestamp;
  final String? searchKeyword;
  final String? direction;
  final String? lastRecordUpdatedTime;
  final VendorStatus? status;
  const FetchVendorList({
    this.timestamp,
    this.searchKeyword,
    this.direction,
    this.lastRecordUpdatedTime,
    required this.status,
  });
}

class DeleteVendorRecord extends VendorEvent {
  final String id;
  const DeleteVendorRecord({required this.id});
}

class AddVendor extends VendorEvent {
  final Map<String, dynamic>? formData;
  const AddVendor({this.formData});
}
