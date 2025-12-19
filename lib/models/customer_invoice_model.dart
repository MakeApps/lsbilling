import 'package:equatable/equatable.dart';

class InvoiceCustModel extends Equatable {
  final int? id;
  final String? fullName;
  final String? email;
  final String? mobileNumber;
  final int? invoiceNumber;
  final double? afterDiscountAmount;
  final String? tempDate;

  const InvoiceCustModel({
    this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.invoiceNumber,
    this.afterDiscountAmount,
    this.tempDate,
  });
  @override
  List<Object?> get props => [
        id!,
        fullName!,
        email!,
        mobileNumber!,
        invoiceNumber!,
        afterDiscountAmount!,
        tempDate!,
      ];

  /// ---------- From JSON ----------
  factory InvoiceCustModel.fromJson(Map<String, dynamic> json) {
    return InvoiceCustModel(
      id: json['id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      invoiceNumber: json['invoice_number'],
      afterDiscountAmount: (json['afterDiscountAmount'] as num?)?.toDouble(),
      tempDate: json['temp_date'] ?? '',
    );
  }

  /// ---------- copyWith ----------
  InvoiceCustModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? mobileNumber,
    int? invoiceNumber,
    double? afterDiscountAmount,
    String? tempDate,
  }) {
    InvoiceCustModel invoiceCustModel = InvoiceCustModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      afterDiscountAmount: afterDiscountAmount ?? this.afterDiscountAmount,
      tempDate: tempDate ?? this.tempDate,
    );
    return invoiceCustModel;
  }

  /// ---------- Empty ----------
  static const empty = InvoiceCustModel(
    id: 0,
    fullName: '',
    email: '',
    mobileNumber: '',
    invoiceNumber: 0,
    afterDiscountAmount: 0.0,
    tempDate: '',
  );

  @override
  String toString() =>
      '{id: $id,fullName: $fullName,email: $email, mobileNumber: $mobileNumber,invoiceNumber: $invoiceNumber, afterDiscountAmount: $afterDiscountAmount, tempDate: $tempDate}';
}
