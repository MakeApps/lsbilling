import 'package:isar_community/isar.dart';

part 'admin_dashboard_isar.g.dart';

@collection
@Name("DashboardIsar")
class DashboardIsar {
  Id id = 0;
  int delivered = 0;
  int newEntries = 0;
  int totalCustomer = 0;
  int totalEstimate = 0;
  int totalInvoice = 0;
  int totalLabour = 0;
  int totalMechanic = 0;
  int totalProduct = 0;
  int totalRepair = 0;
  int totalSparePart = 0;
  int totalVehicle = 0;
  int userCount = 0;
  int customerCountFilter = 0;
  int estimateCountFilter = 0;
  int invoiceCountFilter = 0;
  int jobcardCountFilter = 0;
  int totalOutstanding = 0;
  int totalRevenue = 0;
  DashboardIsar({
    this.id = 0,
    this.delivered = 0,
    this.newEntries = 0,
    this.totalCustomer = 0,
    this.totalEstimate = 0,
    this.totalInvoice = 0,
    this.totalLabour = 0,
    this.totalMechanic = 0,
    this.totalProduct = 0,
    this.totalRepair = 0,
    this.totalSparePart = 0,
    this.totalVehicle = 0,
    this.userCount = 0,
    this.customerCountFilter = 0,
    this.estimateCountFilter = 0,
    this.invoiceCountFilter = 0,
    this.jobcardCountFilter = 0,
    this.totalOutstanding = 0,
    this.totalRevenue = 0,
  });
}
