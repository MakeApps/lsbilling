import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/models/customer_model.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_details_bloc/customer_details_bloc.dart';
import '../../job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

class CustomerDetailsRow extends StatefulWidget {
  final CustomerModel? customerListing;
  const CustomerDetailsRow({super.key, this.customerListing});

  @override
  State<CustomerDetailsRow> createState() => _CustomerDetailsRowState();
}

class _CustomerDetailsRowState extends State<CustomerDetailsRow> {
  final _formKey = GlobalKey<FormState>();
  String? roleId;

  @override
  void initState() {
    super.initState();
    _loadRoleId();
  }

  Future<void> _loadRoleId() async {
    final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');
    setState(() {
      roleId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CustomerDetailsBloc>().add(
              GetCustomerDetail(
                id: widget.customerListing!.id.toString(),
              ),
            );
        Navigator.pushNamed(context, '/customer_details_screen');
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
          child: Card(
            color: whiteColor,
            shape: const RoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.customerListing!.fullName.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: blackColor),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CustomerDetailsBloc>().add(
                                    GetCustomerDetail(
                                      id: widget.customerListing!.id.toString(),
                                    ),
                                  );
                              Navigator.pushNamed(
                                  context, '/edit_customer_info');
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                              color: blackColor,
                            ),
                          ),
                          PopupMenuButton<String>(
                            color: whiteColor,
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'estimate',
                                child: Text('Estimate'),
                              ),
                              PopupMenuItem(
                                value: 'invoice',
                                child: Text('Invoice'),
                              ),
                            ],
                            onSelected: (value) async {
                              final result =
                                  await showBillingTypeDialog(context);

                              if (result != null) {
                                String? billingType = result["billingType"];
                                String? igst = result["igst"];

                                String gstBill = "0";

                                if (billingType == "gst") {
                                  gstBill = "1"; // GST Invoice
                                }

                                Map<String, dynamic> formData = {
                                  "id": "",
                                  "gst_bill": gstBill,
                                  "igst": billingType == "regular" ? "0" : igst,
                                };
                                context.read<JobSheetDetailsBloc>().add(
                                      UpdateGstBillEvent(
                                        source: value == "estimate"
                                            ? GstActionSource.estimate
                                            : GstActionSource.invoice,
                                        id: widget.customerListing!.id
                                            .toString(),
                                        formData: formData,
                                      ),
                                    );

                                if (value == "estimate") {
                                  context.read<JobSheetDetailsBloc>().add(
                                        GetEstimateDetailsByJobSheet(
                                          id: widget.customerListing!.id
                                              .toString(),
                                        ),
                                      );
                                  Navigator.pushNamed(
                                      context, '/generate_estimate');
                                } else {
                                  context.read<JobSheetDetailsBloc>().add(
                                        GetInvoiceByJobSheet(
                                          id: widget.customerListing!.id
                                              .toString(),
                                        ),
                                      );
                                  Navigator.pushNamed(
                                      context, '/customer_invoice_page');
                                }
                              }
                            },
                            child: const Icon(verticleDot, size: 30),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        mailIcon,
                        size: 17,
                        color: hintTextColor,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        widget.customerListing!.email.toString(),
                        style: const TextStyle(
                            color: blackColorDark,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            call,
                            color: blackColorLight,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.customerListing!.mobileNumber.toString(),
                            style: const TextStyle(
                                fontSize: 13,
                                color: blackColorDark,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            address,
                            color: blackColorLight,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.customerListing!.address.toString(),
                            style: const TextStyle(
                                fontSize: 13,
                                color: blackColorDark,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, String>?> showBillingTypeDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String billingType = "gst";
        String gstOption = "CGST/SGST";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Billing Type",
                    style: TextStyle(
                        fontSize: 15,
                        color: blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 20, color: blackColor),
                  )
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Regular Invoice
                  RadioListTile(
                    title: const Text(
                      "Regular Invoice",
                      style: TextStyle(
                          fontSize: 13,
                          color: blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    value: "regular",
                    groupValue: billingType,
                    onChanged: (value) =>
                        setState(() => billingType = value.toString()),
                  ),

                  /// GST Invoice
                  RadioListTile(
                    title: const Text(
                      "GST Invoice",
                      style: TextStyle(
                          fontSize: 13,
                          color: blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    value: "gst",
                    groupValue: billingType,
                    onChanged: (value) =>
                        setState(() => billingType = value.toString()),
                  ),

                  const SizedBox(height: 10),

                  /// Dropdown only when GST Invoice selected
                  if (billingType == "gst") ...[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select:",
                        style: TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(color: hintTextColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: gstOption,
                          items: const [
                            DropdownMenuItem(
                              value: "CGST/SGST",
                              child: Text(
                                "CGST/SGST",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "IGST",
                              child: Text(
                                "IGST",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                          onChanged: (val) =>
                              setState(() => gstOption = val.toString()),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 13,
                              color: bluecolorprimary,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(primaryColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 13,
                              color: whiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.pop(
                            context,
                            {
                              "billingType": billingType,
                              "igst": gstOption == "IGST" ? "1" : "0"
                            },
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
