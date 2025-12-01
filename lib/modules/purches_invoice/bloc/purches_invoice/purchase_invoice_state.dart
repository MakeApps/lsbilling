part of 'purchase_invoice_bloc.dart';

enum PurchesInvoiceStatus {
  initial,
  loading,
  fetchSuccessfully,
  deleting,
  updating,
  deleteSuccess,
  failure,
}

enum CreatePurchesStatus {
  initial,
  sending,
  loading,
  createSuccess,
  failure,
}

const _sentinel = Object();

// ignore: must_be_immutable
class PurchesInvoiceState extends Equatable {
  final PurchesInvoiceStatus? purchesStatus;
  final CreatePurchesStatus? createPurchesStatus;
  final List<PurchaseInvoiceModel> purchesModel;
  final PurchaseInvoiceModelList purchaseGstCountModel;
  final int? lastTimestamp;
  final bool? hasReachedMax;
  final int? purchesLastId;
  //  New fields for counts
  final int allPurchaseCount;
  final int gstPurchaseInvoiceCount;
  final int nonGstPurchaseInvoiceCount;
  String? selectedGstFilter;

  PurchesInvoiceState({
    this.purchesStatus = PurchesInvoiceStatus.initial,
    this.createPurchesStatus = CreatePurchesStatus.initial,
    this.purchesModel = const [],
    this.purchaseGstCountModel = PurchaseInvoiceModelList.empty,
    this.lastTimestamp,
    this.hasReachedMax = false,
    this.purchesLastId = 0,
    this.allPurchaseCount = 0,
    this.gstPurchaseInvoiceCount = 0,
    this.nonGstPurchaseInvoiceCount = 0,
    this.selectedGstFilter,
  });

  @override
  List<Object?> get props => [
        purchesStatus,
        createPurchesStatus,
        purchesModel,
        purchaseGstCountModel,
        lastTimestamp,
        hasReachedMax,
        purchesLastId,
        allPurchaseCount,
        gstPurchaseInvoiceCount,
        nonGstPurchaseInvoiceCount,
      ];

  PurchesInvoiceState copyWith({
    PurchesInvoiceStatus? purchesStatus,
    CreatePurchesStatus? createPurchesStatus,
    List<PurchaseInvoiceModel>? purchesModel,
    PurchaseInvoiceModelList? purchaseGstCountModel,
    int? lastTimestamp,
    bool? hasReachedMax,
    int? purchesLastId,
    int? allPurchaseCount,
    int? gstPurchaseInvoiceCount,
    int? nonGstPurchaseInvoiceCount,
    Object? selectedGstFilter = _sentinel,
  }) {
    return PurchesInvoiceState(
      purchesStatus: purchesStatus ?? this.purchesStatus,
      createPurchesStatus: createPurchesStatus ?? this.createPurchesStatus,
      purchesModel: purchesModel ?? this.purchesModel,
      purchaseGstCountModel:
          purchaseGstCountModel ?? this.purchaseGstCountModel,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      purchesLastId: purchesLastId ?? this.purchesLastId,
      allPurchaseCount: allPurchaseCount ?? this.allPurchaseCount,
      gstPurchaseInvoiceCount:
          gstPurchaseInvoiceCount ?? this.gstPurchaseInvoiceCount,
      nonGstPurchaseInvoiceCount:
          nonGstPurchaseInvoiceCount ?? this.nonGstPurchaseInvoiceCount,
      selectedGstFilter: identical(selectedGstFilter, _sentinel)
          ? this.selectedGstFilter
          : selectedGstFilter as String?,
    );
  }
}
