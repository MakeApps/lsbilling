import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/models/invoice_listing_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_bloc/job_sheet_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';
import '../../config/app_icons.dart';

class InvoiceListRow extends StatefulWidget {
  final InvoiceListingModel? invoiceList;
  const InvoiceListRow({super.key, this.invoiceList});

  @override
  State<InvoiceListRow> createState() => _InvoiceListRowState();
}

class _InvoiceListRowState extends State<InvoiceListRow> {
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
        context.read<JobSheetDetailsBloc>().add(
              GetInvoiceByInvoice(
                id: widget.invoiceList!.id.toString(),
              ),
            );
        Navigator.pushNamed(context, '/invoice_details_page');
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
                      Flexible(
                        // Wraps the left column so it doesn't push out the Row
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.invoiceList!.invoiceNumber
                                              .toString()
                                              .length ==
                                          1
                                      ? '#000${widget.invoiceList!.invoiceNumber}'
                                      : '#00${widget.invoiceList!.invoiceNumber}',
                                  style: const TextStyle(
                                    color: blueColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.invoiceList!.fullname.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: blackColor,
                              ),
                              maxLines: 1, // single line
                              overflow:
                                  TextOverflow.ellipsis, // truncate with ...
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          if (widget.invoiceList!.paymentStatus != null &&
                              widget.invoiceList!.paymentStatus!.isNotEmpty &&
                              widget.invoiceList!.paymentStatus!
                                      .toLowerCase() !=
                                  'null')
                            SizedBox(
                              width: 100,
                              height: 35,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                    widget.invoiceList!.paymentStatus ==
                                            "Unpaid"
                                        ? Colors.red
                                        : widget.invoiceList!.paymentStatus ==
                                                "Paid"
                                            ? Colors.green
                                            : Colors.orange,
                                  ),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                    widget.invoiceList!.paymentStatus ==
                                            "Unpaid"
                                        ? Colors.red.shade100
                                        : widget.invoiceList!.paymentStatus ==
                                                "Paid"
                                            ? Colors.green.shade100
                                            : Colors.orange.shade100,
                                  ),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  widget.invoiceList!.paymentStatus.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 3,
                          ),
                          if (roleId != null && roleId != '4')
                            PopupMenuButton<String>(
                              elevation: 6, // shadow
                              color: whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    color: Colors.black12, width: 1),
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete,
                                          color: redColor, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: blackColorDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 'delete') {
                                  showExitConfirmation(context);
                                }
                              },
                              child: const Icon(
                                verticleDot,
                                color: hintTextColor,
                                size: 30,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: whiteColor,
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
                        widget.invoiceList!.email.toString(),
                        style: const TextStyle(
                            color: blackColor,
                            fontSize: 14,
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
                      Expanded(
                          child: Row(
                        children: [
                          const Icon(
                            call,
                            size: 17,
                            color: hintTextColor,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget.invoiceList!.manufacturers.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: blackColorDark,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.invoiceList!.mobileNumber.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: blackColorDark,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            currency,
                            size: 14,
                            color: blackColor,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            (widget.invoiceList!.invoiceTotal == 'null' ||
                                    widget.invoiceList!.afterDiscountAmount ==
                                        null)
                                ? '0.00'
                                : double.parse(widget
                                        .invoiceList!.afterDiscountAmount!)
                                    .toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 13,
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                            Icons.calendar_month,
                            size: 16,
                            color: hintTextColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.invoiceList!.tempDate.toString(),
                            style: const TextStyle(
                                color: blackColor, fontSize: 13),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showExitConfirmation(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          title: const Text(
            "Are you sure you want to delete?",
            style: TextStyle(
                color: blackColorDark,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
                backgroundColor: whiteColor,
                side: const BorderSide(color: primaryColor, width: 1),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: blackColorDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<JobSheetBloc>().add(
                      DeleteInvoice(
                        id: widget.invoiceList!.id.toString(),
                      ),
                    );
                CenterLoader.hide();
                context.read<JobSheetBloc>().add(
                      const FetchInvoiceList(status: JobSheetStatus.success),
                    );
                Navigator.pushNamed(context, '/invoice_page_listing');
                Fluttertoast.showToast(
                  toastLength: Toast.LENGTH_LONG,
                  msg: "Invoice deleted successfully",
                  backgroundColor: successDarkColor,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                backgroundColor: primaryColor,
                foregroundColor: whiteColor,
              ),
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
          ],
        );
      },
    );
  }
}
