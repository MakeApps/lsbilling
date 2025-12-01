import 'package:isar_community/isar.dart';
import 'package:local_shout_billing/isar/isar_services.dart';

import 'update_profile_data_isar.dart';

class UpdateProfileRow extends IsarServices {
  late final Future<Isar> dbConnection;

  UpdateProfileRow(Future<Isar> database) {
    dbConnection = database;
  }

  Future<void> saveUpdatedProfileData(UpdateProfileData updatedData) async {
    final isar = await dbConnection;
    await isar.writeTxn(() async {
      await isar.updateProfileDatas.put(updatedData);
    });
  }

  Future<dynamic> getUpdatedDataFromLocal() async {
    final isar = await dbConnection;
    dynamic result =
        await isar.updateProfileDatas.filter().idGreaterThan(0).findFirst();
    return result.updateProfileInfo;
  }
}
