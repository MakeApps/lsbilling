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



class ChangeJobSheetStatus extends JobSheetEvent {
  final int jobSheetId;
  final String status;
  const ChangeJobSheetStatus({required this.jobSheetId, required this.status});
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
