import 'package:isar_community/isar.dart';
part 'estimate_list_isar.g.dart';

@collection
@Name("EstimateListIsar")
class EstimateListIsar {
  @Index(unique: true)
  Id? id;
  String? address;
  String? createdAtTime;
  String? deletedAt;
  String? email;
  String? estimateTotal;
  int? estimateNumber;
  int? flag;
  String? kms;
  String? fullname;
  String? manufacturers;
  String? mobileNumber;
  String? tempDate;
  String? timestamp;
  String? updateAt;
  String? vehicleName;
  String? vehicleNumber;
  EstimateListIsar(
      {this.id,
      this.estimateTotal,
      this.estimateNumber,
      this.flag,
      this.kms,
      this.fullname,
      this.manufacturers,
      this.mobileNumber,
      this.updateAt,
      this.vehicleName,
      this.vehicleNumber,
      this.address,
      this.createdAtTime,
      this.deletedAt,
      this.email,
      this.tempDate,
      this.timestamp});
}