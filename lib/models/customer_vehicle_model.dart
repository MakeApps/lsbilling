class Vehicle {
  final int? estimateCount;
  final int? invoiceCount;

  Vehicle({this.estimateCount, this.invoiceCount});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      estimateCount: json['estimate_count'],
      invoiceCount: json['invoice_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estimate_count': estimateCount,
      'invoice_count': invoiceCount,
    };
  }
}
