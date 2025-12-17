import 'package:equatable/equatable.dart';
import 'package:local_shout_billing/models/customer_vehicle_model.dart';

class CustomerDetailsModel extends Equatable {
  final int? id;
  final int? companyId;
  final String? address;
  final String? createdAt;
  final String? deletedAt;
  final String? email;
  final String? fullName;
  final String? mobileNumber;
  final String? alternateNumber;
  final String? gstNumber;
  final String? updatedAt;
  final List<Vehicle>? vehicles;

  const CustomerDetailsModel(
      {this.id,
      this.companyId,
      this.address,
      this.createdAt,
      this.deletedAt,
      this.email,
      this.fullName,
      this.mobileNumber,
      this.alternateNumber,
      this.gstNumber,
      this.updatedAt,
      this.vehicles});

  @override
  List<Object> get props => [
        id!,
        companyId!,
        address!,
        createdAt!,
        deletedAt!,
        email!,
        fullName!,
        mobileNumber!,
        alternateNumber!,
        gstNumber!,
        updatedAt!,
        vehicles!,
      ];

  CustomerDetailsModel copyWith({
    int? id,
    int? companyId,
    String? address,
    String? createdAt,
    String? deletedAt,
    String? email,
    String? fullName,
    String? mobileNumber,
    String? alternateNumber,
    String? gstNumber,
    String? updatedAt,
    List<Vehicle>? vehicles,
  }) {
    CustomerDetailsModel customerDetailsModel = CustomerDetailsModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      alternateNumber: alternateNumber ?? this.alternateNumber,
      gstNumber: gstNumber ?? this.gstNumber,
      updatedAt: updatedAt ?? this.updatedAt,
      vehicles: vehicles ?? this.vehicles,
    );
    return customerDetailsModel;
  }

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      id: json['id'] ?? 0,
      companyId: json['company_id'] ?? 0,
      address: json['customer_address'] ?? "",
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['customer_email'] ?? "",
      fullName: json['customer_full_name'] ?? "",
      mobileNumber: json['customer_mobile_number'] ?? "",
      alternateNumber: json['alternet_mobile_number'],
      gstNumber: json['gst_number'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      vehicles: json['vehicles'] != null
          ? List<Vehicle>.from(json['vehicles'].map((x) => Vehicle.fromJson(x)))
          : [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'customer_full_name': fullName,
      'customer_email': email,
      'customer_mobile_number': mobileNumber,
      'alternet_mobile_number': alternateNumber,
      'customer_address': address,
      'gst_number': gstNumber,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'vehicles': vehicles?.map((x) => x.toJson()).toList(),
    };
  }

  static const empty = CustomerDetailsModel(
    id: 0,
    companyId: 0,
    address: "",
    createdAt: "",
    deletedAt: "",
    email: "",
    fullName: "",
    mobileNumber: "",
    alternateNumber: "",
    gstNumber: "",
    updatedAt: "",
  );

  @override
  String toString() =>
      '{id: $id,companyId:$companyId, address: $address,  createdAt: $createdAt, deletedAt: $deletedAt, email: $email, fullName: $fullName, mobileNumber: $mobileNumber,alternateNumber:$alternateNumber,gstNumber:$gstNumber, updatedAt: $updatedAt}';
}
