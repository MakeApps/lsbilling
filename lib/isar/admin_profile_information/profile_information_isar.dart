import 'package:isar_community/isar.dart';
part 'profile_information_isar.g.dart';

@collection
@Name("ProfileInformationIsar")
class ProfileInformationIsar {
  @Index(unique: true)
  Id? id;
  String? profileInformation;
  ProfileInformationIsar(
      {this.id,
      this.profileInformation
      });
}
