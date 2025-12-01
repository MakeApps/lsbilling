import 'dart:convert';

import 'package:equatable/equatable.dart';

class EstimateModel extends Equatable {
  final String? address;
  final int? companyId;
  final String? createdAtDate;
  final String? createdAtTime;
  final int? customerId;
  final String? deletedAt;
  final String? email;
  final String? estimateTotal;
  final String? taxableTotal;
  final String? scgtTotal;
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
  final String? updatedAt;

  const EstimateModel({
    this.address,
    this.companyId,
    this.createdAtDate,
    this.createdAtTime,
    this.customerId,
    this.deletedAt,
    this.email,
    this.estimateTotal,
    this.taxableTotal,
    this.scgtTotal,
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
        taxableTotal!,
        scgtTotal!,
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
        updatedAt!,
      ];
  EstimateModel copyWith({
    String? address,
    int? companyId,
    String? createdAtDate,
    String? createdAtTime,
    int? customerId,
    String? deletedAt,
    String? email,
    String? estimateTotal,
    String? taxableTotal,
    String? scgtTotal,
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
    String? updatedAt,
  }) {
    EstimateModel estimateModel = EstimateModel(
      address: address ?? this.address,
      companyId: companyId ?? this.companyId,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      customerId: customerId ?? this.customerId,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      estimateTotal: estimateTotal ?? this.estimateTotal,
      scgtTotal: scgtTotal ?? this.scgtTotal,
      taxableTotal: taxableTotal ?? this.taxableTotal,
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
      productTotal: productTotal ?? this.productTotal,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return estimateModel;
  }

  factory EstimateModel.fromJson(Map<String, dynamic> json) {
    return EstimateModel(
      address: json['address'] ?? "",
      companyId: json['company_id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      customerId: json['customer_id'] ?? 0,
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      estimateTotal: json['estimateTotal'].toString(),
      taxableTotal: json['taxablevalueTotal'].toString(),
      scgtTotal: json['scgtTotal'].toString(),
      estimateId: json['estimate_id'] ?? 0,
      estimateNumber: json['estimate_number'].toString(),
      fullName: json['full_name'] ?? "",
      invoiceLabours:"",
      invoiceProducts: json['invoice_products'] != ""
          ? jsonDecode(json['invoice_products'])
          : [],
      labourTotal:
          json['labourTotal'] != null ? json['labourTotal'].toString() : "0",
      lastEstimateId: json['last_estimate_id'] ?? 0,
      mobileNumber: json['mobile_number'] ?? "",
      tempDate: json['temp_date'] ?? "",
      gstFlag: json['gst_flag'] ?? "",
      gstBill: json['gst_bill'] ?? "",
      productTotal: json['productTotal'].toString(),
      updatedAt: json['updated_at'] ?? "",
    );
  }
  static const empty = EstimateModel(
    address: "",
    companyId: 0,
    createdAtDate: "",
    createdAtTime: "",
    customerId: 0,
    deletedAt: "",
    email: "",
    estimateTotal: "",
    taxableTotal: "",
    scgtTotal: "",
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
    updatedAt: "",
  );

  @override
  String toString() =>
      '{address:$address,taxableTotal:$taxableTotal,scgtTotal:$scgtTotal,companyId:$companyId,createdAtDate:$createdAtDate,createdAtTime:$createdAtTime,customerId:$customerId,deletedAt:$deletedAt,email:$email,estimateTotal:$estimateTotal,estimateNumber:$estimateNumber,fullName:$fullName,invoiceLabours:$invoiceLabours,invoiceProducts:$invoiceProducts,labourTotal:$labourTotal,lastEstimateId:$lastEstimateId,mobileNumber:$mobileNumber,temp_date:$tempDate,gstFlag:$gstFlag,gstBill:$gstBill,productTotal:$productTotal,updatedAt:$updatedAt}';
}
