import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/discard_dailog_component/discard_from_page/discard_create_staff.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/staff/bloc/staff_bloc/staff_bloc.dart';

class CreateStaffScreen extends StatefulWidget {
  const CreateStaffScreen({super.key});

  @override
  State<CreateStaffScreen> createState() => _CreateStaffScreenState();
}

class _CreateStaffScreenState extends State<CreateStaffScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _exitConfirmationDialog = const DiscardCreateStaffDailog();

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StaffBloc, StaffState>(
      listener: (context, state) {
        if (state.staffStatus == CreateStaffStatus.creating) {
          CenterLoader.show(context);
        } else if (state.staffStatus == CreateStaffStatus.created) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Staff added successfully",
              textColor: whiteColor,
              backgroundColor: successColor);

          Navigator.pushNamed(context, '/staff_listing');
        }
        if (state.staffStatus == CreateStaffStatus.error) {
          CenterLoader.hide();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          final shouldExit = await _exitConfirmationDialog.show(context);
          if (shouldExit) {
            Navigator.pushNamed(context, '/staff_listing');
            return true;
          } else {
            return false;
          }
        },
        child: MainLayout(
          title: const Text(
            'Create Staff',
            style: TextStyle(
                fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
          ),
          drawer: const DrawerWidget(),
          showCurvedAppBar: true,
          showFloatingActionButton: false,
          showLeading: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              backarrow,
              color: whiteColor,
            ),
          ),
          showDefaultBottom: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () async {
                final shouldExit = await _exitConfirmationDialog.show(context);
                if (shouldExit) {
                  Navigator.pushNamed(context, '/staff_listing');
                }
              },
            ),
          ],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(color: whiteColor),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> formData = {
                      "phoneNo": '',
                      "gender": '',
                      "birthDate": '',
                      "email": emailController.text.toString(),
                      "first_name": firstNameController.text.toString(),
                      "last_name": lastNameController.text.toString(),
                      "middle_name": middleNameController.text.toString(),
                      "confirmPassword": confirmPasswordController.text,
                      "password": passwordController.text,
                      "role_id": 4,
                    };
                    context.read<StaffBloc>().add(
                          CreateStaff(formData: formData),
                        );
                  }
                },
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              child: Card(
                shape: const RoundedRectangleBorder(),
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("First Name", isRequired: true),
                      buildTextField("Enter First Name", firstNameController,
                          isRequired: true, fieldKey: "first_name"),
                      const SizedBox(height: 15),
                      buildLabel("Middle Name"),
                      buildTextField("Enter Middle Name", middleNameController),
                      const SizedBox(height: 15),
                      buildLabel("Last Name", isRequired: true),
                      buildTextField("Enter Last Name", lastNameController,
                          isRequired: true, fieldKey: "last_name"),
                      const SizedBox(height: 15),
                      buildLabel("Email or Username", isRequired: true),
                      buildTextField("Enter Email or Username", emailController,
                          isRequired: true, fieldKey: "email"),
                      const SizedBox(height: 15),
                      buildLabel("Password", isRequired: true),
                      buildTextField("Enter Password", passwordController,
                          isRequired: true,
                          isPassword: true,
                          fieldKey: "password"),
                      const SizedBox(height: 15),
                      buildLabel("Confirm password", isRequired: true),
                      buildTextField(
                          "Confirm Password", confirmPasswordController,
                          isRequired: true,
                          isPassword: true,
                          fieldKey: "confirmPassword"),
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

  Widget buildLabel(String text, {bool isRequired = false}) {
    return Row(
      children: [
        Text(
          "$text:",
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        if (isRequired) const Icon(Icons.star, size: 10, color: Colors.red),
      ],
    );
  }

  Widget buildTextField(
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
    bool isRequired = false,
    String? fieldKey,
  }) {
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
        String? apiError;
        if (fieldKey != null && state.fieldErrors.containsKey(fieldKey)) {
          apiError = state.fieldErrors[fieldKey]?.join(", ");
        }

        return TextFormField(
          controller: controller,
          obscureText: isPassword,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            errorText: apiError,
            hintStyle: const TextStyle(
              color: hintTextColor,
              fontFamily: 'Mulish',
              fontSize: 13,
            ),
            contentPadding: const EdgeInsets.only(left: 15, right: 20.0),
            filled: true,
            fillColor: textfieldBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            ),
          ),
          onChanged: (_) {
            if (apiError != null) {
              setState(() {
                state.fieldErrors.remove(fieldKey);
              });
            }
          },
          validator: (value) {
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return "This field is required";
            }
            if (hint == "Confirm Password" &&
                value != passwordController.text.trim()) {
              return "Passwords do not match";
            }
            return null;
          },
        );
      },
    );
  }
}
