import 'package:equatable/equatable.dart';

class PurchaseInvoiceModel extends Equatable {
  final String? address;
  final String? afterDiscountAmount;
  final String? afterPayTotalBalance;
  final String? createdAtTime;
  final String? deletedAt;
  final String? email;
  final int? flag;
  final String? fullName;
  final String? gstBill;
  final int? id;
  final String? invoiceTotal;
  final int? invoiceNumber;
  final String? mobileNumber;
  final String? tempDate;
  final int? timestamp;
  final String? updatedAt;

  const PurchaseInvoiceModel({
    this.address,
    this.afterDiscountAmount,
    this.afterPayTotalBalance,
    this.createdAtTime,
    this.deletedAt,
    this.email,
    this.flag,
    this.fullName,
    this.gstBill,
    this.id,
    this.invoiceTotal,
    this.invoiceNumber,
    this.mobileNumber,
    this.tempDate,
    this.timestamp,
    this.updatedAt,
  });

  List<Object?> get props => [
        address!,
        afterDiscountAmount!,
        afterPayTotalBalance!,
        createdAtTime!,
        deletedAt!,
        email!,
        flag!,
        fullName!,
        gstBill!,
        id!,
        invoiceTotal!,
        invoiceNumber!,
        mobileNumber!,
        tempDate!,
        timestamp!,
        updatedAt!,
      ];
  // CopyWith method
  PurchaseInvoiceModel copyWith({
    String? address,
    String? afterDiscountAmount,
    String? afterPayTotalBalance,
    String? createdAtTime,
    String? deletedAt,
    String? email,
    int? flag,
    String? fullName,
    String? gstBill,
    int? id,
    String? invoiceTotal,
    int? invoiceNumber,
    String? mobileNumber,
    String? tempDate,
    int? timestamp,
    String? updatedAt,
  }) {
    PurchaseInvoiceModel purchaseInvoiceModel = PurchaseInvoiceModel(
      address: address ?? this.address,
      afterDiscountAmount: afterDiscountAmount ?? this.afterDiscountAmount,
      afterPayTotalBalance: afterPayTotalBalance ?? this.afterPayTotalBalance,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      flag: flag ?? this.flag,
      fullName: fullName ?? this.fullName,
      gstBill: gstBill ?? this.gstBill,
      id: id ?? this.id,
      invoiceTotal: invoiceTotal ?? this.invoiceTotal,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      tempDate: tempDate ?? this.tempDate,
      timestamp: timestamp ?? this.timestamp,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return purchaseInvoiceModel;
  }

  // Factory method to create instance from JSON
  factory PurchaseInvoiceModel.fromJson(Map<String, dynamic> json) {
    return PurchaseInvoiceModel(
      address: json['address'] ?? "",
      afterDiscountAmount: json['afterDiscountAmount'] ?? "",
      afterPayTotalBalance: json['after_pay_total_balance'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      flag: json['flag'] ?? 0,
      fullName: json['full_name'] ?? "",
      gstBill: json['gst_bill'] ?? "",
      id: json['id'] ?? 0,
      invoiceTotal: json['invoiceTotal'] ?? "",
      invoiceNumber: json['invoice_number'] ?? 0,
      mobileNumber: json['mobile_number'] ?? "",
      tempDate: json['temp_date'] ?? "",
      timestamp: json['timestamp'] ?? 0,
      updatedAt: json['updated_at'] ?? "",
    );
  }

  static const empty = PurchaseInvoiceModel(
    address: '',
    afterDiscountAmount: '0.00',
    afterPayTotalBalance: '0.00',
    createdAtTime: '',
    deletedAt: '',
    email: '',
    flag: 0,
    fullName: '',
    gstBill: '0',
    id: 0,
    invoiceTotal: '0.00',
    invoiceNumber: 0,
    mobileNumber: '',
    tempDate: '',
    timestamp: 0,
    updatedAt: '',
  );
  @override
  String toString() =>
      '{ address: $address, afterDiscountAmount: $afterDiscountAmount, afterPayTotalBalance: $afterPayTotalBalance, '
      'createdAtTime: $createdAtTime, deletedAt: $deletedAt, email: $email, flag: $flag, '
      'fullName: $fullName, gstBill: $gstBill, id: $id, invoiceTotal: $invoiceTotal, '
      'invoiceNumber: $invoiceNumber, mobileNumber: $mobileNumber, tempDate: $tempDate, '
      'timestamp: $timestamp, updatedAt: $updatedAt}';
}
