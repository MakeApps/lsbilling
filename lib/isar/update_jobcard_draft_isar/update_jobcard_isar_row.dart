import 'package:isar_community/isar.dart';
import 'package:local_shout_billing/isar/isar_services.dart';
import 'package:local_shout_billing/isar/update_jobcard_draft_isar/update_jobcard_isar.dart';

class UpdateJobCardDraftRow extends IsarServices {
  late final Future<Isar> dbConnection;

  UpdateJobCardDraftRow(Future<Isar> database) {
    dbConnection = database;
  }

  // save data
  Future<void> saveUpdateJobcardJsonResponse(
      UpdateJobcardDraftIsar updateJobCardIsar) async {
    final isar = await dbConnection;
    await isar.writeTxn(() async {
      await isar.updateJobcardDraftIsars.put(updateJobCardIsar);
    });
  }

  Future<List<UpdateJobcardDraftIsar>> getUpdateJobcardDrafts() async {
    final isar = Isar.getInstance();
    return await isar!.updateJobcardDraftIsars.where().findAll();
  }

  Future<void> deleteUpdateJobCardDraft(int id) async {
    final isar = Isar.getInstance();
    await isar!.writeTxn(() async {
      await isar.updateJobcardDraftIsars.delete(id);
    });
  }
}
