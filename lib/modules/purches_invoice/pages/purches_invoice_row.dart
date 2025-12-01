import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/models/purches_invoice_list_model.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice/purchase_invoice_bloc.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice_details_bloc/purches_invoice_details_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

class PurchesItemRow extends StatefulWidget {
  final PurchaseInvoiceModel? purchesItemData;
  const PurchesItemRow({super.key, required this.purchesItemData});

  @override
  State<PurchesItemRow> createState() => _PurchesItemRowState();
}

class _PurchesItemRowState extends State<PurchesItemRow> {
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
        Fluttertoast.cancel();
        context.read<PurchesInvoiceDetailsBloc>().add(
              GetPurchaseDetailsByID(
                id: widget.purchesItemData!.id.toString(),
              ),
            );
        Navigator.pushNamed(context, '/purchase_details_screen');
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Card(
            color: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.purchesItemData!.invoiceNumber
                                          .toString()
                                          .length ==
                                      1
                                  ? '#000${widget.purchesItemData!.invoiceNumber}'
                                  : '#00${widget.purchesItemData!.invoiceNumber}',
                              style: const TextStyle(
                                color: blueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.purchesItemData!.fullName.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: blackColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
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
                                      color: Colors.red, size: 18),
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
                              showDeleteDailog(context);
                            }
                          },
                          child: const Icon(
                            verticleDot,
                            color: hintTextColor,
                            size: 30
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoRow(
                        widget.purchesItemData!.mobileNumber.toString(),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.currency_rupee_sharp,
                              size: 14, color: blackColor),
                          Text(
                            widget.purchesItemData!.invoiceTotal.toString(),
                            style: const TextStyle(
                                color: blackColorDark,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  // Info rows
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow(widget.purchesItemData!.address.toString()),
                          _infoRow(widget.purchesItemData!.tempDate.toString()),
                        ],
                      ),

                      //
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String? value) {
    String displayValue =
        (value == null || value.trim().isEmpty || value == "null")
            ? "-"
            : value;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        displayValue,
        style: const TextStyle(
          fontSize: 14,
          color: blackColor,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }

  Future<void> showDeleteDailog(BuildContext context) async {
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
            "Are you sure you want to delete purchase invoice?",
            style: TextStyle(
                color: blackColorDark,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                context.read<PurchesInvoiceBloc>().add(
                      DeletePurchaseInvoice(
                        id: widget.purchesItemData!.id.toString(),
                      ),
                    );
                CenterLoader.show(context);
                await Future.delayed(const Duration(milliseconds: 500), () {
                  CenterLoader.hide();
                  Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_LONG,
                    msg: "Invoice deleted successfully",
                    backgroundColor: successDarkColor,
                  );
                  Navigator.pushNamed(context, '/purches_invoice_listing');
                });
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                backgroundColor: primaryColor,
                foregroundColor: blackColor,
              ),
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: blackColorDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
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
          ],
        );
      },
    );
  }
}
