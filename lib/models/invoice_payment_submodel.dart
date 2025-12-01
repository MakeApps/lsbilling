class InvoicePaymentSubModel {
  final String? afterDiscountAmount;
  final String? afterPayTotalBalance;
  final String? createdAt;
  final String? recivedAmountDate;
  final String? description;
  final int? invoiceNumber;
  final String? payMethod;
  final int? paymentId;
  final double? payableAmount;
  final String? referenceNumber;
  final double? totalBalance;

  InvoicePaymentSubModel({
    this.afterDiscountAmount,
    this.afterPayTotalBalance,
    this.createdAt,
    this.description,
    this.invoiceNumber,
    this.recivedAmountDate,
    this.payMethod,
    this.paymentId,
    this.payableAmount,
    this.referenceNumber,
    this.totalBalance,
  });

  factory InvoicePaymentSubModel.fromJson(Map<String, dynamic> json) {
    return InvoicePaymentSubModel(
      afterDiscountAmount: json['afterDiscountAmount'].toString(),
      afterPayTotalBalance: json['after_pay_total_balance'].toString(),
      createdAt: json['created_at'] ?? '',
      description: json['description'] ?? "",
      invoiceNumber: json['invoice_number'] ?? "",
      recivedAmountDate: json['received_amount_date'] ?? "",
      payMethod: json['pay_method'] ?? '',
      paymentId: json['payment_id'] ?? 0,
      payableAmount: (json['payable_amount'] ?? 0).toDouble(),
      referenceNumber: json['reference_number'] ?? '',
      totalBalance: (json['total_balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'afterDiscountAmount': afterDiscountAmount,
      'after_pay_total_balance': afterPayTotalBalance,
      'created_at': createdAt,
      'description': description,
      'invoice_number': invoiceNumber,
      'received_amount_date': recivedAmountDate,
      'pay_method': payMethod,
      'payment_id': paymentId,
      'payable_amount': payableAmount,
      'reference_number': referenceNumber,
      'total_balance': totalBalance,
    };
  }
}
