part of 'customer_bloc.dart';

class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class FetchCustomerList extends CustomerEvent {
  final int? timestamp;
  final String? searchKeyword;
  final String? direction;
  final String? lastRecordUpdatedTime;
  final CustomerStatus? status;
  const FetchCustomerList({
    this.timestamp,
    this.searchKeyword,
    this.direction,
    this.lastRecordUpdatedTime,
    required this.status,
  });
}
class CreateCustomerRecord extends CustomerEvent {
  final Map<String, dynamic>? formData;
  const CreateCustomerRecord({this.formData});
}

// class DeleteVendorRecord extends CustomerEvent {
//   final String id;
//   const DeleteVendorRecord({required this.id});
// }

