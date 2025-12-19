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

enum EstimateInvoiceStatus {
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
  final EstimateInvoiceStatus? estimateInvoiceStatus;
  final CustomerDetailsModel? customerDetailsList;
  final List<InvoiceCustModel>? invoiceCustList;
  final List<EstimateCustModel>? estimateCustList;

  const CustomerDetailsState({
    this.customerDetailsStatus = GetCustomerStatusDetails.initial,
    this.estimateInvoiceStatus = EstimateInvoiceStatus.initial,
    this.customerDetailsList = CustomerDetailsModel.empty,
    this.invoiceCustList = const [],
    this.estimateCustList = const [],
  });

  @override
  List<Object> get props => [
        customerDetailsStatus!,
        estimateInvoiceStatus!,
        customerDetailsList!,
        invoiceCustList!,
        estimateCustList!,
      ];
  CustomerDetailsState copyWith({
    GetCustomerStatusDetails? customerDetailsStatus,
    EstimateInvoiceStatus? estimateInvoiceStatus,
    CustomerDetailsModel? customerDetailsList,
    List<InvoiceCustModel>? invoiceCustList,
    List<EstimateCustModel>? estimateCustList,
  }) {
    return CustomerDetailsState(
      customerDetailsStatus:
          customerDetailsStatus ?? this.customerDetailsStatus,
      estimateInvoiceStatus:
          estimateInvoiceStatus ?? this.estimateInvoiceStatus,
      customerDetailsList: customerDetailsList ?? this.customerDetailsList,
      invoiceCustList: invoiceCustList ?? this.invoiceCustList,
      estimateCustList: estimateCustList ?? this.estimateCustList,
    );
  }
}
