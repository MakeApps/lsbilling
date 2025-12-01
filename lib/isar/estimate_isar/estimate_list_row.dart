import 'package:isar_community/isar.dart';
import 'package:local_shout_billing/isar/isar_services.dart';

import 'estimate_list_isar.dart';

class EstimateListRowIsar extends IsarServices {
  Future<void> saveEstimateListing(EstimateListIsar estimate) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.estimateListIsars.put(estimate);
    });
  }

  Future<List<EstimateListIsar>> getSavedEstimate(
      {int offset = 0, int limit = 10}) async {
    final isar = await db;
    return await isar.estimateListIsars
        .filter()
        .vehicleNumberIsNotEmpty()
        .offset(offset)
        .limit(limit)
        .findAll();
  }
}
