import 'package:isar_community/isar.dart';
import 'package:local_shout_billing/isar/isar_services.dart';
import 'admin_dashboard_isar.dart';

class AdminDashboardRow extends IsarServices {
  late final Future<Isar> dbConnection;

  AdminDashboardRow(Future<Isar> database) {
    dbConnection = database;
  }

  // save data
  Future<void> saveDashboardResponse(DashboardIsar dashboardData) async {
    final isar = await dbConnection;
    await isar.writeTxn(() async {
      await isar.dashboardIsars.put(dashboardData);
    });
  }

  // Get dashboard data
  Future<DashboardIsar?> getDashboardData() async {
    final isar = await dbConnection;
    final result = await isar.dashboardIsars.get(1);
    return result;
  }
}
