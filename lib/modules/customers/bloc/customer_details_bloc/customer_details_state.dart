part of 'customer_details_bloc.dart';

enum GetCustomerStatusDetails {
  initial,
  loading,
  updating,
  updated,
  adding,
  added,
  success,
  failure,
}

class CustomerDetailsState extends Equatable {
  final GetCustomerStatusDetails? customerDetailsStatus;
  final CustomerDetailsModel? customerDetailsList;

  const CustomerDetailsState({
    this.customerDetailsStatus = GetCustomerStatusDetails.initial,
    this.customerDetailsList = CustomerDetailsModel.empty,
  });

  @override
  List<Object> get props => [
        customerDetailsStatus!,
        customerDetailsList!,
      ];
  CustomerDetailsState copyWith({
    GetCustomerStatusDetails? customerDetailsStatus,
    CustomerDetailsModel? customerDetailsList,
  }) {
    return CustomerDetailsState(
      customerDetailsStatus: customerDetailsStatus ?? this.customerDetailsStatus,
      customerDetailsList: customerDetailsList ?? this.customerDetailsList,
    );
  }
}
