import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

import '../../models/customer_model.dart';

// ignore: must_be_immutable
class EditInvoiceCustomerByJobSheet extends StatefulWidget {
  int? id;
  CustomerModel? customerModel;
  EditInvoiceCustomerByJobSheet(
      {super.key, this.id, required this.customerModel});

  @override
  State<EditInvoiceCustomerByJobSheet> createState() =>
      _EditInvoiceCustomerByJobSheetState();
}

class _EditInvoiceCustomerByJobSheetState
    extends State<EditInvoiceCustomerByJobSheet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool nameValidate = false;
  bool mobileValidate = false;
  int? flagId;
  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  assignValues(JobSheetDetailsState state) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      flagId = widget.id;
      _fullNameController.text = widget.customerModel!.fullName.toString();
      _addressController.text = widget.customerModel!.address.toString();
      _emailController.text = widget.customerModel!.email.toString();
      _phoneController.text = widget.customerModel!.mobileNumber.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) {
        if (state.status == JobSheetDetailsStatus.customerUpdatedSyccessfully) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Customer details updated successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          context.read<JobSheetDetailsBloc>().add(
                GetInvoiceByJobSheet(
                  id: state.invoiceModel!.invoiceId.toString(),
                ),
              );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Dialog(
          backgroundColor: whiteColor,
          shape: const RoundedRectangleBorder(),
          insetPadding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Edit Customer Details',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(clearIcon),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Full Name:",
                            style: TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Icon(Icons.star, color: redColor, size: 10)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, bottom: 5, top: 3),
                      child: TextFormField(
                        controller: _fullNameController,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          LengthLimitingTextInputFormatter(30)
                        ],
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Enter Full Name',
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13),
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 20.0,
                          ),
                          errorText: nameValidate
                              ? "Please enter correct full name"
                              : null,
                          filled: true,
                          fillColor: lightGreyColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Address:',
                      style: TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, bottom: 5, top: 3),
                      child: TextFormField(
                        controller: _addressController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          LengthLimitingTextInputFormatter(50)
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter Address',
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13),
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 20.0,
                          ),
                          filled: true,
                          fillColor: lightGreyColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Email:',
                      style: TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, bottom: 5, top: 3),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                        ],
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13),
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 20.0,
                          ),
                          filled: true,
                          fillColor: lightGreyColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Phone Number:",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500),
                            )),
                        Icon(Icons.star, color: redColor, size: 10)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, bottom: 5, top: 3),
                      child: TextFormField(
                        controller: _phoneController,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                          LengthLimitingTextInputFormatter(10)
                        ],
                        decoration: InputDecoration(
                          hintText: '000000000000',
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13),
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 20.0,
                          ),
                          errorText: mobileValidate
                              ? "The mobile Number field is reqired"
                              : null,
                          filled: true,
                          fillColor: lightGreyColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 50,
                      width: 275,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: primaryColor),
                        onPressed: () {
                          setState(() {
                            nameValidate = _fullNameController.text.isEmpty;
                            mobileValidate = _phoneController.text.isEmpty;
                          });
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> formData = {
                              "full_name": _fullNameController.text.toString(),
                              "address": _addressController.text.toString(),
                              "email": _emailController.text.toString(),
                              "mobile_number": _phoneController.text.toString(),
                              //     "filter": "Invoice",
                              // "id_flag": flagId
                            };
                            context.read<JobSheetDetailsBloc>().add(
                                  UpdateCustomer(
                                      id: state.invoiceModel!.customerId
                                          .toString(),
                                      formData: formData),
                                );
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 14,
                              color: whiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
