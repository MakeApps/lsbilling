import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/models/stock_vendor_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/modules/vendor/bloc/vendor_bloc/vendor_bloc.dart';
import 'package:local_shout_billing/modules/vendor/bloc/vendor_details_bloc/vendor_details_bloc.dart';

class VendorListRow extends StatefulWidget {
  final StockVendorModel? vendorRowDetails;
  const VendorListRow({super.key, this.vendorRowDetails});

  @override
  State<VendorListRow> createState() => _VendorListRowState();
}

class _VendorListRowState extends State<VendorListRow> {
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
        context.read<VendorDetailsBloc>().add(
              GetVendorsData(
                id: widget.vendorRowDetails!.id.toString(),
              ),
            );
        Navigator.pushNamed(context, '/vendor_details_date');
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: Card(
            shape: const RoundedRectangleBorder(),
            shadowColor: greyColor,
            color: whiteColor,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Wrap(
                              children: [
                                Text(
                                  widget.vendorRowDetails!.vendorName
                                      .toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: blackColor,
                                      fontFamily: 'Mulish',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          color: whiteColor,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          itemBuilder: (context) {
                            final items = <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit,
                                        size: 18, color: blackColorDark),
                                    SizedBox(width: 8),
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: blackColorDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ];

                            if (roleId != null && roleId != '4') {
                              items.add(
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete,
                                          size: 18, color: Colors.red),
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
                              );
                            }

                            return items;
                          },
                          onSelected: (value) {
                            if (value == 'edit') {
                              context.read<VendorDetailsBloc>().add(
                                    GetVendorsData(
                                      id: widget.vendorRowDetails!.id
                                          .toString(),
                                    ),
                                  );
                              Navigator.pushNamed(
                                  context, '/vendor_details_date');
                            } else if (value == 'delete') {
                              showDeleteDailog(context);
                            }
                          },
                          child: const Icon(verticleDot,
                              color: hintTextColor, size: 30),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Mobile Number:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 13, color: blackColorLight),
                                ),
                                widget.vendorRowDetails!.phoneNumber
                                        .toString()
                                        .isNotEmpty
                                    ? Text(
                                        widget.vendorRowDetails!.phoneNumber
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: blackColorDark),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Email:",
                                  style: TextStyle(
                                      fontSize: 13, color: blackColorLight),
                                ),
                                widget.vendorRowDetails!.email
                                        .toString()
                                        .isNotEmpty
                                    ? Text(
                                        widget.vendorRowDetails!.email
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: blackColorDark),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "GSTIN:",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: blackColorLight,
                                  ),
                                ),
                                widget.vendorRowDetails!.gstNumber
                                        .toString()
                                        .isNotEmpty
                                    ? Text(
                                        widget.vendorRowDetails!.gstNumber
                                            .toString()
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: blackColorDark,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Address:",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: blackColorLight,
                                  ),
                                ),
                                widget.vendorRowDetails!.address
                                        .toString()
                                        .isNotEmpty
                                    ? Text(
                                        widget.vendorRowDetails!.address
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: blackColorDark,
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteDailog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          title: const Text(
            "Are you sure you want to delete vendor?",
            style: TextStyle(
                color: darkColor, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                context.read<VendorBloc>().add(
                      DeleteVendorRecord(
                        id: widget.vendorRowDetails!.id.toString(),
                      ),
                    );
                CenterLoader.show(context);
                await Future.delayed(
                  const Duration(seconds: 3),
                );
                context.read<VendorBloc>().add(
                      const FetchVendorList(status: VendorStatus.success),
                    );
                Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_LONG,
                    msg: "Vendor deleted successfully",
                    backgroundColor: successDarkColor);
                CenterLoader.hide();
                Navigator.pushNamed(context, '/vendor_listing');
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  backgroundColor: primaryColor,
                  foregroundColor: whiteColor),
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
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
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }
}
