import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_details_bloc/customer_details_bloc.dart';
import 'package:local_shout_billing/modules/customers/pages/customer_estimate_recods.dart';
import 'package:local_shout_billing/modules/customers/pages/customer_invoice_record.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({super.key});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/customer_page');
        return true;
      },
      child: MainLayout(
        title: const Text(
          'Customer Details',
          style: TextStyle(
              fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
        ),
        showCurvedAppBar: true,
        showFloatingActionButton: false,
        showLeading: true,
        leading: IconButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/customer_page');
          },
          icon: const Icon(
            backarrow,
            color: whiteColor,
          ),
        ),
        showDefaultBottom: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
        body: BlocConsumer<CustomerDetailsBloc, CustomerDetailsState>(
            listener: (context, state) {
          if (state.customerDetailsStatus == GetCustomerStatusDetails.success) {
            CenterLoader.hide();
            state.customerDetailsList?.vehicles ?? [];
          }
        }, builder: (context, state) {
          final customer = state.customerDetailsList;
          final vehicles = customer?.vehicles ?? [];
          final hasVehicles = vehicles.isNotEmpty;
          if (state.customerDetailsStatus == GetCustomerStatusDetails.loading) {
            return const CenterLoader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsGeometry.only(left: 8, right: 8, top: 8),
              child: Card(
                color: whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.customerDetailsList!.fullName.toString(),
                              style: const TextStyle(
                                  color: blackColorDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: darkBlue,
                                size: 21,
                              ),
                              onPressed: () {
                                context.read<CustomerDetailsBloc>().add(
                                      GetCustomerDetail(
                                        id: state.customerDetailsList!.id
                                            .toString(),
                                      ),
                                    );
                                Navigator.pushNamed(
                                    context, '/edit_customer_info');
                              },
                            )
                          ]),
                      const SizedBox(height: 5),
                      Text(
                        state.customerDetailsList!.address.toString(),
                        style: const TextStyle(
                            color: blackColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final email = state.customerDetailsList?.email;

                              if (email == null || email.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Email address not available'),
                                    backgroundColor: redColor,
                                  ),
                                );
                                return;
                              }

                              final Uri emailUri = Uri(
                                scheme: 'mailto',
                                path: email,
                              );

                              if (await canLaunchUrl(emailUri)) {
                                await launchUrl(emailUri);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Unable to open email app'),
                                    backgroundColor: redColor,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: dashboardbox1,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 17,
                                    color: redColor,
                                  ),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        color: redColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () async {
                              final phone =
                                  state.customerDetailsList?.mobileNumber;

                              if (phone == null || phone.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Mobile number not available'),
                                    backgroundColor: redColor,
                                  ),
                                );
                                return;
                              }

                              final Uri callUri = Uri(
                                scheme: 'tel',
                                path: phone,
                              );

                              if (await canLaunchUrl(callUri)) {
                                await launchUrl(callUri);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Unable to open dialer'),
                                    backgroundColor: redColor,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: blurLightColor.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.call,
                                    size: 17,
                                    color: blueColor,
                                  ),
                                  Text(
                                    "Call",
                                    style: TextStyle(
                                        color: blueColor, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "List",
                        style: TextStyle(
                            color: blackColorDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 25),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: hintTextColor),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<CustomerDetailsBloc>().add(
                                      FetchEstimateInvoice(
                                        filter: "Estimate",
                                        vehicleId: state.customerDetailsList!
                                            .vehicles!.first.estimateCount,
                                        customerId: state
                                            .customerDetailsList!.id
                                            .toString(),
                                      ),
                                    );

                                /// Open dialog
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const EstimateDialog(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: redColor),
                                  color: dashboardbox1,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Image.asset(
                                        "assets/icons/estimate.png",
                                        color: redColor,
                                        height: 21,
                                        width: 21,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Estimate: ",
                                      style: TextStyle(
                                          color: redColor, fontSize: 16),
                                    ),
                                    Text(
                                      hasVehicles
                                          ? vehicles.last.estimateCount
                                              .toString()
                                          : "0",
                                      style: const TextStyle(
                                          color: blackColorDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                context.read<CustomerDetailsBloc>().add(
                                      FetchEstimateInvoice(
                                        filter: "Invoice",
                                        vehicleId: state.customerDetailsList!
                                            .vehicles!.last.invoiceCount,
                                        customerId: state
                                            .customerDetailsList!.id
                                            .toString(),
                                      ),
                                    );
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const InvoiceDailog(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: dashboardbox3),
                                  color: dashboardbox4,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 23,
                                      width: 23,
                                      child: Image.asset(
                                        "assets/icons/invoice.png",
                                        color: dashboardbox3,
                                        height: 21,
                                        width: 21,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Invoice: ",
                                      style: TextStyle(
                                          color: dashboardbox3, fontSize: 16),
                                    ),
                                    Text(
                                      hasVehicles
                                          ? vehicles.last.invoiceCount
                                              .toString()
                                          : "0",
                                      style: const TextStyle(
                                          color: blackColorDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
