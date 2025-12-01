part of 'job_sheet_bloc.dart';

class JobSheetEvent extends Equatable {
  const JobSheetEvent();

  @override
  List<Object> get props => [];
}

class FetchInvoiceList extends JobSheetEvent {
  final int? timestamp;
  final String? direction;
  final String? searchKeyword;
  final String? fromDate;
  final String? toDate;
  final String? paymentStatus;
  final String? gstFilter;
  final JobSheetStatus? status;
  const FetchInvoiceList({
    this.timestamp,
    this.direction,
    this.searchKeyword,
    this.fromDate,
    this.toDate,
    this.paymentStatus,
    this.gstFilter,
    required this.status,
  });
}

class FetchDashboard extends JobSheetEvent {
  final JobSheetStatus? status;
  final String? fromDate;
  final String? toDate;

  const FetchDashboard({
    this.status,
    this.fromDate,
    this.toDate,
  });
}

class FormPageChanged extends JobSheetEvent {
  final int pageIndex;

  const FormPageChanged(this.pageIndex);
}

class AddJobSheet extends JobSheetEvent {
  final Map<String, dynamic>? formData;
  final File frontImage;
  final File rightHandSideImage;
  final File leftHandSideImage;
  final File rearImage;
  final File dashboardImage;
  final File engineImage;
  final File batteryImage;
  final File speedometerImage;
  final File image1;
  final File image2;
  final File image3;
  final File image4;

  const AddJobSheet({
    this.formData,
    required this.frontImage,
    required this.rightHandSideImage,
    required this.leftHandSideImage,
    required this.rearImage,
    required this.dashboardImage,
    required this.engineImage,
    required this.batteryImage,
    required this.speedometerImage,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
  });
}

class SyncOfflineJobSheets extends JobSheetEvent {}

class DeleteJobSheet extends JobSheetEvent {
  final String id;
  const DeleteJobSheet({required this.id});
}

class ChangeJobSheetStatus extends JobSheetEvent {
  final int jobSheetId;
  final String status;
  const ChangeJobSheetStatus({required this.jobSheetId, required this.status});
}

class SearchJobSheet extends JobSheetEvent {
  final String searchKeyword;
  final String fromDate;
  final String toDate;
  const SearchJobSheet(
      {required this.searchKeyword, this.fromDate = "", this.toDate = ""});
}

class SearchInvoiceRecord extends JobSheetEvent {
  final String searchKeyword;
  const SearchInvoiceRecord({required this.searchKeyword});
}

class SearchEstimateRecord extends JobSheetEvent {
  final String searchKeyword;
  const SearchEstimateRecord({required this.searchKeyword});
}

class FetchEstimateList extends JobSheetEvent {
  final int? timestamp;
  final String? direction;
  final String? searchKeyword;
  final String? gstFilter;
  final JobSheetStatus status;
  const FetchEstimateList(
      {this.timestamp,
      this.direction,
      this.searchKeyword,
      this.gstFilter,
      required this.status});
}

class GenerateEstimateJobSheet extends JobSheetEvent {
  final Map<String, dynamic>? formData;
  final String? id;
  const GenerateEstimateJobSheet({this.formData, this.id});
}

class AddEstimate extends JobSheetEvent {
  final Map<String, dynamic>? formData;
  const AddEstimate({
    this.formData,
  });
}

class CreateAddInvoice extends JobSheetEvent {
  final Map<String, dynamic>? formData;
  const CreateAddInvoice({
    this.formData,
  });
}

class DeleteEstimate extends JobSheetEvent {
  final String id;
  const DeleteEstimate({required this.id});
}

class DeleteInvoice extends JobSheetEvent {
  final String id;
  const DeleteInvoice({required this.id});
}

class ClearListingData extends JobSheetEvent {
  const ClearListingData();
}
