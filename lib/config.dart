import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_shout_billing/config/app_config.dart';
import 'package:local_shout_billing/config/utility.dart';
import 'package:local_shout_billing/internet/internet.dart';
import 'package:local_shout_billing/isar/admin_profile_information/profile_information_row.dart'
    as store_admin_profile_data;
import 'package:local_shout_billing/isar/isar_services.dart';
import 'package:local_shout_billing/isar/staff_updated_profile/staff_updated_profile_row.dart'
    as store_staff_profile_data;
import 'package:local_shout_billing/isar/update_jobcard_draft_isar/update_jobcard_isar_row.dart'
    as update_jobcard_isar_row_store;
import 'package:local_shout_billing/isar/update_profile_data/update_profile_row.dart'
    as store_updated_profile_data;

import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
// = = = =
import 'package:local_shout_billing/isar/admin_dashboard_isar/admin_dashboard_row.dart'
    as store_admin_data;

import 'config/due_utility.dart';

final Utility utility = Utility();
final DueUtility dueUtility = DueUtility();
final AppConfig appConfig = AppConfig();

// Internet related
final NetworkCheck networkCheck = NetworkCheck();

// Api Repository related
final JobSheetRepository jobSheetRepository = JobSheetRepository();

// local storage realated
FlutterSecureStorage storage = const FlutterSecureStorage();

// Isar related
var runningAppIsarServices = IsarServices();

final dashboardDataStore =
    store_admin_data.AdminDashboardRow(runningAppIsarServices.db);

final profileDataStore =
    store_admin_profile_data.AdminProfileInformation(runningAppIsarServices.db);

final updateDataStore =
    store_updated_profile_data.UpdateProfileRow(runningAppIsarServices.db);

final staffUpdatedStore =
    store_staff_profile_data.StaffUpdatedProfileRow(runningAppIsarServices.db);
final updateJobCardDraftIsarStore =
    update_jobcard_isar_row_store.UpdateJobCardDraftRow(
        runningAppIsarServices.db);
