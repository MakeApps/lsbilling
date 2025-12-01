import 'dart:convert';

import 'package:equatable/equatable.dart';

class StaffProfileModel extends Equatable {
  final int? id;
  final int? companyId;
  final String? confirmPassword;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final Map<String, dynamic>? details;
  final String? email;
  final String? firstName;  
  final String? lastName;
  final String? middleName;
  final String? name;
  final String? password;
  final String? profilePic;
  final int? roleId;
  final String? updatedAt;
  final Map<String, dynamic>? fullName;

  const StaffProfileModel({
    this.id,
    this.companyId,
    this.confirmPassword,
    this.createdAtDate,
    this.createdAtTime,
    this.deletedAt,
    this.details,
    this.email,
    this.firstName,
    this.lastName,
    this.middleName,
    this.name,
    this.password,
    this.profilePic,
    this.roleId,
    this.updatedAt,
    this.fullName,
  });

  @override
  List<Object> get props => [
        id!,
        companyId!,
        confirmPassword!,
        createdAtDate!,
        createdAtTime!,
        deletedAt!,
        details!,
        email!,
        firstName!,
        lastName!,
        middleName!,
        name!,
        password!,
        profilePic!,
        roleId!,
        updatedAt!,
        fullName!,
      ];
  StaffProfileModel copyWith({
    int? id,
    int? companyId,
    String? confirmPassword,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    Map<String, dynamic>? details,
    String? email,
    String? firstName,
    String? lastName,
    String? middleName,
    String? name,
    String? password,
    String? profilePic,
    int? roleId,
    String? updatedAt,
    Map<String, dynamic>? fullName,
  }) {
    StaffProfileModel staffProfileModel = StaffProfileModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      deletedAt: deletedAt ?? this.deletedAt,
      details: details ?? this.details,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      name: name ?? this.name,
      password: password ?? this.password,
      profilePic: profilePic ?? this.profilePic,
      roleId: roleId ?? this.roleId,
      updatedAt: updatedAt ?? this.updatedAt,
      fullName: fullName ?? this.fullName,
    );
    return staffProfileModel;
  }

  factory StaffProfileModel.fromJson(Map<String, dynamic> json) {
    return StaffProfileModel(
        id: json['id'] ?? 0,
        companyId: json['company_id'] ?? 0,
        confirmPassword: json['confirmPassword'] ?? "",
        createdAtDate: json['created_at_date'] ?? "",
        createdAtTime: json['created_at_time'] ?? "",
        deletedAt: json['deleted_at'] ?? "",
        details: jsonDecode(json['details']) ?? {},
        email: json['email'] ?? "",
        firstName: json['first_name'] ?? "",
        lastName: json['last_name'] ?? "",
        middleName: json['middle_name'] ?? "",
        name: json['name'] ?? "",
        password: json['password'] ?? "",
        profilePic:
            json['profile_pic'] != null ? json['profile_pic'].toString() : "",
        roleId: json['role_id'] ?? 0,
        updatedAt: json['updated_at'] ?? "",
        fullName: jsonDecode(json['full_name']) ?? {});
  }
  static const empty = StaffProfileModel(
    id: 0,
    companyId: 0,
    confirmPassword: "",
    createdAtDate: "",
    createdAtTime: "",
    deletedAt: "",
    details: {},
    email: "",
    firstName: "",
    lastName: "",
    middleName: "",
    name: "",
    password: "",
    profilePic: "",
    roleId: 0,
    updatedAt: "",
    fullName: {},
  );
  @override
  String toString() {
    return '{id: $id, companyId: $companyId, confirmPassword: $confirmPassword, createdAtDate: $createdAtDate, createdAtTime: $createdAtTime, deletedAt: $deletedAt, details: $details, email: $email, firstName: $firstName, lastName: $lastName, middleName: $middleName, name: $name, password: $password, profilePic: $profilePic, roleId: $roleId, updatedAt: $updatedAt, fullName: $fullName}';
  }
}
