import 'package:equatable/equatable.dart';

import 'invoice_payment_submodel.dart';

class InvoicePaymentModel extends Equatable {
  final String? address;
  final String? afterDiscountAmount;
  final String? afterPayAmount;
  final String? alternetNumber;
  final String? companyName;
  final String? createdAtDate;
  final String? createdAtTime;
  final int? customerId;
  final String? deletedAt;
  final String? description;
  final String? email;
  final String? fullName;
  final int? invoiceId;
  final String? mobileNumber;
  final String? payMethod;
  final String? payableAmount;
  final String? receiptNo;
  final String? referenceNumber;
  final List<InvoicePaymentSubModel>? totalInvoicePayment;
  final String? updatedAt;

  const InvoicePaymentModel({
    this.address,
    this.afterDiscountAmount,
    this.afterPayAmount,
    this.alternetNumber,
    this.companyName,
    this.createdAtDate,
    this.createdAtTime,
    this.customerId,
    this.deletedAt,
    this.description,
    this.email,
    this.fullName,
    this.invoiceId,
    this.mobileNumber,
    this.payMethod,
    this.payableAmount,
    this.receiptNo,
    this.referenceNumber,
    this.totalInvoicePayment,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        address,
        afterDiscountAmount,
        afterPayAmount,
        alternetNumber,
        companyName,
        createdAtDate,
        createdAtTime,
        customerId,
        deletedAt,
        description,
        email,
        fullName,
        invoiceId,
        mobileNumber,
        payMethod,
        payableAmount,
        receiptNo,
        referenceNumber,
        totalInvoicePayment,
        updatedAt,
      ];

  InvoicePaymentModel copyWith({
    String? address,
    String? afterDiscountAmount,
    String? afterPayAmount,
    String? alternetNumber,
    String? companyName,
    String? createdAtDate,
    String? createdAtTime,
    int? customerId,
    String? deletedAt,
    String? description,
    String? email,
    String? fullName,
    int? invoiceId,
    String? mobileNumber,
    String? payMethod,
    String? payableAmount,
    String? receiptNo,
    String? referenceNumber,
    List<InvoicePaymentSubModel>? totalInvoicePayment,
    String? updatedAt,
  }) {
    return InvoicePaymentModel(
      address: address ?? this.address,
      afterDiscountAmount: afterDiscountAmount ?? this.afterDiscountAmount,
      afterPayAmount: afterPayAmount ?? this.afterPayAmount,
      alternetNumber: alternetNumber ?? this.alternetNumber,
      companyName: companyName ?? this.companyName,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      customerId: customerId ?? this.customerId,
      deletedAt: deletedAt ?? this.deletedAt,
      description: description ?? this.description,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      invoiceId: invoiceId ?? this.invoiceId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      payMethod: payMethod ?? this.payMethod,
      payableAmount: payableAmount ?? this.payableAmount,
      receiptNo: receiptNo ?? this.receiptNo,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      totalInvoicePayment: totalInvoicePayment ?? this.totalInvoicePayment,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory InvoicePaymentModel.fromJson(Map<String, dynamic> json) {
    return InvoicePaymentModel(
      address: json['address'] ?? "",
      afterDiscountAmount: json['afterDiscountAmount'] ?? "",
      afterPayAmount: json['after_pay_total_balance'] != null
          ? json['after_pay_total_balance'].toString()
          : "0",
      alternetNumber: json['alternet_number'] ?? "",
      companyName: json['company_name'] ?? "",
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      customerId: json['customer_id'] ?? 0,
      deletedAt: json['deleted_at'] ?? "",
      description: json['description'] ?? "",
      email: json['email'] ?? "",
      fullName: json['full_name'] ?? "",
      invoiceId: json['invoice_id'] ?? 0,
      mobileNumber: json['mobile_number'] ?? "",
      payMethod: json['pay_method'] ?? "",
      payableAmount: json['payable_amount'] != null
          ? json['payable_amount'].toString()
          : "0",
      receiptNo: json['receipt_no'] ?? "",
      referenceNumber: json['reference_number'] ?? "",
      totalInvoicePayment: (json['total_invoice_payment'] as List<dynamic>?)
              ?.map((e) => InvoicePaymentSubModel.fromJson(e))
              .toList() ??
          [],
      updatedAt: json['updated_at'] ?? "",
    );
  }
  static const empty = InvoicePaymentModel(
    address: "",
    afterDiscountAmount: "",
    alternetNumber: "",
    companyName: "",
    createdAtDate: "",
    createdAtTime: "",
    customerId: 0,
    deletedAt: "",
    description: "",
    email: "",
    fullName: "",
    invoiceId: 0,
    mobileNumber: "",
    payMethod: "",
    payableAmount: "",
    receiptNo: "",
    referenceNumber: "",
    totalInvoicePayment: [],
    updatedAt: "",
  );

  @override
  String toString() =>
      '{ address: $address, afterDiscountAmount: $afterDiscountAmount, alternetNumber: $alternetNumber, companyName: $companyName, createdAtDate: $createdAtDate, createdAtTime: $createdAtTime, customerId: $customerId, deletedAt: $deletedAt, description: $description, email: $email, fullName: $fullName, invoiceId: $invoiceId, mobileNumber: $mobileNumber, payMethod: $payMethod, payableAmount: $payableAmount, receiptNo: $receiptNo, referenceNumber: $referenceNumber, totalInvoicePayment: $totalInvoicePayment, updatedAt: $updatedAt}';
}
