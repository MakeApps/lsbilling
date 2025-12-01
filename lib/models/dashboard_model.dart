import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable {
  final int? delivered;
  final int? newEntries;
  final int? totalCustomer;
  final int? totalEstimate;
  final int? totalInvoice;
  final int? totalLabour;
  final int? totalMechanic;
  final int? totalProduct;
  final int? totalRepair;
  final int? totalSparePart;
  final int? totalVehicle;
  final int? userCount;
  final int? customerCountFilter;
  final int? estimateCountFilter;
  final int? invoiceCountFilter;
  final int? jobcardCountFilter;
  final double? totalOutstanding;
  final double? totalRevenue;

  const DashboardModel(
      {this.delivered,
      this.newEntries,
      this.totalEstimate,
      this.totalInvoice,
      this.totalCustomer,
      this.totalLabour,
      this.totalMechanic,
      this.totalProduct,
      this.totalRepair,
      this.totalSparePart,
      this.totalVehicle,
      this.userCount,
      this.customerCountFilter,
      this.estimateCountFilter,
      this.invoiceCountFilter,
      this.jobcardCountFilter,
      this.totalOutstanding,
      this.totalRevenue});

  @override
  List<Object> get props => [
        delivered!,
        newEntries!,
        totalCustomer!,
        totalEstimate!,
        totalInvoice!,
        totalLabour!,
        totalMechanic!,
        totalProduct!,
        totalRepair!,
        totalSparePart!,
        totalVehicle!,
        userCount!,
        customerCountFilter!,
        estimateCountFilter!,
        invoiceCountFilter!,
        jobcardCountFilter!,
        totalOutstanding!,
        totalRevenue!
      ];

  DashboardModel copyWith({
    int? delivered,
    int? newEntries,
    int? totalCustomer,
    int? totalEstimate,
    int? totalInvoice,
    int? totalLabour,
    int? totalMechanic,
    int? totalProduct,
    int? totalRepair,
    int? totalSparePart,
    int? totalVehicle,
    int? userCount,
    int? customerCountFilter,
    int? estimateCountFilter,
    int? invoiceCountFilter,
    int? jobcardCountFilter,
    double? totalOutstanding,
    double? totalRevenue,
  }) {
    DashboardModel estimateListingModel = DashboardModel(
      delivered: delivered ?? this.delivered,
      newEntries: newEntries ?? this.newEntries,
      totalCustomer: totalCustomer ?? this.totalCustomer,
      totalEstimate: totalEstimate ?? this.totalEstimate,
      totalInvoice: totalInvoice ?? this.totalInvoice,
      totalLabour: totalLabour ?? this.totalLabour,
      totalMechanic: totalMechanic ?? this.totalMechanic,
      totalProduct: totalProduct ?? this.totalProduct,
      totalRepair: totalRepair ?? this.totalRepair,
      totalSparePart: totalSparePart ?? this.totalSparePart,
      totalVehicle: totalVehicle ?? this.totalVehicle,
      userCount: userCount ?? this.userCount,
      customerCountFilter: customerCountFilter ?? this.customerCountFilter,
      estimateCountFilter: estimateCountFilter ?? this.estimateCountFilter,
      invoiceCountFilter: invoiceCountFilter ?? this.invoiceCountFilter,
      jobcardCountFilter: jobcardCountFilter ?? this.jobcardCountFilter,
      totalOutstanding: totalOutstanding ?? this.totalOutstanding,
      totalRevenue: totalRevenue ?? this.totalRevenue,
    );
    return estimateListingModel;
  }

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      delivered: json['delivered'] ?? 0,
      newEntries: json['new_entries'] ?? 0,
      totalCustomer: json['total_customer'] ?? 0,
      totalEstimate: json['total_estimate'] ?? 0,
      totalInvoice: json['total_invoice'] ?? 0,
      totalLabour: json['total_labour'] ?? 0,
      totalMechanic: json['total_mechanics'] ?? 0,
      totalProduct: json['total_product'] ?? 0,
      totalRepair: json['total_repair'] ?? 0,
      totalSparePart: json['total_spare'] ?? 0,
      totalVehicle: json['total_vehicle'] ?? 0,
      userCount: json['user_count'] ?? 0,
      customerCountFilter: json['customer_count_filtered'] ?? 0,
      estimateCountFilter: json['estimate_count_filtered'] ?? 0,
      invoiceCountFilter: json['invoice_count_filtered'] ?? 0,
      jobcardCountFilter: json['job_sheet_count_filtered'] ?? 0,
      totalOutstanding: json['total_outstanding'] ?? 0.0,
      totalRevenue: json['total_revenue'] ?? 0.0,
    );
  }
  static const empty = DashboardModel(
    delivered: 0,
    newEntries: 0,
    totalCustomer: 0,
    totalEstimate: 0,
    totalInvoice: 0,
    totalLabour: 0,
    totalMechanic: 0,
    totalProduct: 0,
    totalRepair: 0,
    totalSparePart: 0,
    totalVehicle: 0,
    userCount: 0,
    customerCountFilter: 0,
    estimateCountFilter: 0,
    invoiceCountFilter: 0,
    jobcardCountFilter: 0,
    totalOutstanding: 0.0,
    totalRevenue: 0.0,
  );

  @override
  String toString() =>
      '{"delivered": $delivered,"newEntries": $newEntries,"totalCustomer":$totalCustomer,"totalEstimate":$totalEstimate,"totalInvoice":$totalInvoice,  "totalLabour": $totalLabour, "totalMechanic":$totalMechanic, "totalProduct":$totalProduct, "totalRepair": $totalRepair , "totalSparePart":$totalSparePart  ,"totalVehicle":$totalVehicle, "userCount":$userCount,"customerCountFilter": $customerCountFilter,"estimateCountFilter":$estimateCountFilter,"invoiceCountFilter": $invoiceCountFilter, "jobcardCountFilter": $jobcardCountFilter,"totalOutstanding": $totalOutstanding, "totalRevenue": $totalRevenue,}';
}
