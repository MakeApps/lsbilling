import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

import '../../components/center_loader.dart';

// ignore: must_be_immutable
class EditCustomerBox extends StatefulWidget {
  int? id;
  String? fullname;
  String? address;
  String? email;
  String? phoneno;
  EditCustomerBox(
      {super.key,
      this.id,
      this.address,
      this.email,
      this.fullname,
      this.phoneno});

  @override
  State<EditCustomerBox> createState() => _EditCustomerBoxState();
}

class _EditCustomerBoxState extends State<EditCustomerBox> {
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

  @override
  void initState() {
    super.initState();
    flagId = widget.id;
    _fullNameController.text = widget.fullname.toString();
    _addressController.text = widget.address.toString();
    _emailController.text = widget.email.toString();
    _phoneController.text = widget.phoneno.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) {
        if (state.status == JobSheetDetailsStatus.updated) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Customer details updated successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          context.read<JobSheetDetailsBloc>().add(GetEstimate(
              id: state.jobcardEstimateModel!.estimateId.toString()));
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
                              fontSize: 17, fontWeight: FontWeight.bold),
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
                                fontWeight: FontWeight.w600),
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
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter Full Name',
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 14),
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
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, bottom: 5, top: 3),
                      child: TextFormField(
                        controller: _addressController,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter Address',
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 14),
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
                          fontWeight: FontWeight.w600),
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
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 14),
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
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Icon(Icons.star, color: redColor, size: 10)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, bottom: 5, top: 3),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                        ],
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: '000000000000',
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 14),
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
                      height: 15,
                    ),
                    Container(
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
                              // "filter": "Estimate",
                              // "id_flag": flagId
                            };
                            context.read<JobSheetDetailsBloc>().add(
                                  UpdateCustomer(
                                      id: state.jobcardEstimateModel!.customerId
                                          .toString(),
                                      formData: formData),
                                );
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 16,
                              color: blackColor,
                              fontWeight: FontWeight.w600),
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
