import 'dart:convert';

import 'package:equatable/equatable.dart';

class JobCardToEstimateModel extends Equatable {
  final String? address;
  final List<dynamic>? assignMechanics;
  final int? companyId;
  final String? createdAtDate;
  final String? createdAtTime;
  // final String? createdBy;
  final List<dynamic>? customerComplaints;
  final int? customerId;
  final String? deletedAt;
  final String? email;
  final String? estimateTotal;
  final String? taxablevalueTotal;
  final String? cgstTotal;
  final int? estimateId;
  final String? estimateNumber;
  final String? fullName;
  final List<dynamic>? invoiceLabours;
  final List<dynamic>? invoiceProducts;
  final List<dynamic>? items;
  final List<dynamic>? comments;
  final String? labourTotal;
  final int? lastEstimateId;
  final String? manufacturers;
  final String? mobileNumber;
  final String? productTotal;
  final String? tempDate;
  final String? gstFlag;
  final String? gstBill;
  final String? updatedAt;
  final String? kms;
  final int? vehicleId;
  final String? vehicleName;
  final String? vehicleNumber;

  const JobCardToEstimateModel({
    this.address,
    this.assignMechanics,
    this.companyId,
    this.createdAtDate,
    this.createdAtTime,
    // this.createdBy,
    this.customerComplaints,
    this.customerId,
    this.deletedAt,
    this.email,
    this.estimateTotal,
    this.taxablevalueTotal,
    this.cgstTotal,
    this.estimateId,
    this.estimateNumber,
    this.fullName,
    this.invoiceLabours,
    this.invoiceProducts,
    this.items,
    this.comments,
    this.labourTotal,
    this.lastEstimateId,
    this.manufacturers,
    this.mobileNumber,
    this.productTotal,
    this.tempDate,
    this.gstFlag,
    this.gstBill,
    this.updatedAt,
    this.vehicleId,
    this.vehicleName,
    this.kms,
    this.vehicleNumber,
  });
  @override
  List<Object> get props => [
        address!,
        assignMechanics!,
        companyId!,
        createdAtDate!,
        createdAtTime!,
        // createdBy!,
        customerComplaints!,
        customerId!,
        deletedAt!,
        email!,
        estimateTotal!,
        taxablevalueTotal!,
        cgstTotal!,
        estimateId!,
        estimateNumber!,
        fullName!,
        invoiceLabours!,
        invoiceProducts!,
        items!,
        comments!,
        labourTotal!,
        lastEstimateId!,
        manufacturers!,
        mobileNumber!,
        productTotal!,
        tempDate!,
        gstFlag!,
        gstBill!,
        updatedAt!,
        vehicleId!,
        vehicleName!,
        vehicleNumber!,
        kms!
      ];
  JobCardToEstimateModel copyWith({
    String? address,
    List<dynamic>? assignMechanics,
    int? companyId,
    String? createdAtDate,
    String? createdAtTime,
    // String? createdBy,
    List<dynamic>? customerComplaints,
    int? customerId,
    String? deletedAt,
    String? email,
    String? estimateTotal,
    String? taxablevalueTotal,
    String? cgstTotal,
    int? estimateId,
    String? estimateNumber,
    String? fullName,
    String? kms,
    List<dynamic>? invoiceLabours,
    List<dynamic>? invoiceProducts,
    List<dynamic>? items,
    List<dynamic>? comments,
    String? labourTotal,
    int? lastEstimateId,
    String? manufacturers,
    String? mobileNumber,
    String? productTotal,
    String? tempDate,
    String? gstFlag,
    String? gstBill,
    String? updatedAt,
    int? vehicleId,
    String? vehicleName,
    String? vehicleNumber,
  }) {
    JobCardToEstimateModel jobCardToEstimateModel = JobCardToEstimateModel(
        address: address ?? this.address,
        assignMechanics: assignMechanics ?? this.assignMechanics,
        companyId: companyId ?? this.companyId,
        createdAtDate: createdAtDate ?? this.createdAtDate,
        createdAtTime: createdAtTime ?? this.createdAtTime,
        // createdBy: createdBy ?? this.createdBy,
        customerComplaints: customerComplaints ?? this.customerComplaints,
        customerId: customerId ?? this.customerId,
        deletedAt: deletedAt ?? this.deletedAt,
        email: email ?? this.email,
        estimateTotal: estimateTotal ?? this.estimateTotal,
        taxablevalueTotal: taxablevalueTotal ?? this.taxablevalueTotal,
        cgstTotal: cgstTotal ?? this.cgstTotal,
        estimateId: estimateId ?? this.estimateId,
        estimateNumber: estimateNumber ?? this.estimateNumber,
        fullName: fullName ?? this.fullName,
        invoiceLabours: invoiceLabours ?? this.invoiceLabours,
        invoiceProducts: invoiceProducts ?? this.invoiceProducts,
        items: items ?? this.items,
        comments: comments ?? this.comments,
        kms: kms ?? this.kms,
        labourTotal: labourTotal ?? this.labourTotal,
        lastEstimateId: lastEstimateId ?? this.lastEstimateId,
        manufacturers: manufacturers ?? this.manufacturers,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        tempDate: tempDate ?? this.tempDate,
        gstFlag: gstFlag ?? this.gstFlag,
        gstBill: gstBill ?? this.gstBill,
        productTotal: productTotal ?? this.productTotal,
        updatedAt: updatedAt ?? this.updatedAt,
        vehicleId: vehicleId ?? this.vehicleId,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber);
    return jobCardToEstimateModel;
  }

  factory JobCardToEstimateModel.fromJson(Map<String, dynamic> json) {
    return JobCardToEstimateModel(
      address: json['address'] ?? "",
      assignMechanics: json['assign_mechanics'] != "[]"
          ? jsonDecode(json['assign_mechanics'])
          : [],
      companyId: json['company_id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      customerComplaints: json['customer_complaints'] != "[]"
          ? jsonDecode(json['customer_complaints'])
          : [],
      customerId: json['customer_id'] ?? 0,
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      kms: json['kms'] ?? "",
      estimateTotal: json['estimateTotal'].toString() ,
      taxablevalueTotal: json['taxablevalueTotal'].toString() ,
      cgstTotal: json['cgstTotal'].toString(),
      estimateId: json['estimate_id'] ?? 0,
      estimateNumber: json['estimate_number'].toString(),
      fullName: json['full_name'] ?? "",
      invoiceLabours: _safeJsonDecodeList(json['invoice_labours']),
      invoiceProducts: _safeJsonDecodeList(json['invoice_products']),
      items: json['items'] != "[]" ? jsonDecode(json['items']) : [],
      comments: json['comments'] != "[]" ? jsonDecode(json['comments']) : [],
      labourTotal:
          json['labourTotal'] != null ? json['labourTotal'].toString() : "0",
      lastEstimateId: json['last_estimate_id'] ?? 0,
      manufacturers: json['manufacturers'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      tempDate: json['temp_date'] ?? "",
      gstFlag: json['gst_flag'] ?? "",
      gstBill: json['gst_bill'] ?? "",
      productTotal: json['productTotal'].toString() ,
      updatedAt: json['updated_at'] ?? "",
      vehicleId: json['vehicle_id'] ?? 0,
      vehicleName: json['vehicle_name'] ?? "",
      vehicleNumber: json['vehicle_number'] ,
    );
  }
  static const empty = JobCardToEstimateModel(
      address: "",
      assignMechanics: [],
      companyId: 0,
      createdAtDate: "",
      createdAtTime: "",
      // createdBy: "",
      customerComplaints: [],
      customerId: 0,
      deletedAt: "",
      email: "",
      estimateTotal: "",
      taxablevalueTotal: "",
      estimateId: 0,
      estimateNumber: "",
      fullName: "",
      invoiceLabours: [],
      kms: "",
      invoiceProducts: [],
      items: [],
      comments: [],
      labourTotal: "",
      lastEstimateId: 0,
      manufacturers: "",
      mobileNumber: "",
      productTotal: "",
      tempDate: "",
      gstFlag: "",
      gstBill: "",
      updatedAt: "",
      vehicleId: 0,
      vehicleName: "",
      vehicleNumber: "");

  @override
  String toString() =>
      '{address:$address,assignMechanics:$assignMechanics,comments:$comments,companyId:$companyId,createdAtDate:$createdAtDate,createdAtTime:$createdAtTime,customerComplaints:$customerComplaints,customerId:$customerId,deletedAt:$deletedAt,email:$email,estimateTotal:$estimateTotal,taxablevalueTotal:$taxablevalueTotal,estimateNumber:$estimateNumber,fullName:$fullName,invoiceLabours:$invoiceLabours,kms:$kms,invoiceProducts:$invoiceProducts,items:$items,labourTotal:$labourTotal,lastEstimateId:$lastEstimateId,manufacturers:$manufacturers,mobileNumber:$mobileNumber,temp_date:$tempDate,gstFlag:$gstFlag,gstBill:$gstBill,productTotal:$productTotal,updatedAt:$updatedAt,vehicleId:$vehicleId,vehicleName:$vehicleName,vehicleNumber:$vehicleNumber}';

  static List<dynamic> _safeJsonDecodeList(dynamic list) {
    try {
      if (list != null &&
          list is String &&
          list.trim().isNotEmpty &&
          list != "[]") {
        final result = jsonDecode(list);
        if (result is List) {
          return result;
        }
      }
    } catch (e) {
      print(' JSON decode failed: $e\nInput: $list');
    }
    return [];
  }
}
