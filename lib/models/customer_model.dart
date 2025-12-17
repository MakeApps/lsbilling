import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final int? id;
  final String? address;
  final String? createdAt;
  final String? deletedAt;
  final String? email;
  final String? fullName;
  final String? mobileNumber;
  final String? gstNumber;
  final int? timestamp;
  final String? updatedAt;

  const CustomerModel(
      {this.id,
      this.address,
      this.createdAt,
      this.deletedAt,
      this.email,
      this.fullName,
      this.mobileNumber,
      this.gstNumber,
      this.timestamp,
      this.updatedAt});

  @override
  List<Object> get props => [
        id!,
        address!,
        createdAt!,
        deletedAt!,
        email!,
        fullName!,
        mobileNumber!,
        gstNumber!,
        timestamp!,
        updatedAt!
      ];

  CustomerModel copyWith(
      {int? id,
      String? address,
      String? createdAt,
      String? deletedAt,
      String? email,
      String? fullName,
      String? mobileNumber,
      String? gstNumber,
      int? timestamp,
      String? updatedAt}) {
    CustomerModel customerModel = CustomerModel(
      id: id ?? this.id,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      gstNumber: gstNumber ?? this.gstNumber,
      timestamp: timestamp ?? this.timestamp,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return customerModel;
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      address: json['address'] ?? "",
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      fullName: json['full_name'] ?? "",
      mobileNumber: json['mobile_number'] ?? "",
      gstNumber: json['gst_number'] ?? "",
     timestamp: int.parse(json['timestamp'].toString()),
      updatedAt: json['updated_at'] ?? "",
    );
  }

  static const empty = CustomerModel(
    id: 0,
    address: "",
    createdAt: "",
    deletedAt: "",
    email: "",
    fullName: "",
    mobileNumber: "",
    gstNumber: "",
    timestamp: 0,
    updatedAt: "",
  );

  @override
  String toString() =>
      '{id: $id, address: $address,  createdAt: $createdAt, deletedAt: $deletedAt, email: $email, fullName: $fullName, mobileNumber: $mobileNumber,gstNumber:$gstNumber,timestamp:$timestamp, updatedAt: $updatedAt}';
}
