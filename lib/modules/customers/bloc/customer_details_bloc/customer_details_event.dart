part of 'customer_details_bloc.dart';

 class CustomerDetailsEvent extends Equatable {
  const CustomerDetailsEvent();

  @override
  List<Object> get props => [];
}
class GetCustomerDetail extends CustomerDetailsEvent {
  final String id;
  const GetCustomerDetail({required this.id});
}
class UpdateCustomerInfo extends CustomerDetailsEvent {
  final Map<String, dynamic>? formData;
  final String? id;
  const UpdateCustomerInfo({this.formData, required this.id});
}
class FetchEstimateInvoice extends CustomerDetailsEvent {
  final String filter; // Estimate | Invoice
  final int? vehicleId;
  final String customerId;

  const FetchEstimateInvoice({
    required this.filter,
    required this.vehicleId,
    required this.customerId,
  });
}