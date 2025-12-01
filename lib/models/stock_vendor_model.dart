import 'package:equatable/equatable.dart';

class StockVendorModel extends Equatable {
  final int? id;
  final String? vendorName;
  final String? address;
  final String? createdAt;
  final String? deletedAt;
  final String? email;
  final String? gstNumber;
  final String? phoneNumber;
  final int? timestamp;
  final double? totalBalanceVendor;
  final String? updatedAt;

  const StockVendorModel({
    this.id,
    this.vendorName,
    this.address,
    this.createdAt,
    this.deletedAt,
    this.email,
    this.gstNumber,
    this.phoneNumber,
    this.timestamp,
    this.totalBalanceVendor,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        vendorName,
        address,
        createdAt,
        deletedAt,
        email,
        gstNumber,
        phoneNumber,
        timestamp,
        totalBalanceVendor,
        updatedAt,
      ];

  StockVendorModel copyWith({
    int? id,
    String? vendorName,
    String? address,
    String? createdAt,
    String? deletedAt,
    String? email,
    String? gstNumber,
    String? phoneNumber,
    int? timestamp,
    double? totalBalanceVendor,
    String? updatedAt,
  }) {
    return StockVendorModel(
      id: id ?? this.id,
      vendorName: vendorName ?? this.vendorName,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      gstNumber: gstNumber ?? this.gstNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      timestamp: timestamp ?? this.timestamp,
      totalBalanceVendor: totalBalanceVendor ?? this.totalBalanceVendor,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory StockVendorModel.fromJson(Map<String, dynamic> json) {
    return StockVendorModel(
      id: json['id'],
      vendorName: json['vendor_name'] ?? "",
      address: json['address'] ?? "",
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      gstNumber: json['gst_number'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      timestamp: int.parse(json['timestamp'].toString()),
      totalBalanceVendor: json['total_balance_vendor'] != null
          ? double.tryParse(json['total_balance_vendor'].toString())
          : 0.0,
      updatedAt: json['updated_at'] ?? "",
    );
  }
  static const empty = StockVendorModel(
    id: 0,
    vendorName: "",
    address: "",
    createdAt: "",
    deletedAt: "",
    email: "",
    gstNumber: "",
    phoneNumber: "",
    timestamp: 0,
    totalBalanceVendor: 0,
    updatedAt: "",
  );

  @override
  String toString() =>
      '{id: $id, vendorName: $vendorName, address: $address, createdAt: $createdAt, deletedAt: $deletedAt, email: $email, gstNumber: $gstNumber, phoneNumber: $phoneNumber, timestamp: $timestamp, totalBalanceVendor: $totalBalanceVendor, updatedAt: $updatedAt}';
}
