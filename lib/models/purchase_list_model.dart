import 'package:equatable/equatable.dart';
import 'package:local_shout_billing/models/purches_invoice_list_model.dart';

class PurchaseInvoiceModelList extends Equatable {
  final int allPurchaseCount;
  final List<PurchaseInvoiceModel> purchaseInvoiceeList;
  final int gstPurchaseInvoiceCount;
  final int nonGstPurchaseInvoiceCount;

  const PurchaseInvoiceModelList({
    required this.allPurchaseCount,
    required this.purchaseInvoiceeList,
    required this.gstPurchaseInvoiceCount,
    required this.nonGstPurchaseInvoiceCount,
  });

  static const empty = PurchaseInvoiceModelList(
    allPurchaseCount: 0,
    purchaseInvoiceeList: [],
    gstPurchaseInvoiceCount: 0,
    nonGstPurchaseInvoiceCount: 0,
  );
  factory PurchaseInvoiceModelList.fromJson(Map<String, dynamic> json) {
    final purchaseList = !json.containsKey('PurchaseInvoice')
        ? <PurchaseInvoiceModel>[]
        : (json['PurchaseInvoice'] as List<dynamic>)
            .map((e) => PurchaseInvoiceModel.fromJson(e))
            .toList();

    return PurchaseInvoiceModelList(
      allPurchaseCount: json['all_purchase_invoice_count'] ?? 0,
      purchaseInvoiceeList: purchaseList,
      gstPurchaseInvoiceCount: json['gst_purchase_invoice_count'] ?? 0,
      nonGstPurchaseInvoiceCount: json['non_gst_purchase_invoice_count'] ?? 0,
    );
  }

  // New copyWith method
  PurchaseInvoiceModelList copyWith({
    int? allPurchaseCount,
    List<PurchaseInvoiceModel>? purchaseInvoiceeList,
    int? gstPurchaseInvoiceCount,
    int? nonGstPurchaseInvoiceCount,
  }) {
    return PurchaseInvoiceModelList(
      allPurchaseCount: allPurchaseCount ?? this.allPurchaseCount,
      purchaseInvoiceeList: purchaseInvoiceeList ?? this.purchaseInvoiceeList,
      gstPurchaseInvoiceCount:
          gstPurchaseInvoiceCount ?? this.gstPurchaseInvoiceCount,
      nonGstPurchaseInvoiceCount:
          nonGstPurchaseInvoiceCount ?? this.nonGstPurchaseInvoiceCount,
    );
  }

  @override
  List<Object?> get props => [
        allPurchaseCount,
        purchaseInvoiceeList,
        gstPurchaseInvoiceCount,
        nonGstPurchaseInvoiceCount,
      ];
}
