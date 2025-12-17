import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/form_field_title.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/discard_dailog_component/discard_from_page/discard_customer_form.dart';

import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_details_bloc/customer_details_bloc.dart';

class EditCustomerForm extends StatefulWidget {
  const EditCustomerForm({super.key});

  @override
  State<EditCustomerForm> createState() => _EditCustomerFormState();
}

class _EditCustomerFormState extends State<EditCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController alternateNumberController = TextEditingController();
  String? errorMesage;
  String? phoneError;
  final _exitConfirmationDialog = const DiscardCustomerForm();

  assignValues(CustomerDetailsState state) {
    if (mounted) {
      setState(() {
        customerNameController.text =
            state.customerDetailsList!.fullName.toString();
        adressController.text = state.customerDetailsList!.address.toString();
        emailController.text = state.customerDetailsList!.email.toString();
        phoneNumberController.text =
            state.customerDetailsList!.mobileNumber.toString();
        gstNumberController.text =
            state.customerDetailsList!.gstNumber.toString();
        alternateNumberController.text =
            state.customerDetailsList!.alternateNumber.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerDetailsBloc, CustomerDetailsState>(
      listener: (context, state) {
        if (state.customerDetailsStatus == GetCustomerStatusDetails.success) {
          Fluttertoast.cancel();
          assignValues(state);
        }
        if (state.customerDetailsStatus == GetCustomerStatusDetails.updating) {
          CenterLoader.show(context);
        } else if (state.customerDetailsStatus ==
            GetCustomerStatusDetails.updated) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Customer Updated Successfully",
              textColor: whiteColor,
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          Navigator.pushNamed(context, '/customer_page');
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            final shouldExit = await _exitConfirmationDialog.show(context);
            if (shouldExit) {
              Navigator.pushNamed(context, '/customer_page');
              return true;
            } else {
              return false;
            }
          },
          child: MainLayout(
            title: const Text(
              'Edit Customer',
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
                  Navigator.pushNamed(context, '/customer_page');
                }
              },
              icon: const Icon(
                backarrow,
                color: whiteColor,
              ),
            ),
            showDefaultBottom: false,
            bottomNavigationBar: SafeArea(
              child: Container(
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
                          style: TextStyle(color: blackColor, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> formData = {
                              "id": state.customerDetailsList!.id.toString(),
                              "full_name": customerNameController.text.trim(),
                              "address": adressController.text.trim(),
                              "email": emailController.text.trim(),
                              "mobile_number":
                                  phoneNumberController.text.trim(),
                              "alternet_number":
                                  alternateNumberController.text.trim(),
                              "gst_number": gstNumberController.text.trim(),
                            };
                            context.read<CustomerDetailsBloc>().add(
                                  UpdateCustomerInfo(
                                      id: state.customerDetailsList!.id
                                          .toString(),
                                      formData: formData),
                                );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Update",
                              style: TextStyle(color: whiteColor, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                  padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
                  child: Card(
                    color: whiteColor,
                    child: Column(
                      children: [
                        const FormFieldTitle(title: "Customer Details:"),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  "Customer Name:",
                                  style: TextStyle(
                                      fontSize: 14, color: blackColor),
                                ),
                                Icon(Icons.star, color: redColor, size: 10)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 10, bottom: 5),
                          child: TextFormField(
                            controller: customerNameController,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w500),
                            inputFormatters: [
                              NoLeadingSpaceFormatter(),
                              LengthLimitingTextInputFormatter(50),
                            ],
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Customer name is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter customer name",
                              hintStyle: const TextStyle(
                                  color: hintTextColor,
                                  fontFamily: 'Mulish',
                                  fontSize: 13),
                              contentPadding: const EdgeInsets.only(
                                left: 15,
                                right: 20.0,
                              ),
                              errorText: errorMesage,
                              errorStyle: const TextStyle(
                                  color: redColor, fontSize: 12),
                              filled: true,
                              fillColor: textfieldBg,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  errorMesage = null;
                                },
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Email:",
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 10, bottom: 5),
                          child: TextFormField(
                            controller: emailController,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w500),
                            inputFormatters: [
                              NoLeadingSpaceFormatter(),
                              LengthLimitingTextInputFormatter(50),
                            ],
                            keyboardType: TextInputType.emailAddress,
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
                              fillColor: textfieldBg,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                String pattern =
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return "Enter a valid email address";
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  "Phone Number:",
                                  style: TextStyle(
                                      fontSize: 14, color: blackColor),
                                ),
                                Icon(Icons.star, color: redColor, size: 10)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 10, bottom: 5),
                          child: TextFormField(
                            controller: phoneNumberController,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Mobile number is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter phone number",
                              hintStyle: const TextStyle(
                                  color: hintTextColor,
                                  fontFamily: 'Mulish',
                                  fontSize: 13),
                              contentPadding: const EdgeInsets.only(
                                left: 15,
                                right: 20.0,
                              ),
                              errorText: phoneError,
                              errorStyle: const TextStyle(
                                  color: redColor, fontSize: 12),
                              filled: true,
                              fillColor: textfieldBg,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  phoneError = null;
                                },
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Alternate Number:",
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 10, bottom: 5),
                          child: TextFormField(
                            controller: alternateNumberController,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              NoLeadingSpaceFormatter(),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                              hintText: "Enter alternate number",
                              hintStyle: const TextStyle(
                                  color: hintTextColor,
                                  fontFamily: 'Mulish',
                                  fontSize: 13),
                              contentPadding: const EdgeInsets.only(
                                left: 15,
                                right: 20.0,
                              ),
                              filled: true,
                              fillColor: textfieldBg,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Address:",
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 10, bottom: 5),
                          child: TextFormField(
                            controller: adressController,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w500),
                            inputFormatters: [
                              NoLeadingSpaceFormatter(),
                              LengthLimitingTextInputFormatter(50),
                            ],
                            keyboardType: TextInputType.streetAddress,
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
                              fillColor: textfieldBg,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "GST Number:",
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 10, bottom: 5),
                          child: TextFormField(
                            controller: gstNumberController,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w500),
                            inputFormatters: [
                              NoLeadingSpaceFormatter(),
                              LengthLimitingTextInputFormatter(15),
                            ],
                            keyboardType: TextInputType.text,
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
                              fillColor: textfieldBg,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  clearScreen() {
    setState(() {
      customerNameController.clear();
      gstNumberController.clear();
      alternateNumberController.clear();
      adressController.clear();
      emailController.clear();
      phoneNumberController.clear();
    });
  }
}
