part of 'job_sheet_details_bloc.dart';

class JobSheetDetailsEvent extends Equatable {
  const JobSheetDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetEstimateDetailsByEstimate extends JobSheetDetailsEvent {
  final String id;
  final JobSheetDetailsStatus? status;
  const GetEstimateDetailsByEstimate({
    required this.id,
    this.status,
  });
}

class GetInvoiceByInvoice extends JobSheetDetailsEvent {
  final String id;
  final JobSheetDetailsStatus? status;
  final bool? executeStream;
  const GetInvoiceByInvoice({
    required this.id,
    this.status,
    this.executeStream,
  });
}

class GetInvoiceByJobSheet extends JobSheetDetailsEvent {
  final String id;
  const GetInvoiceByJobSheet({
    required this.id,
  });
}

class GetEstimateDetailsByJobSheet extends JobSheetDetailsEvent {
  final String id;
  const GetEstimateDetailsByJobSheet({
    required this.id,
  });
}

class GetEstimate extends JobSheetDetailsEvent {
  final String id;
  const GetEstimate({required this.id});
}

class UpdateCustomer extends JobSheetDetailsEvent {
  final Map<String, dynamic>? formData;
  final String id;
  const UpdateCustomer({this.formData, required this.id});
}

class UpdateVehicle extends JobSheetDetailsEvent {
  final Map<String, dynamic>? formData;
  final String id;
  const UpdateVehicle({this.formData, required this.id});
}

// ignore: must_be_immutable
class EstimateAdd extends JobSheetDetailsEvent {
  final Map<String, dynamic>? formData;
  String? id;
  EstimateAdd({this.formData, this.id});
}

class GenerateInvoiceEvent extends JobSheetDetailsEvent {
  final Map<String, dynamic>? formData;
  final String? id;
  final bool triggerDownloadAfterGenerate;
  const GenerateInvoiceEvent(
      {this.formData, this.id, this.triggerDownloadAfterGenerate = false});
}

class SearchLabour extends JobSheetDetailsEvent {
  final String? searchKeyword;
  const SearchLabour({required this.searchKeyword});
}

class SearchProduct extends JobSheetDetailsEvent {
  final String? searchKeyword;
  const SearchProduct({required this.searchKeyword});
}

class SearchSparePart extends JobSheetDetailsEvent {
  final int? timestamp;
  final String? direction;
  final String? searchKeyword;
  const SearchSparePart(
      {required this.searchKeyword, this.timestamp, this.direction});
}

class DeleteSparePart extends JobSheetDetailsEvent {
  final String? id;
  const DeleteSparePart({required this.id});
}

class DownloadEstimatePdf extends JobSheetDetailsEvent {
  final String id;
  const DownloadEstimatePdf({required this.id});
}

class DownloadInvoicePdf extends JobSheetDetailsEvent {
  final String id;
  const DownloadInvoicePdf({required this.id});
}

class ResetLastEstimateId extends JobSheetDetailsEvent {}

class ResetLastInvoiceId extends JobSheetDetailsEvent {}

class ClearData extends JobSheetDetailsEvent {
  const ClearData();
}

class GetInvoicePayment extends JobSheetDetailsEvent {
  final String id;
  const GetInvoicePayment({required this.id});
}

class AddUpdatePayment extends JobSheetDetailsEvent {
  final Map<String, dynamic>? formData;
  const AddUpdatePayment({
    this.formData,
  });
}

class ClearInvoiceDetails extends JobSheetDetailsEvent {
  const ClearInvoiceDetails();
}

class SyncOfflineUpdatedJobSheets extends JobSheetDetailsEvent {
  const SyncOfflineUpdatedJobSheets();
}

class UpdateGstBillEvent extends JobSheetDetailsEvent {
  final String id;
  final Map<String, dynamic> formData;
  final GstActionSource source;

  const UpdateGstBillEvent({
    required this.id,
    required this.formData,
    required this.source,
  });
}
