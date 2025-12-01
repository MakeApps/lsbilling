part of 'purches_invoice_details_bloc.dart';

enum PurchesInvoiceDetailsStatus {
  initial,
  loading,
  getchSuccessfully,
  searchLoading,
  searchSuccessfully,
  failure,
}

enum UpdatePurchesStatus {
  initial,
  updating,
  updateSuccessfully,
  failure,
}

class PurchesInvoiceDetailsState extends Equatable {
  final PurchesInvoiceDetailsStatus? getDetailsStatus;
  final UpdatePurchesStatus? updatePurchesStatus;
  final PurchaseInvoiceDetailsModel? purchesDetailsModel;
  final List<StorageLocationModel>? storageListing;
  final int? currentPurchesInvoiceId;
  const PurchesInvoiceDetailsState({
    this.getDetailsStatus = PurchesInvoiceDetailsStatus.initial,
    this.updatePurchesStatus = UpdatePurchesStatus.initial,
    this.purchesDetailsModel = PurchaseInvoiceDetailsModel.empty,
    this.storageListing = const [],
    this.currentPurchesInvoiceId = 0,
  });

  @override
  List<Object> get props => [
        getDetailsStatus!,
        updatePurchesStatus!,
        storageListing!,
        purchesDetailsModel!,
        currentPurchesInvoiceId!,
      ];
  PurchesInvoiceDetailsState copyWith({
    PurchesInvoiceDetailsStatus? getDetailsStatus,
    List<StorageLocationModel>? storageListing,
    UpdatePurchesStatus? updatePurchesStatus,
    PurchaseInvoiceDetailsModel? purchesDetailsModel,
    int? currentPurchesInvoiceId,
  }) {
    return PurchesInvoiceDetailsState(
      getDetailsStatus: getDetailsStatus ?? this.getDetailsStatus,
      updatePurchesStatus: updatePurchesStatus ?? this.updatePurchesStatus,
      storageListing: storageListing ?? this.storageListing,
      purchesDetailsModel: purchesDetailsModel ?? this.purchesDetailsModel,
      currentPurchesInvoiceId:
          currentPurchesInvoiceId ?? this.currentPurchesInvoiceId,
    );
  }
}
