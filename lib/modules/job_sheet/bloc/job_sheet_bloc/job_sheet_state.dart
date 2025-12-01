part of 'job_sheet_bloc.dart';

enum JobSheetStatus {
  initial,
  loading,
  success,
  failure,
  submitSuccess,
  invoiceSuccess,
  estimateSuccess,
  invoiceSubmitSuccess,
  submitFailure,
  sending,
  updating,
  updated,
  savedLocally,
  deleting,
  deleteSuccess,
  updatingGst,
  gstGetSuccess,
  gstUpdated
}

enum GstActionSourceClass {
  estimate,
  invoice,
}

const _sentinel = Object();

class JobSheetState extends Equatable {
  final JobSheetStatus? status;
  final GstActionSourceClass? gstSource;
  final List<InvoiceListingModel> invoiceListing;
  final List<ServicingDateModel> servicingListModel;
  final DashboardModel? dashboardModel;
  final List<EstimateListingModel> estimateListing;
  final int? lastTimestamp;
  final int? currentEstimateId;
  final EstimateModel? estimateModel;
  final InvoiceModel? invoiceModel;
  final int? currentInvoiceId;
  final int? page;
  final bool isLoadingMore;
  final bool? hasReachedMax;
  final bool? loadShow;
  final int? totalPages;
  final bool gstUpdated;
  final String? updatedJobSheetId;

  final InvoiceGstCountModel invoiceGstCount;
  final EstimateGstCountModel estimateGstCount;
  final int? allInvoiceCount;
  final int? gstInvoiceCount;
  final int? nonGstInvoiceCount;
  final int? allEstimateCount;
  final int? gstEstimateCount;
  final int? nonGstEstimateCount;
  final String? selectedGstFilter;

  const JobSheetState({
    this.status = JobSheetStatus.initial,
    this.gstSource,
    this.invoiceListing = const [],
    this.servicingListModel = const [],
    this.dashboardModel = DashboardModel.empty,
    this.lastTimestamp,
    this.page = 1,
    this.hasReachedMax = false,
    this.loadShow = false,
    this.totalPages = 1,
    this.isLoadingMore = false,
    this.estimateListing = const [],
    this.currentEstimateId = 0,
    this.estimateModel = EstimateModel.empty,
    this.invoiceModel = InvoiceModel.empty,
    this.currentInvoiceId = 0,
    this.gstUpdated = false,
    this.updatedJobSheetId,
    this.invoiceGstCount = InvoiceGstCountModel.empty,
    this.estimateGstCount = EstimateGstCountModel.empty,
    this.allInvoiceCount = 0,
    this.gstInvoiceCount = 0,
    this.nonGstInvoiceCount = 0,
    this.allEstimateCount = 0,
    this.gstEstimateCount = 0,
    this.nonGstEstimateCount = 0,
    this.selectedGstFilter,
  });

  @override
  List<Object> get props => [
        status!,
        estimateListing,
        invoiceListing,
        servicingListModel,
        dashboardModel!,
        page!,
        hasReachedMax!,
        loadShow!,
        totalPages!,
        estimateModel!,
        isLoadingMore,
        currentEstimateId!,
        invoiceModel!,
        currentInvoiceId!,
        invoiceGstCount,
        estimateGstCount,
        allInvoiceCount!,
        gstInvoiceCount!,
        allEstimateCount!,
        gstEstimateCount!,
        nonGstEstimateCount!,
        nonGstInvoiceCount!,
      ];

  JobSheetState copyWith({
    JobSheetStatus? status,
    GstActionSourceClass? gstSource,
    List<EstimateListingModel>? estimateListing,
    List<ServicingDateModel>? servicingListModel,
    int? lastTimestamp,
    int? currentEstimateId,
    EstimateModel? estimateModel,
    List<InvoiceListingModel>? invoiceListing,
    DashboardModel? dashboardModel,
    InvoiceModel? invoiceModel,
    int? currentInvoiceId,
    int? page,
    bool? hasReachedMax,
    bool? loadShow,
    bool? isLoadingMore,
    int? totalPages,
    bool? gstUpdated,
    String? updatedJobSheetId,
    InvoiceGstCountModel? invoiceGstCount,
    EstimateGstCountModel? estimateGstCount,
    int? allInvoiceCount,
    int? gstInvoiceCount,
    int? nonGstInvoiceCount,
    int? allEstimateCount,
    int? gstEstimateCount,
    int? nonGstEstimateCount,
    Object? selectedGstFilter = _sentinel,
  }) {
    return JobSheetState(
      status: status ?? this.status,
      gstSource: gstSource ?? this.gstSource,
      estimateListing: estimateListing ?? this.estimateListing,
      servicingListModel: servicingListModel ?? this.servicingListModel,
      currentEstimateId: currentEstimateId ?? this.currentEstimateId,
      estimateModel: estimateModel ?? this.estimateModel,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      invoiceListing: invoiceListing ?? this.invoiceListing,
      dashboardModel: dashboardModel ?? this.dashboardModel,
      invoiceModel: invoiceModel ?? this.invoiceModel,
      currentInvoiceId: currentInvoiceId ?? this.currentInvoiceId,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loadShow: loadShow ?? this.loadShow,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      totalPages: totalPages ?? this.totalPages,
      gstUpdated: gstUpdated ?? this.gstUpdated,
      updatedJobSheetId: updatedJobSheetId ?? this.updatedJobSheetId,
      invoiceGstCount: invoiceGstCount ?? this.invoiceGstCount,
      estimateGstCount: estimateGstCount ?? this.estimateGstCount,
      allInvoiceCount: allInvoiceCount ?? this.allInvoiceCount,
      gstInvoiceCount: gstInvoiceCount ?? this.gstInvoiceCount,
      nonGstInvoiceCount: nonGstInvoiceCount ?? this.nonGstInvoiceCount,
      allEstimateCount: allEstimateCount ?? this.allEstimateCount,
      gstEstimateCount: gstEstimateCount ?? this.gstEstimateCount,
      nonGstEstimateCount: nonGstEstimateCount ?? this.nonGstEstimateCount,
      selectedGstFilter: identical(selectedGstFilter, _sentinel)
          ? this.selectedGstFilter
          : selectedGstFilter as String?,
    );
  }
}
