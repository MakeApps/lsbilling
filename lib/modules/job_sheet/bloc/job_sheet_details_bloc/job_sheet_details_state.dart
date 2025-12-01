part of 'job_sheet_details_bloc.dart';

enum JobSheetDetailsStatus {
  initial,
  loading,
  jobcardLoading,
  jobcardUpdateSuccess,
  jobcardInitials,
  estimPdfLoading,
  invoicePdfLoading,
  success,
  failed,
  updating,
  successInvoiceDetails,
  updated,
  jobcardUpdated,
  jobcardupdating,
  jobcardUpdatedLocally,
  estimateUpdated,
  updatedFailure,
  jobcardDetailsSucess,
  sending,
  estimatePdfOpened,
  invoicePdfOpened,
  estimatePdfLoaded,
  invoicePdfLoaded,
  estimatePdfFailed,
  invoicePdfFailed,
  loaded,
  failure,
  invoiceUpdated,
  updatedServicingDate,
  searchFailed,
  paymentUpdated,
  loadingPaymentUpdating,
  paymentLoading,
  paymentSuccess,
  paymentError,
  paymentFailed,
  updateSuccessfully,
  invoiceSuccessJobcard,
  invoiceLoadingJobcard,
  invoiceUpdatedJobcard,
  invoicefailedJobcard,
  updatingGst,
  updatedGst,
  gstSuccess,
  customerUpdatedSyccessfully,
  estimUpdateSuccessfully,
  tabLoading,
  tabBarSuccess,
  tabFailed,
  updatingProduct,
  updatedProduct,
  productUpdatedSuccess,
  updatingLabour,
  updatedLabour,
  labourUpdatedSuccess,
  updatingComment,
  updatedComment,
  commentUpdatedSuccess,
}

// ignore: must_be_immutable
class JobSheetDetailsState extends Equatable {
  final JobSheetDetailsStatus? status;
  final GstActionSource? source;
  JobSheetDetailModel? jobSheetDetails;
  final ImageSliderModel? imageSliderModel;
  final int? lastTimestamp;
  final CustomerModel? customerList;
  final List<LabourModel>? labourList;
  final List<ProductModel>? productList;
  final List<SparePartModel>? sparePartList;
  final EstimateModel? estimateModel;
  final JobCardToEstimateModel? jobcardEstimateModel;
  final InvoiceModel? invoiceModel;
  final VehicleModel? vehicleList;
  final InvoicePaymentModel? paymentModel;
  final int? currentEstimateIdByJobSheet;
  final int? currentInvoiceIdByJobSheet;
  final String? updatedServicingDate;
  final int? currentInvoiceId;
  final String? errorMessage;
  final String? successMessage;
  final Uint8List? pdfBytes;
  final bool triggerDownloadAfterGenerate;

  JobSheetDetailsState({
    this.status = JobSheetDetailsStatus.initial,
    this.source,
    this.jobSheetDetails = JobSheetDetailModel.empty,
    this.imageSliderModel = ImageSliderModel.empty,
    this.customerList = CustomerModel.empty,
    this.lastTimestamp,
    this.labourList = const [],
    this.productList = const [],
    this.sparePartList = const [],
    this.estimateModel = EstimateModel.empty,
    this.jobcardEstimateModel = JobCardToEstimateModel.empty,
    this.invoiceModel = InvoiceModel.empty,
    this.currentEstimateIdByJobSheet = 0,
    this.currentInvoiceIdByJobSheet = 0,
    this.vehicleList = VehicleModel.empty,
    this.paymentModel = InvoicePaymentModel.empty,
    this.updatedServicingDate = "",
    this.currentInvoiceId = 0,
    this.errorMessage = "",
    this.successMessage = "",
    this.triggerDownloadAfterGenerate = false,
    Uint8List? pdfBytes,
  }) : pdfBytes = pdfBytes ?? Uint8List(0);

  @override
  List<Object> get props => [
        status!,
        jobSheetDetails!,
        imageSliderModel!,
        customerList!,
        labourList!,
        productList!,
        sparePartList!,
        estimateModel!,
        jobcardEstimateModel!,
        invoiceModel!,
        vehicleList!,
        paymentModel!,
        currentEstimateIdByJobSheet!,
        currentInvoiceIdByJobSheet!,
        updatedServicingDate!,
        pdfBytes!,
        currentInvoiceId!,
        errorMessage ?? "",
        successMessage ?? ""
      ];

  JobSheetDetailsState copyWith({
    JobSheetDetailsStatus? status,
    GstActionSource? source,
    JobSheetDetailModel? jobSheetDetails,
    ImageSliderModel? imageSliderModel,
    int? lastTimestamp,
    CustomerModel? customerList,
    List<LabourModel>? labourList,
    List<ProductModel>? productList,
    List<SparePartModel>? sparePartList,
    EstimateModel? estimateModel,
    JobCardToEstimateModel? jobcardEstimateModel,
    InvoiceModel? invoiceModel,
    VehicleModel? vehicleList,
    InvoicePaymentModel? paymentModel,
    int? currentEstimateIdByJobSheet,
    int? currentInvoiceIdByJobSheet,
    String? updatedServicingDate,
    int? currentInvoiceId,
    String? errorMessage,
    String? successMessage,
    Uint8List? pdfBytes,
    bool? triggerDownloadAfterGenerate,
  }) {
    return JobSheetDetailsState(
      status: status ?? this.status,
      source: source ?? this.source,
      jobSheetDetails: jobSheetDetails ?? this.jobSheetDetails,
      imageSliderModel: imageSliderModel ?? this.imageSliderModel,
      customerList: customerList ?? this.customerList,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      labourList: labourList ?? this.labourList,
      estimateModel: estimateModel ?? this.estimateModel,
      jobcardEstimateModel: jobcardEstimateModel ?? this.jobcardEstimateModel,
      invoiceModel: invoiceModel ?? this.invoiceModel,
      productList: productList ?? this.productList,
      sparePartList: sparePartList ?? this.sparePartList,
      vehicleList: vehicleList ?? this.vehicleList,
      paymentModel: paymentModel ?? this.paymentModel,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      pdfBytes: pdfBytes ?? this.pdfBytes,
      updatedServicingDate: updatedServicingDate ?? this.updatedServicingDate,
      currentEstimateIdByJobSheet:
          currentEstimateIdByJobSheet ?? this.currentEstimateIdByJobSheet,
      currentInvoiceIdByJobSheet:
          currentInvoiceIdByJobSheet ?? this.currentInvoiceIdByJobSheet,
      currentInvoiceId: currentInvoiceId ?? this.currentInvoiceId,
      triggerDownloadAfterGenerate:
          triggerDownloadAfterGenerate ?? this.triggerDownloadAfterGenerate,
    );
  }
}

enum GstActionSource {
  estimate,
  invoice,
}
