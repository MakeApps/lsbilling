import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'invoice_payment_submodel.dart';

class InvoiceModel extends Equatable {
  final String? address;
  final int? companyId;
  final String? createdAtDate;
  final String? afterDiscountAmount;
  final String? afterPayTotalAmount;
  final String? discountAmount;
  final String? createdAtTime;
  final int? customerId;
  final String? deletedAt;
  final String? email;
  final String? invoiceTotal;
  final int? invoiceId;
  final String? invoiceNumber;
  final String? fullName;
  final List<dynamic>? invoiceLabours;
  final List<dynamic>? invoiceProducts;
  final String? labourTotal;
  final int? lastinvoiceId;
  final String? manufacturers;
  final String? mobileNumber;
  final String? productTotal;
  final String? taxableValue;
  final String? igstTotal;
  final String? tempDate;
  final String? totalInvoiceBalance;
  final String? paidAmount;
  final String? updatedAt;
  final List<InvoicePaymentSubModel>? totalInvoicePayment;
  final String? gstFlag;
  final String? gstBill;
  final String? igstBill;

  const InvoiceModel({
    this.address,
    this.companyId,
    this.createdAtDate,
    this.afterDiscountAmount,
    this.afterPayTotalAmount,
    this.discountAmount,
    this.createdAtTime,
    this.customerId,
    this.deletedAt,
    this.email,
    this.invoiceTotal,
    this.invoiceId,
    this.invoiceNumber,
    this.fullName,
    this.invoiceLabours,
    this.invoiceProducts,
    this.labourTotal,
    this.lastinvoiceId,
    this.manufacturers,
    this.mobileNumber,
    this.productTotal,
    this.taxableValue,
    this.igstTotal,
    this.tempDate,
    this.totalInvoiceBalance,
    this.paidAmount,
    this.updatedAt,
    this.totalInvoicePayment,
    this.gstFlag,
    this.gstBill,
    this.igstBill,
  });
  @override
  List<Object> get props => [
        address!,
        companyId!,
        createdAtDate!,
        createdAtTime!,
        afterDiscountAmount!,
        discountAmount!,
        afterPayTotalAmount!,
        customerId!,
        deletedAt!,
        email!,
        invoiceTotal!,
        invoiceId!,
        invoiceNumber!,
        fullName!,
        invoiceLabours!,
        invoiceProducts!,
        labourTotal!,
        lastinvoiceId!,
        manufacturers!,
        mobileNumber!,
        productTotal!,
        taxableValue!,
        igstTotal!,
        tempDate!,
        totalInvoiceBalance!,
        paidAmount!,
        updatedAt!,
        totalInvoicePayment!,
        gstFlag!,
        gstBill!,
        igstBill!,
      ];
  InvoiceModel copyWith({
    String? address,
    int? companyId,
    String? createdAtDate,
    String? afterDiscountAmount,
    String? afterPayTotalAmount,
    String? discountAmount,
    String? createdAtTime,
    int? customerId,
    String? deletedAt,
    String? email,
    String? invoiceTotal,
    int? invoiceId,
    String? invoiceNumber,
    String? fullName,
    List<dynamic>? invoiceLabours,
    List<dynamic>? invoiceProducts,
    String? labourTotal,
    int? lastinvoiceId,
    String? manufacturers,
    String? mobileNumber,
    String? productTotal,
    String? taxableValue,
    String? igstTotal,
    String? tempDate,
    String? totalInvoiceBalance,
    String? paidAmount,
    String? updatedAt,
    List<InvoicePaymentSubModel>? totalInvoicePayment,
    String? gstFlag,
    String? gstBill,
    String? igstBill,
  }) {
    InvoiceModel invoiceModel = InvoiceModel(
      address: address ?? this.address,
      companyId: companyId ?? this.companyId,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      afterDiscountAmount: afterDiscountAmount ?? this.afterDiscountAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      afterPayTotalAmount: afterPayTotalAmount ?? this.afterPayTotalAmount,
      customerId: customerId ?? this.customerId,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      invoiceTotal: invoiceTotal ?? this.invoiceTotal,
      invoiceId: invoiceId ?? this.invoiceId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      fullName: fullName ?? this.fullName,
      invoiceLabours: invoiceLabours ?? this.invoiceLabours,
      invoiceProducts: invoiceProducts ?? this.invoiceProducts,
      labourTotal: labourTotal ?? this.labourTotal,
      lastinvoiceId: lastinvoiceId ?? this.lastinvoiceId,
      manufacturers: manufacturers ?? this.manufacturers,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      tempDate: tempDate ?? this.tempDate,
      totalInvoiceBalance: totalInvoiceBalance ?? this.totalInvoiceBalance,
      paidAmount: paidAmount ?? this.paidAmount,
      productTotal: productTotal ?? this.productTotal,
      taxableValue: taxableValue ?? this.taxableValue,
      igstTotal: igstTotal ?? this.igstTotal,
      updatedAt: updatedAt ?? this.updatedAt,
      totalInvoicePayment: totalInvoicePayment ?? this.totalInvoicePayment,
      gstFlag: gstFlag ?? this.gstFlag,
      gstBill: gstBill ?? this.gstBill,
      igstBill: igstBill ?? this.igstBill,
    );
    return invoiceModel;
  }

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      address: json['address'] ?? "",
      companyId: json['company_id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      afterDiscountAmount: json['afterDiscountAmount'] ?? "",
      discountAmount: json['discountAmount'] ?? "",
      afterPayTotalAmount: json['after_pay_total_balance'] != null
          ? json['after_pay_total_balance'].toString()
          : "0",
      createdAtTime: json['created_at_time'] ?? "",
      customerId: json['customer_id'] ?? 0,
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      invoiceTotal: json['invoiceTotal'].toString(),
      invoiceId: json['invoice_id'] ?? 0,
      invoiceNumber: json['invoice_number'].toString(),
      fullName: json['full_name'] ?? "",
      invoiceLabours: json['invoice_labours'] != ""
          ? jsonDecode(json['invoice_labours'])
          : [],
      invoiceProducts: json['invoice_products'] != ""
          ? jsonDecode(json['invoice_products'])
          : [],
      labourTotal: json['labourTotal'].toString(),
      lastinvoiceId: json['last_invoice_id'] ?? 0,
      manufacturers: json['manufacturers'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      tempDate: json['temp_date'] ?? "",
      totalInvoiceBalance: json['total_invoice_balance'] != null
          ? json['total_invoice_balance'].toString()
          : "0",
      paidAmount: json['payable_amount'] != null
          ? json['payable_amount'].toString()
          : "0",
      productTotal: json['productTotal'].toString(),
      taxableValue: json['taxablevalueTotal'] != null
          ? json['taxablevalueTotal'].toString()
          : "0",
      igstTotal: json['igstTotal'] != null ? json['igstTotal'].toString() : "0",
      updatedAt: json['updated_at'] ?? "",
      totalInvoicePayment: (json['total_invoice_payment'] as List<dynamic>?)
              ?.map((e) => InvoicePaymentSubModel.fromJson(e))
              .toList() ??
          [],
      gstFlag: json['gst_flag'] ?? "",
      gstBill: json['gst_bill'] ?? "",
      igstBill: json['igst'] ?? "",
    );
  }
  static const empty = InvoiceModel(
    address: "",
    companyId: 0,
    createdAtDate: "",
    afterDiscountAmount: "",
    discountAmount: "",
    createdAtTime: "",
    afterPayTotalAmount: "",
    customerId: 0,
    deletedAt: "",
    email: "",
    invoiceTotal: "",
    invoiceId: 0,
    invoiceNumber: "",
    fullName: "",
    invoiceLabours: [],
    invoiceProducts: [],
    labourTotal: "",
    lastinvoiceId: 0,
    manufacturers: "",
    mobileNumber: "",
    productTotal: "",
    taxableValue: "",
    igstTotal: "",
    tempDate: "",
    totalInvoiceBalance: "",
    paidAmount: "",
    updatedAt: "",
    totalInvoicePayment: [],
    gstFlag: "",
    gstBill: "",
    igstBill: "",
  );

  @override
  String toString() =>
      '{address:$address,paidAmount:$paidAmount,companyId:$companyId,totalInvoicePayment:$totalInvoicePayment,afterPayTotalAmount:$afterPayTotalAmount,createdAtDate:$createdAtDate,afterDiscountAmount:$afterDiscountAmount,discountAmount:$discountAmount,  createdAtTime:$createdAtTime,customerId:$customerId,deletedAt:$deletedAt,email:$email,invoiceTotal:$invoiceTotal,invoiceNumber:$invoiceNumber,fullName:$fullName,invoiceLabours:$invoiceLabours,invoiceProducts:$invoiceProducts,labourTotal:$labourTotal,lastinvoiceId:$lastinvoiceId,manufacturers:$manufacturers,mobileNumber:$mobileNumber,temp_date:$tempDate,productTotal:$productTotal,taxableValue:$taxableValue,igstTotal:igstTotal,totalInvoiceBalance:$totalInvoiceBalance,updatedAt:$updatedAt,gstBill:$gstBill,gstFlag:$gstFlag,igstBill:$igstBill}';
}
