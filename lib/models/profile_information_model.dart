import 'package:equatable/equatable.dart';

import '../isar/admin_profile_details/admin_profile_details.dart';
import '../isar/admin_profile_fullname/profile_fullname_isar.dart';

class ProfileInformationModel extends Equatable {
  final int? id;
  final int? companyId;
  final String? companyLogo;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? companyType;
  final String? deletedAt;
  final List<Details>? details;
  final String? email;
  final String? firstname;
  final int? flag;
  final List<FullName>? fullName;
  final String? name;
  final String? profilePic;
  final int? rollId;
  final String? subscriptionEnd;
  final String? subscriptionStart;
  final String? updatedAt;

  const ProfileInformationModel(
      {this.id,
      this.deletedAt,
      this.email,
      this.fullName,
      this.companyId,
      this.companyLogo,
      this.createdAtDate,
      this.companyType,
      this.createdAtTime,
      this.details,
      this.firstname,
      this.flag,
      this.name,
      this.profilePic,
      this.rollId,
      this.subscriptionEnd,
      this.subscriptionStart,
      this.updatedAt});

  @override
  List<Object> get props => [
        id!,
        deletedAt!,
        email!,
        fullName!,
        companyId!,
        createdAtDate!,
        createdAtTime!,
        companyType!,
        details!,
        companyLogo!,
        firstname!,
        flag!,
        name!,
        profilePic!,
        rollId!,
        subscriptionEnd!,
        subscriptionStart!,
        updatedAt!
      ];
  ProfileInformationModel copyWith({
    int? id,
    int? companyId,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    String? companyType,
    List<Details>? details,
    String? email,
    String? companyLogo,
    String? firstname,
    int? flag,
    List<FullName>? fullName,
    String? name,
    String? profilePic,
    int? rollId,
    String? subscriptionEnd,
    String? subscriptionStart,
    String? updatedAt,
  }) {
    ProfileInformationModel profileInformationModel = ProfileInformationModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      companyType: companyType ?? this.companyType,
      details: details ?? this.details,
      firstname: firstname ?? this.firstname,
      flag: flag ?? flag,
      fullName: fullName ?? this.fullName,
      companyLogo: companyLogo ?? this.companyLogo,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      rollId: rollId ?? this.rollId,
      subscriptionEnd: subscriptionEnd ?? this.subscriptionEnd,
      subscriptionStart: subscriptionStart ?? this.subscriptionStart,
      deletedAt: deletedAt ?? this.deletedAt,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return profileInformationModel;
  }

  factory ProfileInformationModel.fromJson(Map<String, dynamic> json) {
    List<Details> detailsList = [];
    if (json['details'] != null && json['details'] is List) {
      for (var details in json['details']) {
        detailsList.add(Details.fromJson(details));
      }
    }

    List<FullName> nameList = [];
    if (json['full_name'] != null && json['full_name'] is List) {
      for (var name in json['full_name']) {
        nameList.add(FullName.fromJson(name));
      }
    }
    return ProfileInformationModel(
      id: json['id'] ?? 0,
      companyId: json['company_id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      companyType: json['company_type'] ?? "",
      email: json['email'] ?? "",
      details: detailsList,
      firstname: json['first_name'] ?? "",
      flag: json['flag'] != null ? int.tryParse(json['flag'].toString()) ?? 0 : 0,
      fullName: nameList,
      companyLogo: json['company_logo'],
      name: json['name'] ?? "",
      profilePic: json['profile_pic'] ?? "",
      rollId: json['role_id'] ?? 0,
      subscriptionEnd: json['sub_end'] ?? "",
      subscriptionStart: json['sub_start'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  static const empty = ProfileInformationModel(
    id: 0,
    companyId: 0,
    createdAtDate: "",
    createdAtTime: "",
    companyType: "",
    details: [],
    firstname: "",
    flag: 0,
    fullName: [],
    name: "",
    profilePic: "",
    companyLogo: "",
    rollId: 0,
    subscriptionEnd: "",
    subscriptionStart: "",
    deletedAt: "",
    email: "",
    updatedAt: "",
  );

  @override
  String toString() =>
      '{id: $id,companyId:$companyId,createdAtDate:$createdAtDate,createdAtTime:$createdAtTime,companyType:$companyType,companyLogo:$companyLogo,profilePic:$profilePic, details:$details,  email:$email ,firstname:$firstname, flag:$flag,fullName:$fullName,name:$name, rollId:$rollId, subscriptionEnd:$subscriptionEnd,subscriptionStart:$subscriptionStart, deletedAt:$deletedAt,updatedAt:$updatedAt}';
}
//flag: json['flag'] != null ? int.tryParse(json['flag'].toString()) ?? 0 : 0,