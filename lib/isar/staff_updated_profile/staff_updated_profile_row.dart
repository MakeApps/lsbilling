import 'package:isar_community/isar.dart';
import 'package:local_shout_billing/isar/isar_services.dart';

import 'staff_updated_profile_isar.dart';

class StaffUpdatedProfileRow extends IsarServices {
  late final Future<Isar> dbConnection;

  StaffUpdatedProfileRow(Future<Isar> database) {
    dbConnection = database;
  }
  Future<void> saveStaffUpatedData(
      StaffUpdatedProfileData staffProfileData) async {
    final isar = await dbConnection;
    await isar.writeTxn(() async {
      await isar.staffUpdatedProfileDatas.put(staffProfileData);
    });
  }

  Future<dynamic> getStaffUpdatedDataFromLocal() async {
    final isar = await dbConnection;
    dynamic result = await isar.staffUpdatedProfileDatas
        .filter()
        .idGreaterThan(0)
        .findFirst();
    return result.staffUpdatedData;
  }
}
