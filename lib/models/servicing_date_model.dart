
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ServicingDateModel extends Equatable {
  final int? id;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? customerAdress;
  final String? createdBy;
  final String? customerEmail;
  final String? companyName;
  final String? customerMobileNumber;
  final String? workshopNumber;
  final String? customerName;
  final String? deletedAt;
  String? servicingDate;
  final String? jobSheetId;
  final String? updatedAt;
  final String? vehicleManufacturers;
  String? vehicleStatus;
  final int? timestamp;
  final String? vehicleName;
  final String? vehicleNumber;

  ServicingDateModel(
      {this.id,
      this.createdAtDate,
      this.createdAtTime,
      this.customerAdress,
      this.workshopNumber,
      this.createdBy,
      this.customerEmail,
      this.companyName,
      this.customerMobileNumber,
      this.customerName,
      this.deletedAt,
      this.servicingDate,
      this.jobSheetId,
      this.updatedAt,
      this.vehicleManufacturers,
      this.vehicleStatus,
      this.timestamp,
      this.vehicleName,
      this.vehicleNumber});

  @override
  List<Object> get props => [
        id!,
        createdAtDate!,
        createdAtTime!,
        customerAdress!,
        createdBy!,
        customerEmail!,
        workshopNumber!,
        companyName!,
        customerMobileNumber!,
        customerName!,
        deletedAt!,
        servicingDate!,
        jobSheetId!,
        updatedAt!,
        vehicleManufacturers!,
        vehicleStatus!,
        timestamp!,
        vehicleName!,
        vehicleNumber!
      ];

  ServicingDateModel copyWith(
      {int? id,
      String? createdAtDate,
      String? createdAtTime,
      String? customerAdress,
      String? createdBy,
      String? customerEmail,
      String? customerMobileNumber,
      String? customerName,
      String? workshopNumber,
      String? companyName,
      String? deletedAt,
      String? servicingDate,
      String? jobSheetId,
      String? updatedAt,
      String? vehicleManufacturers,
      String? vehicleStatus,
      int? timestamp,
      String? vehicleName,
      String? vehicleNumber}) {
    ServicingDateModel servicingDateModel = ServicingDateModel(
        id: id ?? this.id,
        createdAtDate: createdAtDate ?? this.createdAtDate,
        createdAtTime: createdAtTime ?? this.createdAtTime,
        customerAdress: customerAdress ?? this.customerAdress,
        createdBy: createdBy ?? this.createdBy,
        workshopNumber: workshopNumber ?? this.workshopNumber,
        customerEmail: customerEmail ?? this.customerEmail,
        companyName: companyName ?? this.companyName,
        customerMobileNumber: customerMobileNumber ?? this.customerMobileNumber,
        customerName: customerName ?? this.customerName,
        deletedAt: deletedAt ?? this.deletedAt,
        servicingDate: servicingDate ?? this.servicingDate,
        jobSheetId: jobSheetId ?? this.jobSheetId,
        updatedAt: updatedAt ?? this.updatedAt,
        vehicleManufacturers: vehicleManufacturers ?? this.vehicleManufacturers,
        vehicleStatus: vehicleStatus ?? this.vehicleStatus,
        timestamp: timestamp ?? this.timestamp,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber);
    return servicingDateModel;
  }

  factory ServicingDateModel.fromJson(Map<String, dynamic> json) {
    return ServicingDateModel(
      id: json['id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      customerAdress: json['customer_address'] ?? "",
      createdBy: json['created_by'] ?? "",
      customerEmail: json['customer_email'] ?? "",
      workshopNumber: json['workshop_number'] ?? "",
      companyName: json['company_name'] ?? "",
      customerMobileNumber: json['customer_mobile_number'] ?? "",
      customerName: json['customer_name'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      servicingDate: json['due_date'] ?? "",
      jobSheetId: json['job_sheet_id'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      vehicleManufacturers: json['vehicle_manufacturers'] ?? "",
      vehicleStatus: json['status'] ?? "",
      timestamp: int.parse(json['timestamp'].toString()),
      vehicleName: json['vehicle_name'] ?? "",
      vehicleNumber: json['vehicle_number'] ?? "",
    );
  }

  @override
  String toString() =>
      '{id: $id, createdAtDate: $createdAtDate, createdAtTime: $createdAtTime,workshopNumber:$workshopNumber, customerAdress: $customerAdress,createdBy:$createdBy,  companyname:$companyName,  customerEmail: $customerEmail, customerMobileNumber: $customerMobileNumber, customerName: $customerName, deletedAt: $deletedAt,servicingDate:$servicingDate, jobSheetId: $jobSheetId, updatedAt: $updatedAt, vehicleManufacturers: $vehicleManufacturers,vehicleStatus:$vehicleStatus,vehicleName: $vehicleName, vehicleNumber: $vehicleNumber}';
}
