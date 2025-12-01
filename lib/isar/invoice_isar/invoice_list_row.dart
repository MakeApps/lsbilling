import 'package:isar_community/isar.dart';
import 'package:local_shout_billing/isar/isar_services.dart';

import 'invoice_list_isar.dart';

class InvoiceListRowIsar extends IsarServices {
  Future<void> saveInvoiceListing(InvoiceListIsar invoice) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.invoiceListIsars.put(invoice);
    });
  }

  Future<List<InvoiceListIsar>> getSavedInvoice(
      {int offset = 0, int limit = 10}) async {
    final isar = await db;
    return await isar.invoiceListIsars
        .filter()
        .vehicleNumberIsNotEmpty()
        .offset(offset)
        .limit(10)
        .findAll();
  }
}
