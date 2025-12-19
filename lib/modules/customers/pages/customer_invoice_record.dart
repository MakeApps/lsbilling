import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_details_bloc/customer_details_bloc.dart';
import 'package:local_shout_billing/modules/customers/pages/customer_invoice_row.dart';

class InvoiceDailog extends StatefulWidget {
  const InvoiceDailog({super.key});

  @override
  State<InvoiceDailog> createState() => _InvoiceDailogState();
}

class _InvoiceDailogState extends State<InvoiceDailog> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: whiteColor,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Invoice",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Expanded(
              child: BlocConsumer<CustomerDetailsBloc, CustomerDetailsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.estimateInvoiceStatus ==
                          EstimateInvoiceStatus.initial ||
                      state.estimateInvoiceStatus ==
                          EstimateInvoiceStatus.loading) {
                    return const Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Skeleton(),
                    );
                  }
                  return (state.estimateInvoiceStatus ==
                          EstimateInvoiceStatus.failure)
                      ? const NoDataFoundWidget()
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return (index >= state.invoiceCustList!.length)
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : CustomInvoiceRow(
                                    invoiceCustList:
                                        state.invoiceCustList![index]);
                          },
                          controller: scrollController,
                          itemCount: state.invoiceCustList!.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
