import 'package:local_shout_billing/isar/admin_dashboard_isar/admin_dashboard_isar.dart';
import 'package:local_shout_billing/isar/staff_updated_profile/staff_updated_profile_isar.dart';
import 'package:local_shout_billing/isar/update_jobcard_draft_isar/update_jobcard_isar.dart';
import 'package:local_shout_billing/isar/update_profile_data/update_profile_data_isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:local_shout_billing/isar/estimate_isar/estimate_list_isar.dart';
import 'package:local_shout_billing/isar/invoice_isar/invoice_list_isar.dart';
import 'package:local_shout_billing/config/constants.dart';
import 'package:isar_community/isar.dart';

import 'admin_profile_information/profile_information_isar.dart';

class IsarServices {
  late Future<Isar> db;

  IsarServices() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          EstimateListIsarSchema,
          InvoiceListIsarSchema,
          DashboardIsarSchema,
          ProfileInformationIsarSchema,
          UpdateProfileDataSchema,
          StaffUpdatedProfileDataSchema,
          UpdateJobcardDraftIsarSchema
        ],
        directory: dir.path,
        inspector:
            (Constants.appEnv == "local" || Constants.appEnv == "staging")
                ? true
                : false,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
