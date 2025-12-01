import 'package:isar_community/isar.dart';

part 'update_profile_data_isar.g.dart';

@collection
@Name("UpdateProfileData")
class UpdateProfileData {
  @Index(unique: true)
  Id? id;
  String? updateProfileInfo;
  UpdateProfileData({this.id, this.updateProfileInfo});
}
