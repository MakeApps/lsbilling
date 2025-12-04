import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice_details_bloc/purches_invoice_details_bloc.dart';
import 'package:local_shout_billing/modules/purches_invoice/components/add_spare_part_dialog.dart';
import 'package:local_shout_billing/modules/purches_invoice/components/edit_product_dailog.dart';
import 'package:local_shout_billing/modules/purches_invoice/components/edit_product_with_gst.dart';

class PurchesInvoiceDetailScreen extends StatefulWidget {
  const PurchesInvoiceDetailScreen({
    super.key,
  });

  @override
  State<PurchesInvoiceDetailScreen> createState() =>
      _PurchesInvoiceDetailScreenState();
}

class _PurchesInvoiceDetailScreenState
    extends State<PurchesInvoiceDetailScreen> {
  final formKey = GlobalKey<FormState>();
  List<dynamic> sparePartsList = [];
  List<dynamic> sparePartsListNew = [];
  List<dynamic> sparePart = [];
  bool isQuantityHidden = false;
  String? gstFlag;
  String? gstBill;
  int updateIndex = 0;
  TextEditingController invoiceDateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    invoiceDateController.dispose();
    super.dispose();
  }

  assignValues(PurchesInvoiceDetailsState state) {
    setState(() {
      gstFlag = state.purchesDetailsModel!.gstFlag.toString();
      gstBill = state.purchesDetailsModel!.gstBill.toString();
      invoiceDateController.text =
          state.purchesDetailsModel!.tempDate.toString();
      if (state.purchesDetailsModel?.invoiceProducts != null) {
        try {
          sparePartsList = state.purchesDetailsModel!.invoiceProducts!.toList();
        } catch (e) {
          sparePartsList = [];
        }
      } else {
        sparePartsList = [];
      }
      sparePartsListNew.clear();
    });
  }

  bool _handleBackNavigation(
      BuildContext context, PurchesInvoiceDetailsState state) {
    if (state.updatePurchesStatus == UpdatePurchesStatus.updating) {
      return false;
    }

    CenterLoader.cancelPending();
    if (CenterLoader.isShowing) CenterLoader.hide();
    Fluttertoast.cancel();

    context.read<PurchesInvoiceDetailsBloc>().add(
          ResetUpdateStatusEvent(),
        );
    // Navigator.pushNamed(context, '/purches_invoice_listing');
    Navigator.pushReplacementNamed(context, '/purches_invoice_listing');

    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: blackColor,
              onSurface: blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: blackColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        invoiceDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchesInvoiceDetailsBloc, PurchesInvoiceDetailsState>(
      listener: (context, state) async {
        if (!mounted) return;
        if (state.getDetailsStatus ==
            PurchesInvoiceDetailsStatus.getchSuccessfully) {
          CenterLoader.hide();
          assignValues(state);
          sparePartsListNew.clear();
        }
        if (state.updatePurchesStatus ==
            UpdatePurchesStatus.updateSuccessfully) {
          Fluttertoast.showToast(
            msg: "Purchase Invoice Updated Successfully",
            textColor: whiteColor,
            backgroundColor: successColor,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          context.read<PurchesInvoiceDetailsBloc>().add(
                ResetUpdateStatusEvent(),
              );
        } else if (state.updatePurchesStatus == UpdatePurchesStatus.failure) {
          CenterLoader.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Failed to update Purchase Invoice",
                style: TextStyle(fontSize: 12, color: whiteColor),
              ),
              backgroundColor: redColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => _handleBackNavigation(context, state),
          child: MainLayout(
            title: const Text(
              "Edit Purchase Invoice",
              style: TextStyle(
                  fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
            ),
            drawer: const DrawerWidget(),
            showFloatingActionButton: false,
            showDefaultBottom: false,
            showCurvedAppBar: true,
            showLeading: true,
            leading: IconButton(
              onPressed: () {
                _handleBackNavigation(context, state);
              },
              icon: const Icon(
                backarrow,
                color: whiteColor,
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: whiteColor,
              child: SizedBox(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(whiteColor),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(primaryColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: (state.updatePurchesStatus ==
                                UpdatePurchesStatus.updating)
                            ? null
                            : () {
                                final allSpareParts = [
                                  ...sparePartsList,
                                  ...sparePartsListNew
                                ];

                                // Calculate total
                                final invoiceTotal = gstBill == "1"
                                    ? calculateSparePartGstSubtotal()
                                    : calculateSparePartSubtotal();

                                if (allSpareParts.isEmpty ||
                                    invoiceTotal == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please add at least one spare part before updating."),
                                      backgroundColor: redColor,
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                  return;
                                }

                                final formData = {
                                  "address":
                                      state.purchesDetailsModel?.address ?? "",
                                  "company_id":
                                      state.purchesDetailsModel?.companyId ??
                                          "",
                                  "created_at_date": state
                                          .purchesDetailsModel?.createdAtDate ??
                                      "",
                                  "created_at_time": state
                                          .purchesDetailsModel?.createdAtTime ??
                                      "",
                                  "deleted_at":
                                      state.purchesDetailsModel?.deletedAt ??
                                          "",
                                  "email":
                                      state.purchesDetailsModel?.email ?? "",
                                  "flag": 0,
                                  "full_name":
                                      state.purchesDetailsModel?.fullName ?? "",
                                  "gst_bill": gstBill,
                                  "gst_flag": gstFlag,
                                  "invoiceTotal": double.parse(
                                      invoiceTotal.toStringAsFixed(2)),
                                  "invoice_id":
                                      state.purchesDetailsModel?.invoiceId ??
                                          "",
                                  "invoice_number": state
                                          .purchesDetailsModel?.invoiceNumber ??
                                      "",
                                  "invoice_products": jsonEncode(allSpareParts),
                                  "last_invoice_id": state
                                          .purchesDetailsModel?.lastInvoiceId ??
                                      "",
                                  "mobile_number":
                                      state.purchesDetailsModel?.mobileNumber ??
                                          "",
                                  "productTotal": double.parse(
                                      invoiceTotal.toStringAsFixed(2)),
                                  "temp_date": invoiceDateController.text,
                                  "updated_at":
                                      state.purchesDetailsModel?.updatedAt ??
                                          "",
                                  "vendor_id":
                                      state.purchesDetailsModel?.vendorId ?? "",
                                  "discountAmount": 0,
                                  "labourTotal": 0,
                                  "taxablevalueTotal":
                                      calculateSparePartSubtotal(),
                                  "cgstTotal": calculateSgstTotal(),
                                  "scgtTotal": calculateSgstTotal(),
                                  "afterDiscountAmount": double.parse(
                                      invoiceTotal.toStringAsFixed(2)),
                                  "invoice_labours": "",
                                };

                                context.read<PurchesInvoiceDetailsBloc>().add(
                                      GeneratePurchaseInvoiceEvent(
                                        formData: formData,
                                        id: state.purchesDetailsModel!.invoiceId
                                            .toString(),
                                      ),
                                    );
                              },
                        child: (state.updatePurchesStatus ==
                                UpdatePurchesStatus.updating)
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: whiteColor,
                                ),
                              )
                            : const Text(
                                'Save',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: (state.getDetailsStatus ==
                        PurchesInvoiceDetailsStatus.initial ||
                    state.getDetailsStatus ==
                        PurchesInvoiceDetailsStatus.loading)
                ? const CenterLoader()
                : Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(),
                            color: whiteColor,
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getValue(
                                        state.purchesDetailsModel?.fullName),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                  ),
                                  const Divider(color: hintTextColor),
                                  _buildInfoRow("Email:",
                                      state.purchesDetailsModel?.email),
                                  _buildInfoRow("Phone Number:",
                                      state.purchesDetailsModel?.mobileNumber),
                                  _buildInfoRow("Address:",
                                      state.purchesDetailsModel?.address),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Invoice Date:',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: TextFormField(
                                          controller: invoiceDateController,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: blackColor,
                                              fontWeight: FontWeight.w600),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide.none,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_month_sharp),
                                              onPressed: () =>
                                                  _selectDate(context),
                                            ),
                                          ),
                                          readOnly: true,
                                          onTap: () => _selectDate(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: whiteColor,
                            shape: const RoundedRectangleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Spare Part',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: blackColor),
                                      ),
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all(
                                              const RoundedRectangleBorder(),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    primaryColor),
                                            foregroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    whiteColor),
                                          ),
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) =>
                                                  PurchesAddSparePartDialog(
                                                onSparePartAdded:
                                                    (Map<String, dynamic>
                                                        newSparePart) {
                                                  setState(() {
                                                    sparePartsListNew
                                                        .add(newSparePart);
                                                  });
                                                },
                                                gstBill: state
                                                    .purchesDetailsModel
                                                    ?.gstBill,
                                              ),
                                            );
                                          },
                                          child: const Text('Add'),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(color: hintTextColor),
                                  if (sparePartsList.isNotEmpty) ...[
                                    Column(
                                      children: [
                                        for (var stocks in sparePartsList)
                                          Column(
                                            children: [
                                              _buildSparePartCardList(
                                                stocks,
                                                gstBill,
                                              ),
                                            ],
                                          )
                                      ],
                                    )
                                  ],
                                  if (sparePartsListNew.isNotEmpty) ...[
                                    Column(
                                      children: [
                                        for (var stocks in sparePartsListNew)
                                          Column(
                                            children: [
                                              _buildSparePartNewListCard(
                                                  stocks, gstBill, state),
                                            ],
                                          )
                                      ],
                                    )
                                  ],
                                  if (sparePartsList.isNotEmpty ||
                                      sparePartsListNew.isNotEmpty) ...[
                                    Container(
                                      height: 50,
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: darkgreyColor,
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                          bottomStart: Radius.circular(4),
                                          bottomEnd: Radius.circular(4),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Spare Part Total:",
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .currency_rupee_sharp,
                                                        color: whiteColor,
                                                        size: 16,
                                                      ),
                                                      Text(
                                                        gstBill == "1"
                                                            ? calculateSparePartGstSubtotal()
                                                                .toStringAsFixed(
                                                                    2) // Show GST-inclusive total
                                                            : calculateSparePartSubtotal()
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString(), // Show regular subtotal
                                                        style: const TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  String _getValue(String? value) =>
      (value != null && value.trim().isNotEmpty) ? value : "-";

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: hintTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              _getValue(value),
              maxLines: 2,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: blackColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //new list of spare part
  Widget _buildSparePartNewListCard(spareParts, String? gstBill, state) {
    double rate = double.tryParse(spareParts['product_price'].toString()) ?? 0;
    String gstText = spareParts['product_gst'].toString();
    String hsnCode = spareParts['hsn_code'].toString();

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  spareParts['product_name'].toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton(
                color: whiteColor,
                itemBuilder: (context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    setState(() {
                      gstBill == "1"
                          ? showEditNewGstSparePartDialog(
                              context: context,
                              sparePart: spareParts,
                              gstBill: gstBill,
                              index: sparePartsListNew.indexOf(spareParts),
                              onSparePartUpdated: (updatedPart, index) {
                                setState(() {
                                  sparePartsListNew[index] = updatedPart;
                                });
                              },
                            )
                          : showEditNewSparePartDialog(
                              context: context,
                              sparePart: spareParts,
                              index: sparePartsListNew.indexOf(spareParts),
                              onSparePartUpdated: (updatedPart, index) {
                                setState(() {
                                  sparePartsListNew[index] = updatedPart;
                                });
                              },
                            );
                    });
                  } else if (value == 'delete') {
                    int index = sparePartsListNew.indexOf(spareParts);
                    setState(() {
                      sparePartsListNew.removeAt(index);
                      if (index == updateIndex) {
                        updateIndex = -1;
                      }
                    });
                  }
                },
                child: const Icon(Icons.more_vert,
                    color: blackColorDark, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 6),

          /// GST ON → 4 rows layout
          if (gstBill == "1") ...[
            // Qty + Rate
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Qty: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Rate: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    const Icon(Icons.currency_rupee_sharp,
                        size: 12, color: blackColor),
                    Text(
                      rate.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),

            // GST + Taxable
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "GST: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      gstText,
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Taxable: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    const Icon(Icons.currency_rupee_sharp,
                        size: 12, color: blackColor),
                    Text(
                      calculateSubProductTotal(spareParts).toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: blackColorDark),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),

            // HSN + Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "HSN: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      hsnCode,
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Total: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    const Icon(Icons.currency_rupee_sharp,
                        size: 12, color: blackColor),
                    Text(
                      calculateGstTotalSparePart(spareParts).toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: blackColorDark),
                    ),
                  ],
                ),
              ],
            ),
          ],

          /// GST OFF → single row layout
          if (gstBill != "1")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Qty: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Rate: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    const Icon(Icons.currency_rupee_sharp,
                        size: 12, color: blackColor),
                    Text(
                      rate.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Total: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      calculateSubProductTotal(spareParts).toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: blackColorDark),
                    ),
                  ],
                ),
              ],
            ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(color: hintTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSparePartCardList(spareParts, String? gstBill) {
    double rate = double.tryParse(spareParts['product_price'].toString()) ?? 0;
    String gstText = spareParts['product_gst'].toString();
    String hsnCode = spareParts['hsn_code'].toString();

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product name + more button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  spareParts['product_name'].toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  PopupMenuButton(
                    color: whiteColor,
                    itemBuilder: (context) => <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        setState(() {
                          gstBill == "1"
                              ? showEditGstSparePartDialog(
                                  context: context,
                                  sparePart: spareParts,
                                  gstBill: gstBill,
                                  index: sparePartsList.indexOf(spareParts),
                                  onSparePartUpdated: (updatedPart, index) {
                                    setState(() {
                                      sparePartsList[index] = updatedPart;
                                    });
                                  },
                                )
                              : showEditSparePartDialog(
                                  context: context,
                                  sparePart: spareParts,
                                  index: sparePartsList.indexOf(spareParts),
                                  onSparePartUpdated: (updatedPart, index) {
                                    setState(() {
                                      sparePartsList[index] = updatedPart;
                                    });
                                  },
                                );
                        });
                      } else if (value == 'delete') {
                        int index = sparePartsList.indexOf(spareParts);
                        setState(() {
                          sparePartsList.removeAt(index);
                          if (index == updateIndex) {
                            updateIndex = -1;
                          }
                        });
                      }
                    },
                    child: const Icon(Icons.more_vert,
                        color: blackColorDark, size: 22),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 6),

          /// GST ON → 4 rows layout
          if (gstBill == "1") ...[
            // Qty + Rate
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Qty: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Rate: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    const Icon(Icons.currency_rupee_sharp,
                        size: 12, color: blackColor),
                    Text(
                      rate.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),

            // GST + Taxable
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "GST: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      gstText,
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Taxable: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    const Icon(Icons.currency_rupee_sharp,
                        size: 12, color: blackColor),
                    Text(
                      calculateSubProductTotal(spareParts).toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: blackColorDark),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),

            // HSN + Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "HSN: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      hsnCode,
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Total: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    const Icon(Icons.currency_rupee_sharp,
                        size: 12, color: blackColor),
                    Text(
                      calculateGstTotalSparePart(spareParts).toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: blackColorDark),
                    ),
                  ],
                ),
              ],
            ),
          ],

          /// GST OFF → single row layout
          if (gstBill != "1")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Qty: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Rate: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    const Icon(Icons.currency_rupee_sharp,
                        size: 12, color: blackColor),
                    Text(
                      rate.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 13, color: blackColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Total: ",
                      style: TextStyle(fontSize: 12, color: hintTextColor),
                    ),
                    Text(
                      calculateSubProductTotal(spareParts).toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: blackColorDark),
                    ),
                  ],
                ),
              ],
            ),

          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(color: hintTextColor),
          ),
        ],
      ),
    );
  }

  String formatQty(dynamic qty, dynamic flag) {
    if (flag == 0) return "-";

    final double value = double.tryParse(qty.toString()) ?? 0;
    if (value == value.toInt()) {
      return value.toInt().toString(); // 20.0 → 20
    } else {
      return value.toString(); // e.g. 20.5 → 20.5
    }
  }

  double calculateSubProductTotal(Map<String, dynamic> spareParts) {
    double productPrice =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double productQty =
        double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;

    return productPrice * productQty;
  }

  double calculateGstTotalSparePart(Map<String, dynamic> spareParts) {
    double price =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
    double baseTotal = price * qty;
    String gstValue = spareParts['product_gst'].toString();
    double gstPercentage = 0.0;
    double cessPercentage = 0.0;
    if (gstValue.contains('@')) {
      List<String> parts = gstValue.split('+');
      String gstPart = parts[0].trim();
      if (gstPart.contains('@')) {
        gstPercentage =
            double.tryParse(gstPart.split('@')[1].replaceAll('%', '').trim()) ??
                0.0;
      }
      if (parts.length > 1) {
        String cessPart = parts[1].trim();
        if (cessPart.contains('@')) {
          cessPercentage = double.tryParse(
                  cessPart.split('@')[1].replaceAll('%', '').trim()) ??
              0.0;
        }
      }
    }
    double gstAmount = (baseTotal * gstPercentage) / 100;
    double cessAmount = (baseTotal * cessPercentage) / 100;
    double totalWithGst = baseTotal + gstAmount + cessAmount;
    return totalWithGst;
  }

  double getGstPercentage(String gstString) {
    if (gstString == "None" || gstString == "Exempted") {
      return 0.0; // No GST
    }

    // Match all percentages in the string, e.g., both GST and Cess
    final matches = RegExp(r"(\d+(\.\d+)?)%").allMatches(gstString);

    double totalPercentage = 0.0;
    for (var match in matches) {
      totalPercentage += double.tryParse(match.group(1)!) ?? 0.0;
    }

    return totalPercentage;
  }

  Future<void> showEditGstSparePartDialog({
    required BuildContext context,
    required Map<String, dynamic> sparePart,
    required String? gstBill,
    required Function(Map<String, dynamic>, int index) onSparePartUpdated,
    required int index,
  }) async {
    final updatedSparePart = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EditGstProductDialog(
        sparePart: sparePart,
        gstBill: gstBill,
      ),
    );

    if (updatedSparePart != null) {
      onSparePartUpdated(updatedSparePart, index);
    }
  }

  showEditSparePartDialog({
    required BuildContext context,
    required Map<String, dynamic> sparePart,
    required Function(Map<String, dynamic>, int index) onSparePartUpdated,
    required int index,
  }) async {
    final updatedSparePart = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EditProductDialog(
        sparePart: sparePart,
      ),
    );

    if (updatedSparePart != null) {
      onSparePartUpdated(updatedSparePart, index);
    }
  }

  Future<void> showEditNewGstSparePartDialog({
    required BuildContext context,
    required Map<String, dynamic> sparePart,
    required String? gstBill,
    required Function(Map<String, dynamic>, int index) onSparePartUpdated,
    required int index,
  }) async {
    final updatedSparePart = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EditGstProductDialog(
        sparePart: sparePart,
        gstBill: gstBill,
      ),
    );

    if (updatedSparePart != null) {
      onSparePartUpdated(updatedSparePart, index);
    }
  }

  showEditNewSparePartDialog({
    required BuildContext context,
    required Map<String, dynamic> sparePart,
    required Function(Map<String, dynamic>, int index) onSparePartUpdated,
    required int index,
  }) async {
    final updatedSparePart = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EditProductDialog(
        sparePart: sparePart,
      ),
    );

    if (updatedSparePart != null) {
      onSparePartUpdated(updatedSparePart, index);
    }
  }

  //calculate gst subtotal of spare part
  calculateSparePartGstSubtotal() {
    double totalGstList = calculateSubTotalWithGst();
    double totalGstNewList = calculateSubTotalWithGstNew();
    return totalGstList + totalGstNewList;
  }

  double calculateSubTotalWithGst() {
    double subtotalWithGst = 0.0;
    for (var spareParts in sparePartsList) {
      if (spareParts is Map<String, dynamic>) {
        double price =
            double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
        double qty =
            double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
        String gstString = spareParts['product_gst'];
        double baseValue = price * qty;
        double gstPercentage = getGstPercentage(gstString);
        double gstAmount = baseValue * (gstPercentage / 100);
        double finalValue = baseValue + gstAmount;
        subtotalWithGst += finalValue;
      }
    }
    return subtotalWithGst;
  }

  double calculateSubTotalWithGstNew() {
    double subtotalWithGst = 0.0;
    for (var spareParts in sparePartsListNew) {
      if (spareParts is Map<String, dynamic>) {
        double price =
            double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
        double qty =
            double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
        String gstString = spareParts['product_gst'];
        double baseValue = price * qty;
        double gstPercentage = getGstPercentage(gstString);
        double gstAmount = baseValue * (gstPercentage / 100);
        double finalValue = baseValue + gstAmount;
        subtotalWithGst += finalValue;
      }
    }
    return subtotalWithGst;
  }

  //calculate subtotal of spare part
  calculateSparePartSubtotal() {
    double subtotal = 0.0;
    if (calculateSparePartListTotal() != 0 ||
        calculateSparePartListNewTotal() != 0) {
      subtotal =
          calculateSparePartListTotal() + calculateSparePartListNewTotal();
    }
    return double.parse(subtotal.toStringAsFixed(2));
  }

  double calculateSparePartListTotal() {
    double subtotal = 0.0;
    for (var spareParts in sparePartsList) {
      double price =
          double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
      double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
      subtotal += price * qty;
    }
    return double.parse(subtotal.toStringAsFixed(2));
  }

  double calculateSparePartListNewTotal() {
    double subtotal = 0;
    for (var spareParts in sparePartsListNew) {
      double price =
          double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
      double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
      subtotal += price * qty;
    }
    return double.parse(subtotal.toStringAsFixed(2));
  }

  double calculateSgstTotal() {
    double sgstTotal = 0.0;

    for (var spareParts in sparePartsList) {
      double price =
          double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
      double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
      String gstString = spareParts['product_gst'];
      double baseValue = price * qty;

      double gstPercentage = getGstPercentage(gstString);
      double gstAmount = baseValue * (gstPercentage / 100);

      // Half GST = SGST
      sgstTotal += gstAmount / 2;
    }

    for (var spareParts in sparePartsListNew) {
      double price =
          double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
      double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
      String gstString = spareParts['product_gst'];
      double baseValue = price * qty;

      double gstPercentage = getGstPercentage(gstString);
      double gstAmount = baseValue * (gstPercentage / 100);

      sgstTotal += gstAmount / 2;
    }

    return double.parse(sgstTotal.toStringAsFixed(2));
  }
}
