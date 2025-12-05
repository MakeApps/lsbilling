import 'dart:convert';

import 'package:equatable/equatable.dart';

class PurchaseInvoiceDetailsModel extends Equatable {
  final String? address;
  final int? companyId;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final String? email;
  final int? flag;
  final String? fullName;
  final String? gstBill;
  final String? gstFlag;
  final String? igstBill;
  final String? invoiceTotal;
  final int? invoiceId;
  final int? invoiceNumber;
  final List<dynamic>? invoiceProducts;
  final int? lastInvoiceId;
  final String? mobileNumber;
  final double? productTotal;
  final String? tempDate;
  final String? updatedAt;
  final int? vendorId;

  const PurchaseInvoiceDetailsModel({
    this.address,
    this.companyId,
    this.createdAtDate,
    this.createdAtTime,
    this.deletedAt,
    this.email,
    this.flag,
    this.fullName,
    this.gstBill,
    this.gstFlag,
    this.igstBill,
    this.invoiceTotal,
    this.invoiceId,
    this.invoiceNumber,
    this.invoiceProducts,
    this.lastInvoiceId,
    this.mobileNumber,
    this.productTotal,
    this.tempDate,
    this.updatedAt,
    this.vendorId,
  });
  @override
  List<Object?> get props => [
        address!,
        companyId!,
        createdAtDate!,
        createdAtTime!,
        deletedAt!,
        email!,
        flag!,
        fullName!,
        gstBill!,
        gstFlag!,
        igstBill!,
        invoiceTotal!,
        invoiceId!,
        invoiceNumber!,
        invoiceProducts!,
        lastInvoiceId!,
        mobileNumber!,
        productTotal!,
        tempDate!,
        updatedAt!,
        vendorId!,
      ];

  /// Factory constructor for creating an instance from JSON
  factory PurchaseInvoiceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PurchaseInvoiceDetailsModel(
      address: json['address']?.toString() ?? '',
      companyId: int.tryParse(json['company_id']?.toString() ?? '0') ?? 0,
      createdAtDate: json['created_at_date']?.toString() ?? '',
      createdAtTime: json['created_at_time']?.toString() ?? '',
      deletedAt: json['deleted_at']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      flag: int.tryParse(json['flag']?.toString() ?? '0') ?? 0,
      fullName: json['full_name']?.toString() ?? '',
      gstBill: json['gst_bill']?.toString() ?? '0',
      gstFlag: json['gst_flag']?.toString() ?? '0',
      igstBill: json['igst']?.toString() ?? '0',
      invoiceTotal: json['invoiceTotal']?.toString() ?? '0.00',
      invoiceId: int.tryParse(json['invoice_id']?.toString() ?? '0') ?? 0,
      invoiceNumber:
          int.tryParse(json['invoice_number']?.toString() ?? '0') ?? 0,
      invoiceProducts: json['invoice_products'] != ""
          ? jsonDecode(json['invoice_products'])
          : [],
      lastInvoiceId:
          int.tryParse(json['last_invoice_id']?.toString() ?? '0') ?? 0,
      mobileNumber: json['mobile_number']?.toString() ?? '',
      productTotal: (json['productTotal'] is num)
          ? (json['productTotal'] as num).toDouble()
          : double.tryParse(json['productTotal']?.toString() ?? '0.0') ?? 0.0,
      tempDate: json['temp_date']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      vendorId: int.tryParse(json['vendor_id']?.toString() ?? '0') ?? 0,
    );
  }
  PurchaseInvoiceDetailsModel copyWith({
    String? address,
    int? companyId,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    String? email,
    int? flag,
    String? fullName,
    String? gstBill,
    String? gstFlag,
    String? igstBill,
    String? invoiceTotal,
    int? invoiceId,
    int? invoiceNumber,
    List<dynamic>? invoiceProducts,
    int? lastInvoiceId,
    String? mobileNumber,
    double? productTotal,
    String? tempDate,
    String? updatedAt,
    int? vendorId,
  }) {
    PurchaseInvoiceDetailsModel purchaseInvoiceDetailsModel =
        PurchaseInvoiceDetailsModel(
      address: address ?? this.address,
      companyId: companyId ?? this.companyId,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      flag: flag ?? this.flag,
      fullName: fullName ?? this.fullName,
      gstBill: gstBill ?? this.gstBill,
      gstFlag: gstFlag ?? this.gstFlag,
      igstBill: igstBill ?? this.igstBill,
      invoiceTotal: invoiceTotal ?? this.invoiceTotal,
      invoiceId: invoiceId ?? this.invoiceId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceProducts: invoiceProducts ?? this.invoiceProducts,
      lastInvoiceId: lastInvoiceId ?? this.lastInvoiceId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      productTotal: productTotal ?? this.productTotal,
      tempDate: tempDate ?? this.tempDate,
      updatedAt: updatedAt ?? this.updatedAt,
      vendorId: vendorId ?? this.vendorId,
    );
    return purchaseInvoiceDetailsModel;
  }

  /// Returns an empty invoice
  static const empty = PurchaseInvoiceDetailsModel(
    address: '',
    companyId: 0,
    createdAtDate: '',
    createdAtTime: '',
    deletedAt: '',
    email: '',
    flag: 0,
    fullName: '',
    gstBill: '0',
    gstFlag: '0',
    igstBill: '0',
    invoiceTotal: '0.00',
    invoiceId: 0,
    invoiceNumber: 0,
    invoiceProducts: [],
    lastInvoiceId: 0,
    mobileNumber: '',
    productTotal: 0.0,
    tempDate: '',
    updatedAt: '',
    vendorId: 0,
  );

  @override
  String toString() =>
      '{invoiceId: $invoiceId, invoiceNumber: $invoiceNumber,igstBill:$igstBill,gstBill:$gstBill,gstBill:$gstBill, fullName: $fullName, mobileNumber: $mobileNumber, invoiceTotal: $invoiceTotal, products: $invoiceProducts,address:$address, email:$email,companyId:$companyId, createdAtDate:$createdAtDate, createdAtTime:$createdAtTime, deletedAt:$deletedAt, flag:$flag, gstFlag:$gstFlag, lastInvoiceId:$lastInvoiceId, productTotal:$productTotal, tempDate:$tempDate, updatedAt:$updatedAt, vendorId:$vendorId,companyId:$companyId,              }';
}

/// Sub-model for invoice products
