part of 'purches_invoice_details_bloc.dart';

class PurchesInvoiceDetailsEvent extends Equatable {
  const PurchesInvoiceDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPurchaseDetailsByID extends PurchesInvoiceDetailsEvent {
  final String? id;
  const GetPurchaseDetailsByID({required this.id});
}

class GeneratePurchaseInvoiceEvent extends PurchesInvoiceDetailsEvent {
  final Map<String, dynamic>? formData;
  final String? id;
  const GeneratePurchaseInvoiceEvent({this.formData, this.id});
}

class ResetUpdateStatusEvent extends PurchesInvoiceDetailsEvent {}

class FetchLocationList extends PurchesInvoiceDetailsEvent {
  final PurchesInvoiceDetailsStatus? purchaseSearchStatus;
  final String? searchKeyword;
  const FetchLocationList({this.purchaseSearchStatus, this.searchKeyword});
}
