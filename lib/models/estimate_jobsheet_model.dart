import 'dart:convert';

import 'package:equatable/equatable.dart';

class JobCardToEstimateModel extends Equatable {
  final String? address;
  final int? companyId;
  final String? createdAtDate;
  final String? createdAtTime;
  final int? customerId;
  final String? deletedAt;
  final String? email;
  final String? estimateTotal;
  final String? taxablevalueTotal;
  final String? cgstTotal;
  final int? estimateId;
  final String? estimateNumber;
  final String? fullName;
  final String? invoiceLabours;
  final List<dynamic>? invoiceProducts;
  final String? labourTotal;
  final int? lastEstimateId;
  final String? mobileNumber;
  final String? productTotal;
  final String? tempDate;
  final String? gstFlag;
  final String? gstBill;
  final String? igstBill;
  final String? updatedAt;

  const JobCardToEstimateModel({
    this.address,
    this.companyId,
    this.createdAtDate,
    this.createdAtTime,
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
    this.labourTotal,
    this.lastEstimateId,
    this.mobileNumber,
    this.productTotal,
    this.tempDate,
    this.gstFlag,
    this.gstBill,
    this.igstBill,
    this.updatedAt,
  });
  @override
  List<Object> get props => [
        address!,
        companyId!,
        createdAtDate!,
        createdAtTime!,
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
        labourTotal!,
        lastEstimateId!,
        mobileNumber!,
        productTotal!,
        tempDate!,
        gstFlag!,
        gstBill!,
        igstBill!,
        updatedAt!,
      ];
  JobCardToEstimateModel copyWith({
    String? address,
    int? companyId,
    String? createdAtDate,
    String? createdAtTime,
    int? customerId,
    String? deletedAt,
    String? email,
    String? estimateTotal,
    String? taxablevalueTotal,
    String? cgstTotal,
    int? estimateId,
    String? estimateNumber,
    String? fullName,
    String? invoiceLabours,
    List<dynamic>? invoiceProducts,
    String? labourTotal,
    int? lastEstimateId,
    String? mobileNumber,
    String? productTotal,
    String? tempDate,
    String? gstFlag,
    String? gstBill,
    String? igstBill,
    String? updatedAt,
  }) {
    JobCardToEstimateModel jobCardToEstimateModel = JobCardToEstimateModel(
      address: address ?? this.address,
      companyId: companyId ?? this.companyId,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
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
      labourTotal: labourTotal ?? this.labourTotal,
      lastEstimateId: lastEstimateId ?? this.lastEstimateId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      tempDate: tempDate ?? this.tempDate,
      gstFlag: gstFlag ?? this.gstFlag,
      gstBill: gstBill ?? this.gstBill,
      igstBill: igstBill ?? this.igstBill,
      productTotal: productTotal ?? this.productTotal,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return jobCardToEstimateModel;
  }

  factory JobCardToEstimateModel.fromJson(Map<String, dynamic> json) {
    return JobCardToEstimateModel(
      address: json['address'] ?? "",
      companyId: json['company_id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      customerId: json['customer_id'] ?? 0,
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      estimateTotal: json['estimateTotal'].toString(),
      taxablevalueTotal: json['taxablevalueTotal'].toString(),
      cgstTotal: json['cgstTotal'].toString(),
      estimateId: json['estimate_id'] ?? 0,
      estimateNumber: json['estimate_number'].toString(),
      fullName: json['full_name'] ?? "",
      invoiceLabours: json['invoice_labours'],
      invoiceProducts: _safeJsonDecodeList(json['invoice_products']),
      labourTotal:
          json['labourTotal'] != null ? json['labourTotal'].toString() : "0",
      lastEstimateId: json['last_estimate_id'] ?? 0,
      mobileNumber: json['mobile_number'] ?? "",
      tempDate: json['temp_date'] ?? "",
      gstFlag: json['gst_flag'] ?? "",
      gstBill: json['gst_bill'] ?? "",
      igstBill: json['igst'] ?? "",
      productTotal: json['productTotal'].toString(),
      updatedAt: json['updated_at'] ?? "",
    );
  }
  static const empty = JobCardToEstimateModel(
    address: "",
    companyId: 0,
    createdAtDate: "",
    createdAtTime: "",
    customerId: 0,
    deletedAt: "",
    email: "",
    estimateTotal: "",
    taxablevalueTotal: "",
    estimateId: 0,
    estimateNumber: "",
    fullName: "",
    invoiceLabours: "",
    invoiceProducts: [],
    labourTotal: "",
    lastEstimateId: 0,
    mobileNumber: "",
    productTotal: "",
    tempDate: "",
    gstFlag: "",
    gstBill: "",
    igstBill: "",
    updatedAt: "",
  );

  @override
  String toString() =>
      '{address:$address,companyId:$companyId,createdAtDate:$createdAtDate,createdAtTime:$createdAtTime,customerId:$customerId,deletedAt:$deletedAt,email:$email,estimateTotal:$estimateTotal,taxablevalueTotal:$taxablevalueTotal,estimateNumber:$estimateNumber,fullName:$fullName,invoiceLabours:$invoiceLabours,invoiceProducts:$invoiceProducts,labourTotal:$labourTotal,lastEstimateId:$lastEstimateId,mobileNumber:$mobileNumber,temp_date:$tempDate,gstFlag:$gstFlag,gstBill:$gstBill,productTotal:$productTotal,updatedAt:$updatedAt,igstBill:$igstBill}';

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
