import 'dart:convert';

import 'package:equatable/equatable.dart';

class StaffModel extends Equatable {
  final int? id;
  final int? companyId;
  final Map<String, dynamic>? fullName;
  final Map<String, dynamic>? details;
  final String? name;
  final String? createdAt;
  final String? deletedAt;
  final String? email;
  final String? profilePic;
  final int? roleId;
  final int? timestamp;
  final String? updatedAt;

  const StaffModel({
    this.id,
    this.companyId,
    this.fullName,
    this.details,
    this.name,
    this.createdAt,
    this.deletedAt,
    this.email,
    this.profilePic,
    this.roleId,
    this.timestamp,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        companyId,
        fullName,
        details,
        name,
        createdAt,
        deletedAt,
        email,
        profilePic,
        roleId,
        timestamp,
        updatedAt,
      ];

  StaffModel copyWith({
    int? id,
    int? companyId,
    Map<String, dynamic>? fullName,
    Map<String, dynamic>? details,
    String? name,
    String? createdAt,
    String? deletedAt,
    String? email,
    String? profilePic,
    int? roleId,
    int? timestamp,
    String? updatedAt,
  }) {
    return StaffModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      fullName: fullName ?? this.fullName,
      details: details ?? this.details,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      roleId: roleId ?? this.roleId,
      timestamp: timestamp ?? this.timestamp,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json['id'],
      companyId: json['company_id'] ?? 0,
      fullName: json['full_name'] != null && json['full_name'] is String
          ? jsonDecode(json['full_name'])
          : {},
      details: json['details'] != null && json['details'] is String
          ? jsonDecode(json['details'])
          : {},
      name: json['name'] ?? "",
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      email: json['email'] ?? "",
      profilePic: json['profile_pic'] ?? "",
      roleId: json['role_id'] ?? "",
      timestamp: int.parse(json['timestamp'].toString()),
      updatedAt: json['updated_at'] ?? "",
    );
  }
  static const empty = StaffModel(
    id: 0,
    companyId: 0,
    fullName: {},
    details: {},
    name: "",
    createdAt: "",
    deletedAt: "",
    email: "",
    profilePic: "",
    roleId: 0,
    timestamp: 0,
    updatedAt: "",
  );

  @override
  String toString() =>
      '{id: $id,companyId:$companyId, fullName: $fullName,details:$details, name: $name, createdAt: $createdAt, deletedAt: $deletedAt, email: $email, profilePic: $profilePic, roleId: $roleId, timestamp: $timestamp, updatedAt: $updatedAt}';
}
