import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/modules/Dashboard/dashboard_page.dart';
import 'package:local_shout_billing/modules/Profile/profile.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_update_bloc/profile_update_bloc_event.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import '../../job_sheet/bloc/profile_update_bloc/profile_update_bloc_bloc.dart';
import '../../job_sheet/bloc/profile_update_bloc/profile_update_bloc_state.dart';

class UpdateStaffProfile extends StatefulWidget {
  const UpdateStaffProfile({super.key});

  @override
  State<UpdateStaffProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateStaffProfile> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool validateFirstName = false;
  bool validateLastName = false;
  bool validateUserName = false;
  String? errorMesage;
  String? validatePasswor;
  String? validateConfirm;
  String? pinError;
  String? confirmPinError;
  bool obscureTextPin = true;
  bool obscureTextConfirmPin = true;
  final _formKey = GlobalKey<FormState>();

  assignValues(EditState state) {
    setState(() {
      firstnameController.text = state.staffModel!.firstName.toString();
      middleNameController.text = state.staffModel!.middleName.toString();
      lastNameController.text = state.staffModel!.lastName.toString();
      emailController.text = state.staffModel!.email.toString();
      passwordController.text = state.staffModel!.password.toString();
      confirmPassController.text = state.staffModel!.confirmPassword.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditBloc, EditState>(
      listener: (context, state) {
        if (state.staffStatus == EditStaffStatus.success) {
          CenterLoader.hide();
          assignValues(state);
        }
        if (state.staffStatus == EditStaffStatus.failure) {
          validatePasswor = state.errorpasswordMessage;
          validateConfirm = state.errorMessage;
        }
        if (state.staffStatus == EditStaffStatus.updated) {
          CenterLoader.hide();
          Fluttertoast.showToast(
            msg: "Profile updated successfully",
            backgroundColor: successColor,
            toastLength: Toast.LENGTH_SHORT,
          );
          context.read<ProfileSectionBloc>().add(
                const FetchProfileInfo(),
              );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
            return true;
          },
          child: MainLayout(
            title: const Text(
              "Update Profile",
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w600, color: whiteColor),
            ),
            showLeading: true,
            leading: IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              icon: const Icon(
                backarrow,
                color: whiteColor,
              ),
            ),
            showCurvedAppBar: true,
            showDefaultBottom: false,
            body: (state.staffStatus == EditStaffStatus.loading ||
                    state.staffStatus == EditStaffStatus.initial)
                ? const CenterLoader()
                : Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Card(
                                color: whiteColor,
                                margin: const EdgeInsets.only(
                                    left: 13, right: 13, top: 10),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      top: 10,
                                      right: 15,
                                      bottom: 10),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              "First Name:",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: blackColor,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                            Icon(Icons.star,
                                                color: redColor, size: 10)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        controller: firstnameController,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                            color: blackColor, fontSize: 14),
                                        inputFormatters: [
                                          NoLeadingSpaceFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          errorText: validateFirstName
                                              ? 'The first Name field is required'
                                              : null,
                                          filled: true,
                                          fillColor: lightGreyColor,
                                          hintText: "Enter  Name",
                                          hintStyle: const TextStyle(
                                              color: hintTextColor,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            validateFirstName =
                                                firstnameController
                                                    .text.isEmpty;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Middle Name:",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: blackColor,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        child: TextFormField(
                                          controller: middleNameController,
                                          style: const TextStyle(
                                              color: blackColor,
                                              fontSize: 14),
                                          keyboardType: TextInputType.text,
                                          inputFormatters: [
                                            NoLeadingSpaceFormatter(),
                                          ],
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            hintText: "Enter middle name",
                                            hintStyle: TextStyle(
                                                color: hintTextColor,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Last Name:",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: blackColor,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                            Icon(Icons.star,
                                                color: redColor, size: 10)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        child: TextFormField(
                                          controller: lastNameController,
                                          style: const TextStyle(
                                              color: blackColor,
                                              fontSize: 14),
                                          keyboardType: TextInputType.text,
                                          inputFormatters: [
                                            NoLeadingSpaceFormatter(),
                                          ],
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            errorText: validateLastName
                                                ? 'The first Name field is required'
                                                : null,
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            hintText: "Enter last name",
                                            hintStyle: const TextStyle(
                                                color: hintTextColor,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              validateLastName =
                                                  lastNameController
                                                      .text.isEmpty;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Email/Username:",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: blackColor,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                            Icon(Icons.star,
                                                color: redColor, size: 10)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 55,
                                        child: TextFormField(
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: blackColor,
                                              fontSize: 14),
                                          controller: emailController,
                                          keyboardType: TextInputType.text,
                                          inputFormatters: [
                                            NoLeadingSpaceFormatter(),
                                          ],
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            hintText: "Enter Email",
                                            hintStyle: TextStyle(
                                                color: hintTextColor,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Password:",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: blackColor,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                            Icon(Icons.star,
                                                color: redColor, size: 10)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 55,
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: blackColor,
                                              fontSize: 14),
                                          controller: passwordController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10)
                                          ],
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            errorText: validatePasswor,
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            hintText: "Enter Password",
                                            hintStyle: const TextStyle(
                                                color: hintTextColor,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                validatePasswor = null;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Confirm Password:",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: blackColor,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                            Icon(Icons.star,
                                                color: redColor, size: 10)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: blackColor,
                                              fontSize: 14),
                                          controller: confirmPassController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10)
                                          ],
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              borderSide: BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            errorText: validateConfirm,
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            hintText:
                                                "Enter confirm password",
                                            hintStyle: const TextStyle(
                                                color: hintTextColor,
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                validateConfirm = null;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: 280,
                                        child: ElevatedButton(
                                          style: const ButtonStyle(
                                        shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                            ),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    primaryColor),
                                            foregroundColor:
                                                WidgetStatePropertyAll(
                                                    blackColor),
                                          ),
                                          onPressed: () {
                                            // Manually validate fields
                                            setState(() {
                                              validateFirstName =
                                                  firstnameController
                                                      .text.isEmpty;
                                            });
                                            // Prepare the form data
                                            Map<String, dynamic> formData = {
                                              "id": state.staffModel!.id,
                                              "created_at_date": state
                                                  .staffModel!.createdAtDate,
                                              "created_at_time": state
                                                  .staffModel!.createdAtTime,
                                              "deleted_at":
                                                  state.staffModel!.deletedAt,
                                              "updated_at":
                                                  state.staffModel!.updatedAt,
                                              "company_id":
                                                  state.staffModel!.companyId,
                                              "confirmPassword":
                                                  confirmPassController.text,
                                              "password":
                                                  confirmPassController.text,
                                              "details": jsonEncode(
                                                  state.staffModel!.details),
                                              "email": emailController.text
                                                  .toString(),
                                              "first_name":
                                                  firstnameController.text
                                                      .toString(),
                                              "full_name": jsonEncode(
                                                  state.staffModel!.fullName),
                                              "last_name": lastNameController
                                                  .text
                                                  .toString(),
                                              "middle_name":
                                                  middleNameController.text
                                                      .toString(),
                                              "name": state.staffModel!.name,
                                              "profile_pic": state
                                                  .staffModel!.profilePic,
                                              "role_id":
                                                  state.staffModel!.roleId,
                                            };
                                            setState(() {
                                              if (firstnameController
                                                      .text.isNotEmpty &&
                                                  lastNameController
                                                      .text.isNotEmpty &&
                                                  passwordController
                                                      .text.isNotEmpty &&
                                                  confirmPassController
                                                      .text.isNotEmpty) {}
                                            });
                    
                                            // Trigger the update event
                                            context.read<EditBloc>().add(
                                                  UpdateStaffEvent(
                                                      id: state.staffModel!.id
                                                          .toString(),
                                                      formData: formData),
                                                );
                                          },
                                          child: const Text(
                                            "Update",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: blackColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
