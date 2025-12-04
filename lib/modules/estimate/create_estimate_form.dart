import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/discard_dailog_component/discard_from_page/discard_create_estimate_form.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/models/customer_model.dart';
import 'package:local_shout_billing/modules/estimate/estimate_listing.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/modules/job_sheet/bloc/search_bloc/search_bloc_bloc.dart';
import '../job_sheet/bloc/job_sheet_bloc/job_sheet_bloc.dart';
import 'estimate_page.dart';

class CreateEstimateForm extends StatefulWidget {
  const CreateEstimateForm({super.key});

  @override
  State<CreateEstimateForm> createState() => _CreateEstimateFormState();
}

class _CreateEstimateFormState extends State<CreateEstimateForm> {
  final _formKey = GlobalKey<FormState>();
  bool _mobileValidate = false;
  bool _nameValidate = false;
  final FocusNode mobileFocusNode = FocusNode();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  String? emailErrorMessage;
  final discardCreateEstimate = const DiscardCreateEstimateDailog();
  String? selectedModel;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      _validateEmail(emailController.text);
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    adressController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    gstNumberController.dispose();
    mobileFocusNode.dispose();
    super.dispose();
  }

  void _validateEmail(String value) {
    // Empty case
    if (value.isEmpty) {
      setState(() {
        emailErrorMessage = null;
      });
      return;
    }

    // '@@' case
    if (value.contains('@@')) {
      setState(() {
        emailErrorMessage = 'Please enter a valid email';
      });
      return;
    }

    // Regex invalid
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      setState(() {
        emailErrorMessage = 'Invalid email format';
      });
      return;
    }

    setState(() {
      emailErrorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobSheetBloc, JobSheetState>(
      listener: (context, state) {
        if (state.status == JobSheetStatus.estimateSuccess) {
          Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: "Estimate added successfully",
            backgroundColor: successDarkColor,
          );
          context.read<JobSheetDetailsBloc>().add(
                GetEstimateDetailsByEstimate(
                  id: state.currentEstimateId.toString(),
                ),
              );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EstimatePage(),
            ),
          );
        } else if (state.status == JobSheetStatus.submitFailure) {
          CenterLoader.hide();
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
            final shouldExit = await discardCreateEstimate.show(context);
            if (shouldExit) {
              app_instance.appConfig.toastCount = 0;
              app_instance.appConfig.additonalImageCount = 0;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EstimateListing(),
                ),
              );
              return true;
            } else {
              return false;
            }
          },
          child: MainLayout(
            title: const Text(
              'Create Estimate',
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w500, color: whiteColor),
            ),
            drawer: const DrawerWidget(),
            showCurvedAppBar: true,
            showFloatingActionButton: false,
            showLeading: true,
            showDefaultBottom: false,
            leading: IconButton(
              onPressed: () async {
                final shouldExit = await discardCreateEstimate.show(context);
                if (shouldExit) {
                  app_instance.appConfig.toastCount = 0;
                  app_instance.appConfig.additonalImageCount = 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EstimateListing(),
                    ),
                  );
                }
              },
              icon: const Icon(
                backarrow,
                color: whiteColor,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ],
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(color: whiteColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 45,
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
                            Navigator.of(context).pop();
                          },
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: blackColor, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 45,
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
                                side: const BorderSide(color: primaryColor),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _nameValidate = fullNameController.text.isEmpty;
                              _mobileValidate =
                                  phoneNumberController.text.isEmpty;
                            });

                            if (fullNameController.text.isNotEmpty &&
                                phoneNumberController.text.isNotEmpty) {
                              // GST confirmation dialog
                              final gstConfirmed = await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  String billingType =
                                      "gst"; // DEFAULT: GST Invoice
                                  String gstOption =
                                      "CGST/SGST"; // DEFAULT: CGST/SGST

                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        backgroundColor: whiteColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Billing Type",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: const Icon(Icons.close,
                                                  size: 20, color: blackColor),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              value: "regular",
                                              groupValue: billingType,
                                              onChanged: (value) => setState(
                                                  () => billingType =
                                                      value.toString()),
                                            ),

                                            /// GST Invoice
                                            RadioListTile(
                                              title: const Text(
                                                "GST Invoice",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: blackColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              value: "gst",
                                              groupValue: billingType,
                                              onChanged: (value) => setState(
                                                  () => billingType =
                                                      value.toString()),
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
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "IGST",
                                                        child: Text(
                                                          "IGST",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                    onChanged: (val) =>
                                                        setState(() =>
                                                            gstOption =
                                                                val.toString()),
                                                  ),
                                                ),
                                              ),
                                            ],

                                            const SizedBox(height: 20),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: bluecolorprimary,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                            Color>(primaryColor),
                                                    shape: WidgetStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Continue",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context, {
                                                      "billingType":
                                                          billingType,
                                                      "igst":
                                                          gstOption == "IGST"
                                                              ? "1"
                                                              : "0"
                                                    });
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

                              if (gstConfirmed != null) {
                                String billingType =
                                    gstConfirmed["billingType"];
                                String igst = gstConfirmed["igst"];

                                String gstBill = "0"; // default regular invoice

                                if (billingType == "gst") {
                                  gstBill = "1"; // GST Invoice
                                }

                                Map<String, dynamic> formData = {
                                  "full_name":
                                      fullNameController.text.toString(),
                                  "address": adressController.text.toString(),
                                  "email": emailController.text.toString(),
                                  "mobile_number":
                                      phoneNumberController.text.toString(),
                                  "gst_number":
                                      gstNumberController.text.toString(),
                                  "gst_bill": gstBill,
                                  "igst": billingType == "regular" ? "0" : igst,
                                };

                                context.read<JobSheetBloc>().add(
                                      AddEstimate(formData: formData),
                                    );
                              }
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(fontSize: 14),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                                color: blackColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Customer Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Customer Name: ',
                            style: TextStyle(fontSize: 14),
                          ),
                          Icon(Icons.star, color: redColor, size: 10)
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<SearchBloc, SearchBlocState>(
                        builder: (context, state) {
                          return Autocomplete<CustomerModel>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<CustomerModel>.empty();
                              }
                              return state.customerList!.where(
                                (element) => element.fullName!
                                    .trim()
                                    .toLowerCase()
                                    .contains(
                                      textEditingValue.text
                                          .trim()
                                          .toLowerCase(),
                                    ),
                              );
                            },
                            displayStringForOption: (vehicle) =>
                                vehicle.fullName!,
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController
                                    _fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              if (fullNameController.text.isEmpty) {
                                fullNameController =
                                    _fieldTextEditingController;
                              }
                              return TextField(
                                controller: fullNameController,
                                focusNode: fieldFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                                inputFormatters: [
                                  NoLeadingSpaceFormatter(),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z0-9\s]*$'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  hintText: "Enter First Name",
                                  hintStyle: const TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontSize: 13),
                                  contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    right: 20.0,
                                  ),
                                  filled: true,
                                  errorText: _nameValidate
                                      ? "The full name field is required"
                                      : null,
                                  fillColor: whiteColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                onChanged: (text) {
                                  setState(
                                    () {
                                      _nameValidate = text.trim().isEmpty;
                                    },
                                  );

                                  if (text.trim().length >= 3) {
                                    context.read<SearchBloc>().add(
                                          SearchCustomerDetails(
                                              searchKeyword: text),
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
                                        final CustomerModel option =
                                            options.elementAt(index);
                                        return ListTile(
                                          title: Text(option.fullName!),
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
                              setState(
                                () {
                                  fullNameController.text =
                                      suggestion.fullName!;

                                  adressController.text = suggestion.address!;

                                  emailController.text = suggestion.email!;

                                  phoneNumberController.text =
                                      suggestion.mobileNumber!;
                                  fullNameController.selection =
                                      TextSelection.fromPosition(
                                    TextPosition(
                                        offset: fullNameController.text.length),
                                  );
                                  _nameValidate = false;
                                  _mobileValidate = false;
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Email:',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
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
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            errorText: emailErrorMessage),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Mobile Number: ',
                            style: TextStyle(fontSize: 14),
                          ),
                          Icon(Icons.star, color: redColor, size: 10)
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        focusNode: mobileFocusNode,
                        controller: phoneNumberController,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          LengthLimitingTextInputFormatter(10)
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter mobile number",
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
                          errorText: _mobileValidate
                              ? "The mobile number field is reqired"
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _mobileValidate = value.isEmpty;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Address:',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: adressController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          LengthLimitingTextInputFormatter(50)
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
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'GST Number: ',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: gstNumberController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          LengthLimitingTextInputFormatter(15)
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter Gst number",
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
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
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
}
