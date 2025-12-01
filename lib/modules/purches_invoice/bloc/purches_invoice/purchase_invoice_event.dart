part of 'purchase_invoice_bloc.dart';

sealed class PurchesInvoiceEvent extends Equatable {
  const PurchesInvoiceEvent();

  @override
  List<Object> get props => [];
}

class FetchPurchesInvoiceList extends PurchesInvoiceEvent {
  final int? timestamp;
  final String? direction;
  final String? searchKeyword;
  final String? fromDate;
  final String? toDate;
  final String? gstBill;
  final String? paymentStatus;
  final PurchesInvoiceStatus? status;
  const FetchPurchesInvoiceList({
    this.timestamp,
    this.direction,
    this.searchKeyword,
    this.fromDate,
    this.toDate,
    this.gstBill,
    this.paymentStatus,
    required this.status,
  });
}

class CreatePurchesInvoice extends PurchesInvoiceEvent {
  final Map<String, dynamic>? formData;
  const CreatePurchesInvoice({this.formData});
}

class DeletePurchaseInvoice extends PurchesInvoiceEvent {
  final String id;
  const DeletePurchaseInvoice({required this.id});
}

class ResetLasteId extends PurchesInvoiceEvent {}

class ResetAndFetchPurchesInvoice extends PurchesInvoiceEvent {
  const ResetAndFetchPurchesInvoice();
}

