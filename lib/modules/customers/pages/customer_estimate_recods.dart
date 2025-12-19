import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_details_bloc/customer_details_bloc.dart';
import 'package:local_shout_billing/modules/customers/pages/customer_estimate_row.dart';

class EstimateDialog extends StatefulWidget {
  const EstimateDialog({super.key});

  @override
  State<EstimateDialog> createState() => _EstimateDialogState();
}

class _EstimateDialogState extends State<EstimateDialog> {
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
                  "Estimate",
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
                            return (index >= state.estimateCustList!.length)
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : CustomEstimateRow(
                                    estimateCustList:
                                        state.estimateCustList![index]);
                          },
                          controller: scrollController,
                          itemCount: state.estimateCustList!.length,
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
