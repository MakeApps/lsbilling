import 'package:isar_community/isar.dart';

part 'update_jobcard_isar.g.dart';

@collection
@Name("UpdateJobcardDraftIsar")
class UpdateJobcardDraftIsar {
  Id id = Isar.autoIncrement;
  String? jobcardId;
  String formData = "";
  String? frontImagePath;
  String? rightHandSideImagePath;
  String? leftHandSideImagePath;
  String? rearImagePath;
  String? dashboardImagePath;
  String? engineImagePath;
  String? batteryImagePath;
  String? speedometerImagePath;
  String? image1Path;
  String? image2Path;
  String? image3Path;
  String? image4Path;

  UpdateJobcardDraftIsar({
    this.jobcardId,
    this.formData = "",
    this.frontImagePath,
    this.rightHandSideImagePath,
    this.leftHandSideImagePath,
    this.rearImagePath,
    this.dashboardImagePath,
    this.engineImagePath,
    this.batteryImagePath,
    this.speedometerImagePath,
    this.image1Path,
    this.image2Path,
    this.image3Path,
    this.image4Path,
  });
}
