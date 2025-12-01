import 'package:equatable/equatable.dart';
import 'package:local_shout_billing/models/invoice_listing_model.dart';

class InvoiceGstCountModel extends Equatable {
  final int allInvoiceCount;
  final List<InvoiceListingModel> invoiceList;
  final int gstInvoiceCount;
  final int gstNonGstInvoiceCount;

  const InvoiceGstCountModel({
    required this.allInvoiceCount,
    required this.invoiceList,
    required this.gstInvoiceCount,
    required this.gstNonGstInvoiceCount,
  });

  static const empty = InvoiceGstCountModel(
    allInvoiceCount: 0,
    invoiceList: [],
    gstInvoiceCount: 0,
    gstNonGstInvoiceCount: 0,
  );
  factory InvoiceGstCountModel.fromJson(Map<String, dynamic> json) {
    final invoiceeList = !json.containsKey('Invoice')
        ? <InvoiceListingModel>[]
        : (json['Invoice'] as List<dynamic>)
            .map((e) => InvoiceListingModel.fromJson(e))
            .toList();

    return InvoiceGstCountModel(
      allInvoiceCount: json['all_invoice_count'] ?? 0,
      invoiceList: invoiceeList,
      gstInvoiceCount: json['gst_invoice_count'] ?? 0,
      gstNonGstInvoiceCount: json['non_gst_invoice_count'] ?? 0,
    );
  }

  // New copyWith method
  InvoiceGstCountModel copyWith({
    int? allInvoiceCount,
    List<InvoiceListingModel>? invoiceList,
    int? gstInvoiceCount,
    int? gstNonGstInvoiceCount,
  }) {
    return InvoiceGstCountModel(
      allInvoiceCount: allInvoiceCount ?? this.allInvoiceCount,
      invoiceList: invoiceList ?? this.invoiceList,
      gstInvoiceCount: gstInvoiceCount ?? this.gstInvoiceCount,
      gstNonGstInvoiceCount:
          gstNonGstInvoiceCount ?? this.gstNonGstInvoiceCount,
    );
  }

  @override
  List<Object?> get props => [
        allInvoiceCount,
        invoiceList,
        gstInvoiceCount,
        gstNonGstInvoiceCount,
      ];
}
