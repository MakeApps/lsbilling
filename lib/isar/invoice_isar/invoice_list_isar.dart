import 'package:isar_community/isar.dart';
part 'invoice_list_isar.g.dart';

@collection
@Name("InvoiceListIsar")
class InvoiceListIsar {
  @Index(unique: true)
  Id? id;
  String? address;
  String? createdAtTime;
  String? deletedAt;
  String? email;
  int? flag;
  String? fullname;
  String? invoiceTotal;
  String? afterDiscountAmount;
  String? afterPayTotalAmount;
  String? paidAmount;
  int? invoiceNumber;
  String? manufacturers;
  String? mobileNumber;
  String? tempDate;
  int? timestamp;
  String? updateAt;
  String? vehicleName;
  String? vehicleNumber;
  InvoiceListIsar({
    this.id,
    this.flag,
    this.fullname,
    this.manufacturers,
    this.invoiceTotal,
    this.afterDiscountAmount,
    this.afterPayTotalAmount,
    this.paidAmount,
    this.invoiceNumber,
    this.mobileNumber,
    this.updateAt,
    this.vehicleName,
    this.vehicleNumber,
    this.tempDate,
    this.timestamp,
    this.address,
    this.createdAtTime,
    this.deletedAt,
    this.email,
  });
}
