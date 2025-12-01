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
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/vendor/bloc/vendor_details_bloc/vendor_details_bloc.dart';

class EditVendorsDetails extends StatefulWidget {
  const EditVendorsDetails({super.key});

  @override
  State<EditVendorsDetails> createState() => _EditVendorsDetailsState();
}

class _EditVendorsDetailsState extends State<EditVendorsDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController totalBalanceController = TextEditingController();

  assignValues(VendorDetailsState state) {
    if (mounted) {
      setState(() {
        vendorNameController.text =
            state.vendorDetailsList!.vendorName.toString();
        adressController.text = state.vendorDetailsList!.address.toString();
        emailController.text = state.vendorDetailsList!.email.toString();
        phoneNumberController.text =
            state.vendorDetailsList!.phoneNumber.toString();
        gstNumberController.text =
            state.vendorDetailsList!.gstNumber.toString();
        totalBalanceController.text =
            state.vendorDetailsList!.totalBalanceVendor.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorDetailsBloc, VendorDetailsState>(
        listener: (context, state) {
      if (state.vendorDetailsStatus == GetVendorsDetailsStatus.success) {
        Fluttertoast.cancel();
        assignValues(state);
      }
      //update
      if (state.vendorDetailsStatus == GetVendorsDetailsStatus.updating) {
        CenterLoader.show(context);
      } else if (state.vendorDetailsStatus == GetVendorsDetailsStatus.updated) {
        CenterLoader.hide();
        Fluttertoast.showToast(
            msg: "Vendor Updated Successfully",
            textColor: whiteColor,
            backgroundColor: successColor,
            toastLength: Toast.LENGTH_SHORT);
        Navigator.pushNamed(context, '/vendor_listing');
      }
    }, builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, '/vendor_listing');
          return true;
        },
        child: MainLayout(
          title: const Text(
            'Edit Vendor',
            style: TextStyle(
                fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
          ),
          drawer: const DrawerWidget(),
          showCurvedAppBar: true,
          showFloatingActionButton: false,
          showLeading: true,
          leading: IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/vendor_listing');
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> formData = {
                          "id": state.vendorDetailsList!.id,
                          "created_at":
                              state.vendorDetailsList!.createdAt.toString(),
                          "deleted_at":
                              state.vendorDetailsList!.deletedAt.toString(),
                          "updated_at":
                              state.vendorDetailsList!.updatedAt.toString(),
                          "vendor_name": vendorNameController.text.trim(),
                          "address": adressController.text.trim(),
                          "email": emailController.text.trim(),
                          "phone_number": phoneNumberController.text.trim(),
                          "total_balance_vendor":
                              totalBalanceController.text.trim(),
                          "gst_number": gstNumberController.text.trim(),
                        };
                        context.read<VendorDetailsBloc>().add(
                              UpdateEditVendor(
                                formData: formData,
                                id: state.vendorDetailsList!.id.toString(),
                              ),
                            );
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Update",
                          style: TextStyle(color: blackColor, fontSize: 15),
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
          body: (state.vendorDetailsStatus == GetVendorsDetailsStatus.initial ||
                  state.vendorDetailsStatus == GetVendorsDetailsStatus.loading)
              ? const CenterLoader()
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const FormFieldTitle(title: "Vendor Details:"),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 15, top: 15, bottom: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  "Vendor Name:",
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
                            controller: vendorNameController,
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
                            decoration: InputDecoration(
                              hintText: "Enter Vendor Name",
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
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "The Vendor Name field is required";
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
                            child: Text(
                              "Phone Number:",
                              style: TextStyle(fontSize: 14, color: blackColor),
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
                              hintText: "Enter Address",
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
                              hintText: "Enter GST Number",
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
                              hintText: "Enter Email",
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
                            child: Text(
                              "Total Balance:",
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13, right: 10, bottom: 5),
                          child: TextFormField(
                            controller: totalBalanceController,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              NoLeadingSpaceFormatter(),
                            ],
                            decoration: InputDecoration(
                              hintText: "Enter Total Balance",
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
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
