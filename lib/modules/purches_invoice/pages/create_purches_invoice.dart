import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/discard_dailog_component/discard_from_page/discard_purches_invoice.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/models/stock_vendor_model.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/search_bloc/search_bloc_bloc.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice/purchase_invoice_bloc.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice_details_bloc/purches_invoice_details_bloc.dart';

class CreatePurchesInvoicePage extends StatefulWidget {
  const CreatePurchesInvoicePage({super.key});

  @override
  State<CreatePurchesInvoicePage> createState() =>
      _CreatePurchesInvoicePageState();
}

class _CreatePurchesInvoicePageState extends State<CreatePurchesInvoicePage> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool _mobileValidate = false;
  bool _validate = false;
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  final _exitConfirmationDialog = const DiscardConfirmationPurchesInvocie();

  @override
  void dispose() {
    vendorNameController.dispose();
    adressController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    gstNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchesInvoiceBloc, PurchesInvoiceState>(
      listener: (context, state) {
        if (state.createPurchesStatus == CreatePurchesStatus.sending) {
          CenterLoader.show(context);
        } else if (state.createPurchesStatus ==
                CreatePurchesStatus.createSuccess &&
            state.purchesLastId != null) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Purchase Invoice created successfully",
              textColor: whiteColor,
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          context.read<PurchesInvoiceDetailsBloc>().add(
                GetPurchaseDetailsByID(
                  id: state.purchesLastId.toString(),
                ),
              );
          Navigator.pushNamed(context, '/purchase_details_screen');
        } else if (state.createPurchesStatus == CreatePurchesStatus.failure) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Failed to create Purchase invoice",
              textColor: whiteColor,
              backgroundColor: redColor,
              toastLength: Toast.LENGTH_SHORT);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            final shouldExit = await _exitConfirmationDialog.show(context);
            if (shouldExit) {
              Navigator.pushNamed(context, '/purches_invoice_listing');
              return true;
            } else {
              return false;
            }
          },
          child: MainLayout(
            title: const Text(
              'Create Purchase Invoice',
              style: TextStyle(
                  fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
            ),
            drawer: const DrawerWidget(),
            showCurvedAppBar: true,
            showFloatingActionButton: false,
            showLeading: true,
            leading: IconButton(
              onPressed: () async {
                final shouldExit = await _exitConfirmationDialog.show(context);
                if (shouldExit) {
                  Navigator.pushNamed(context, '/purches_invoice_listing');
                }
              },
              icon: const Icon(
                backarrow,
                color: whiteColor,
              ),
            ),
            showDefaultBottom: false,
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(color: whiteColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(blackColor),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(lightGreyColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          clearScreen();
                        },
                        child: const Text(
                          "Clear All",
                          style: TextStyle(color: blackColor, fontSize: 14),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            WidgetStateProperty.all<Color>(blackColor),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(primaryColor),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: primaryColor),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _validate = vendorNameController.text.isEmpty;
                          _mobileValidate = phoneNumberController.text.isEmpty;
                        });
                        if (_validate || _mobileValidate) return;
                        if (_formKey.currentState!.validate()) {
                          // GST confirmation dialog
                          final bool? gstConfirmed = await showDialog<bool>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      const Text(
                                        "Do you want to activate GST?",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: blackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Select \"Yes\" to enable GST billing feature",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: blackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              style: OutlinedButton.styleFrom(
                                                side: const BorderSide(
                                                    color: Colors.grey),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: blackColor),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    successDarkColor,
                                                foregroundColor: whiteColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text('Yes'),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).pop(),
                                      borderRadius: BorderRadius.circular(20),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(Icons.close,
                                            size: 20, color: greyColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                          // Only continue if user selected Yes or No
                          if (gstConfirmed != null) {
                            Map<String, dynamic> formData = {
                              "vendor_name": vendorNameController.text.trim(),
                              "address": adressController.text.trim(),
                              "email": emailController.text.trim(),
                              "phone_number": phoneNumberController.text.trim(),
                              "total_balance_vendor": "",
                              "gst_number": gstNumberController.text.trim(),
                              "gst_bill": gstConfirmed ? "1" : "0",
                            };
                            // Send to Bloc
                            context.read<PurchesInvoiceBloc>().add(
                                  CreatePurchesInvoice(
                                    formData: formData,
                                  ),
                                );
                          }
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Next",
                            style: TextStyle(color: blackColor, fontSize: 14),
                          ),
                          SizedBox(width: 3),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 14,
                            color: blackColor,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ],
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Vendor Name:',
                            style: TextStyle(fontSize: 14),
                          ),
                          Icon(
                            Icons.star,
                            color: redColor,
                            size: 8,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<SearchBloc, SearchBlocState>(
                        builder: (context, state) {
                          return Autocomplete<StockVendorModel>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return [];
                              }
                              return state.vendorList!.where(
                                (element) => element.vendorName!
                                    .trim()
                                    .toLowerCase()
                                    .contains(
                                      textEditingValue.text
                                          .trim()
                                          .toLowerCase(),
                                    ),
                              );
                            },
                            displayStringForOption: (vendor) =>
                                vendor.vendorName!,
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController
                                    fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              vendorNameController = fieldTextEditingController;

                              return TextField(
                                controller: vendorNameController,
                                focusNode: fieldFocusNode,
                                style: const TextStyle(
                                    color: blackColor, fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'Enter vendor name',
                                  hintStyle: const TextStyle(
                                    color: hintTextColor,
                                    fontFamily: 'Mulish',
                                    fontSize: 13,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      right: 20, left: 15),
                                  errorText: _validate
                                      ? "The vendor name field is required"
                                      : null,
                                  filled: true,
                                  fillColor: whiteColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    _validate = text.trim().isEmpty;
                                  });

                                  if (text.trim().length >= 3) {
                                    context.read<SearchBloc>().add(
                                          SearchVendor(searchKeyword: text),
                                        );
                                  }
                                },
                              );
                            },
                            optionsViewBuilder: (context, onSelected, options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  elevation: 4.0,
                                  child: Container(
                                    color: whiteColor,
                                    constraints: BoxConstraints(
                                      maxWidth: 290,
                                      maxHeight: options.isEmpty
                                          ? 0
                                          : (options.length * 50).toDouble(),
                                    ),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final StockVendorModel option =
                                            options.elementAt(index);
                                        return ListTile(
                                          title: Text(option.vendorName ?? ""),
                                          onTap: () {
                                            onSelected(option);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            onSelected: (suggestion) {
                              vendorNameController.text =
                                  suggestion.vendorName ?? "";
                              phoneNumberController.text =
                                  suggestion.phoneNumber ?? "";
                              gstNumberController.text =
                                  suggestion.gstNumber ?? "";
                              emailController.text = suggestion.email ?? "";
                              adressController.text = suggestion.address ?? "";
                              _validate = false;
                              _mobileValidate = false;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                "Phone Number:",
                                style:
                                    TextStyle(fontSize: 14, color: blackColor),
                              ),
                              Icon(
                                Icons.star,
                                color: redColor,
                                size: 8,
                              )
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          LengthLimitingTextInputFormatter(10)
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter Phone Number",
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13),
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 20.0,
                          ),
                          errorText: _mobileValidate
                              ? "The phone number field is required"
                              : null,
                          filled: true,
                          fillColor: whiteColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (_mobileValidate && value.isNotEmpty) {
                            setState(() => _mobileValidate = false);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "GST Number:",
                            style: TextStyle(fontSize: 14, color: blackColor),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: gstNumberController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          LengthLimitingTextInputFormatter(15),
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter GST number",
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13),
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 20.0,
                          ),
                          filled: true,
                          fillColor: whiteColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email:",
                            style: TextStyle(fontSize: 14, color: blackColor),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter email",
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13),
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 20.0,
                          ),
                          filled: true,
                          fillColor: whiteColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Address:",
                            style: TextStyle(fontSize: 14, color: blackColor),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: adressController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter address",
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13),
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 20.0,
                          ),
                          filled: true,
                          fillColor: whiteColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  clearScreen() {
    setState(() {
      vendorNameController.clear();
      gstNumberController.clear();
      adressController.clear();
      emailController.clear();
      phoneNumberController.clear();
    });
  }
}
