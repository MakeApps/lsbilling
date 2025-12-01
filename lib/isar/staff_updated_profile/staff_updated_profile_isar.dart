import 'package:isar_community/isar.dart';

part 'staff_updated_profile_isar.g.dart';

@collection
@Name("StaffUpdatedProfileData")
class StaffUpdatedProfileData {
  @Index(unique: true)
  Id? id;
  String? staffUpdatedData;
  StaffUpdatedProfileData({this.id, this.staffUpdatedData});
}
