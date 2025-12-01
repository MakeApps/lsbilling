import 'package:isar_community/isar.dart';
import 'package:local_shout_billing/isar/isar_services.dart';

import 'profile_information_isar.dart';

class AdminProfileInformation extends IsarServices {
  late final Future<Isar> dbConnection;

  AdminProfileInformation(Future<Isar> database) {
    dbConnection = database;
  }

  // save data
  Future<void> saveProfileInformation(
      ProfileInformationIsar profileData) async {
    final isar = await dbConnection;
    await isar.writeTxn(() async {
      await isar.profileInformationIsars.put(profileData);
    });
  }

  // Get user data
  Future<dynamic> getProfiledata() async {
    final isar = await dbConnection;
    dynamic result = await isar.profileInformationIsars
        .filter()
        .idGreaterThan(0)
        .findFirst();
    return result.profileInformation;
  }
}
