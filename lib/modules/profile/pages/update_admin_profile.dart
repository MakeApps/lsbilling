import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/modules/Dashboard/dashboard_page.dart';
import 'package:local_shout_billing/modules/Profile/profile.dart';

import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';

import '../../../components/skeleton/profile_image.dart';
import '../../job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import '../../job_sheet/bloc/profile_bloc/profile_section_event.dart';
import '../../job_sheet/bloc/profile_update_bloc/profile_update_bloc_bloc.dart';
import '../../job_sheet/bloc/profile_update_bloc/profile_update_bloc_event.dart';
import '../../job_sheet/bloc/profile_update_bloc/profile_update_bloc_state.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController workshopnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController vpaController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  String stateController = '';
  int? id;
  bool validateWorkshopName = false;
  bool isLoading = false;
  bool isGstEnabled = false; // Toggle state
  TextEditingController gstNumberController = TextEditingController();
  String userImage = "";
  String companylogothumb = "";
  //String image1 = "";
  File profileImage = File('');
  File companythumb = File('');
  // File image = File('');
  String? gstFlag;
  String createdDate = "";
  String createdTime = "";
  String deletedAt = "";
  String subscribEnd = "";
  String subscribStart = "";
  String updatedAt = "";

  final _formKey = GlobalKey<FormState>();

  assignValues(EditState state) {
    setState(() {
      id = state.updateProfileModel!.id;
      workshopnameController.text =
          state.updateProfileModel!.companyname.toString();
      emailController.text = state.updateProfileModel!.email.toString();
      usernameController.text = state.updateProfileModel!.username.toString();
      mobileNumberController.text =
          state.updateProfileModel!.mobileNumber.toString();
      userImage = state.updateProfileModel!.companyLogo.toString();
      streetAddressController.text =
          state.updateProfileModel!.address.toString();
      final addressMap = state
          .updateProfileModel!.address; // Assuming address is already a Map

      // Assign values from the address map
      streetAddressController.text = addressMap!['street'].toString();
      cityController.text = addressMap['city'].toString();
      stateController = addressMap['state'].toString();
      pincodeController.text = addressMap['pincode'].toString();

      bankNameController.text = state.updateProfileModel!.bankName.toString();
      accountNoController.text =
          state.updateProfileModel!.accountNumber.toString();
      ifscController.text = state.updateProfileModel!.ifsc.toString();
      branchNameController.text =
          state.updateProfileModel!.branchName.toString();
      vpaController.text = state.updateProfileModel!.vpa.toString();

      gstNumberController.text = state.updateProfileModel!.gstNumber.toString();
      gstFlag = state.updateProfileModel!.gstFlag.toString();
      isGstEnabled = convertStringToBool(gstFlag!);
      currencyController.text = state.updateProfileModel!.currency.toString();
      companylogothumb = state.updateProfileModel!.companyLogoThumb.toString();
      // image1 = state.updateProfileModel!.image.toString();
      createdDate = state.updateProfileModel!.createdAtDate.toString();
      createdTime = state.updateProfileModel!.createdAtTime.toString();
      deletedAt = state.updateProfileModel!.deletedAt.toString();
      subscribEnd = state.updateProfileModel!.subscriptionEnd.toString();
      subscribStart = state.updateProfileModel!.subscriptionStart.toString();
      updatedAt = state.updateProfileModel!.updatedAt.toString();
    });
  }

  convertStringToBool(String value) {
    if (value == "1") {
      return true;
    } else {
      return false;
    }
  }

  convertBoolToString(bool value) {
    if (value == true) {
      return "1";
    } else {
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditBloc, EditState>(
      listener: (context, state) {
        if (state.status == EditStatus.updated) {
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

        if (state.status == EditStatus.success) {
          assignValues(state);
        }
        if (state.status == EditStatus.updated) {
          gstFlag = state.updateProfileModel!.gstFlag.toString();
          isGstEnabled = gstFlag == "1";
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
            bottomNavigationBar: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    backgroundColor: const WidgetStatePropertyAll(primaryColor),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        validateWorkshopName =
                            workshopnameController.text.isEmpty;
                      },
                    );
                    Map<String, String> addressMap = {
                      "street": streetAddressController.text.toString(),
                      "city": cityController.text.toString(),
                      "state": stateController.toString(),
                      "pincode": pincodeController.text.toString(),
                    };
                    Map<String, dynamic> formData = {
                      "id": id,
                      "company_name": workshopnameController.text.toString(),
                      "username": usernameController.text.toString(),
                      "email": emailController.text.toString(),
                      "mobile_number": mobileNumberController.text.toString(),
                      "address": jsonEncode(addressMap),
                      "bank_name": bankNameController.text.toString(),
                      "act_no": accountNoController.text.toString(),
                      "ifsc": ifscController.text.toString(),
                      "brach_name": branchNameController.text.toString(),
                      "vpa": vpaController.text.toString(),
                      "gst_flag": gstFlag.toString(),
                      "gst_number": gstNumberController.text.toString(),
                      "currency": currencyController.text.toString(),
                      "company_logo": state.updateProfileModel!.companyLogo,
                      "company_logo_thumb":
                          state.updateProfileModel!.companyLogoThumb,
                      "created_at_date":
                          state.updateProfileModel!.createdAtDate,
                      "created_at_time":
                          state.updateProfileModel!.createdAtTime,
                      "company_type": state.updateProfileModel!.companyType,
                      "deleted_at": state.updateProfileModel!.deletedAt,
                      "sub_end": state.updateProfileModel!.subscriptionEnd,
                      "sub_start": state.updateProfileModel!.subscriptionStart,
                      "updated_at": state.updateProfileModel!.updatedAt,
                    };
                    if (workshopnameController.text.isNotEmpty) {
                      CenterLoader.show(context);
                    }
                    context.read<EditBloc>().add(
                          UpdateProfileFormEvent(
                              id: state.updateProfileModel!.id.toString(),
                              profileImage: profileImage,
                              formData: formData),
                        );
                    context.read<ProfileSectionBloc>().add(
                          const FetchProfileInfo(),
                        );
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(color: whiteColor, fontSize: 15),
                  ),
                ),
              ),
            ),
            body: (state.status == EditStatus.loading ||
                    state.status == EditStatus.initial)
                ? const CenterLoader()
                : Form(
                    key: _formKey,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.09,
                                  ),
                                  child: Card(
                                    color: whiteColor,
                                    margin: const EdgeInsets.only(
                                        left: 13, right: 13, top: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 70,
                                          right: 15,
                                          bottom: 10),
                                      child: Column(
                                        children: [
                                          const Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Company Name:",
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
                                            controller: workshopnameController,
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                                color: blackColor,
                                                fontSize: 14),
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
                                              errorText: validateWorkshopName
                                                  ? 'The company name field is required'
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
                                              setState(
                                                () {
                                                  validateWorkshopName =
                                                      workshopnameController
                                                          .text.isEmpty;
                                                },
                                              );
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
                                                  "Username:",
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
                                              controller: usernameController,
                                              keyboardType: TextInputType.text,
                                              inputFormatters: [
                                                NoLeadingSpaceFormatter(),
                                              ],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: lightGreyColor,
                                                hintText: "Enter username",
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
                                                  "Email:",
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                            height: 15,
                                          ),
                                          const Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Mobile Number:",
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
                                            height: 55,
                                            child: TextFormField(
                                              controller:
                                                  mobileNumberController,
                                              style: const TextStyle(
                                                  color: blackColor,
                                                  fontSize: 14),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                NoLeadingSpaceFormatter(),
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: lightGreyColor,
                                                hintText: "Enter mobile number",
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
                                                  "Street Address:",
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
                                            height: 55,
                                            child: TextFormField(
                                              controller:
                                                  streetAddressController,
                                              keyboardType: TextInputType.text,
                                              style: const TextStyle(
                                                  color: blackColor,
                                                  fontSize: 14),
                                              inputFormatters: [
                                                NoLeadingSpaceFormatter(),
                                                LengthLimitingTextInputFormatter(
                                                    50)
                                              ],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: lightGreyColor,
                                                hintText:
                                                    "Enter street address",
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
                                                  "City:",
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
                                            height: 55,
                                            child: TextFormField(
                                              controller: cityController,
                                              keyboardType: TextInputType.text,
                                              style: const TextStyle(
                                                  color: blackColor,
                                                  fontSize: 14),
                                              inputFormatters: [
                                                NoLeadingSpaceFormatter(),
                                              ],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: lightGreyColor,
                                                hintText: "Enter city name",
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
                                                  "State:",
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
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: DropdownButtonFormField(
                                              style: const TextStyle(
                                                  color: blackColor,
                                                  fontSize: 14),
                                              menuMaxHeight: 400,
                                              isExpanded: true,
                                              value: stateController.isNotEmpty
                                                  ? stateController
                                                  : null,
                                              decoration: const InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        26, 233, 229, 212),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        26, 233, 229, 212),
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: lightGreyColor,
                                              ),
                                              dropdownColor: whiteColor,
                                              hint: const Text(
                                                "Select state",
                                                style: TextStyle(
                                                    color: hintTextColor,
                                                    fontSize: 13),
                                              ),
                                              items: stateList.map<
                                                  DropdownMenuItem<String>>(
                                                (value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.toString(),
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                          color: greyColor,
                                                          fontFamily: 'Mulish',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                          wordSpacing: 3),
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  stateController =
                                                      value!.toString();
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
                                                  "Pincode:",
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
                                            height: 55,
                                            child: TextFormField(
                                              controller: pincodeController,
                                              style: const TextStyle(
                                                  color: blackColor,
                                                  fontSize: 14),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                NoLeadingSpaceFormatter(),
                                                LengthLimitingTextInputFormatter(
                                                    6)
                                              ],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: lightGreyColor,
                                                hintText:
                                                    "Enter pincode number",
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                //User image
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.045,
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        // fit: StackFit.expand,
                                        alignment: Alignment.topCenter,
                                        children: [
                                          SelectProfileImage(
                                            imageFile: profileImage,
                                            existedImageUrl: userImage,
                                            takeImage: takeCameraImage,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Card(
                              color: whiteColor,
                              margin: const EdgeInsets.only(
                                left: 13,
                                right: 13,
                                top: 10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 15, right: 15, bottom: 10),
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Bank Details:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: blackColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Bank Name:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: blackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: bankNameController,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                          color: blackColor, fontSize: 14),
                                      inputFormatters: [
                                        NoLeadingSpaceFormatter(),
                                        LengthLimitingTextInputFormatter(50)
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
                                        hintText: "Enter Bank Name",
                                        hintStyle: TextStyle(
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Account Number:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: blackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: accountNoController,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                          color: blackColor, fontSize: 14),
                                      inputFormatters: [
                                        NoLeadingSpaceFormatter(),
                                        LengthLimitingTextInputFormatter(20)
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
                                        hintText: "Enter Account Number",
                                        hintStyle: TextStyle(
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "IFSC:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: blackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: ifscController,
                                      keyboardType: TextInputType.text,
                                      inputFormatters: [
                                        NoLeadingSpaceFormatter(),
                                        LengthLimitingTextInputFormatter(12)
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
                                        hintText: "Enter IFSC",
                                        hintStyle: TextStyle(
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Branch Name:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: blackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: branchNameController,
                                      style: const TextStyle(
                                          color: blackColor, fontSize: 14),
                                      keyboardType: TextInputType.text,
                                      inputFormatters: [
                                        NoLeadingSpaceFormatter(),
                                        LengthLimitingTextInputFormatter(30)
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
                                        hintText: "Enter Branch Name",
                                        hintStyle: TextStyle(
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "VPA:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: blackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: vpaController,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                          color: blackColor, fontSize: 14),
                                      inputFormatters: [
                                        NoLeadingSpaceFormatter(),
                                        LengthLimitingTextInputFormatter(50)
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
                                        hintText: "Enter VPA",
                                        hintStyle: TextStyle(
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Currency:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: blackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 55,
                                      child: TextFormField(
                                        controller: currencyController,
                                        style: const TextStyle(
                                            color: blackColor, fontSize: 14),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "GST support:",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "Toggle to enable tax billing feature",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: hintTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Switch(
                                          value: isGstEnabled,
                                          onChanged: (value) {
                                            setState(() {
                                              isGstEnabled = value;
                                            });
                                            gstFlag =
                                                convertBoolToString(value);
                                            context.read<EditBloc>().add(
                                                  UpdateGstGlag(
                                                    id: state
                                                        .updateProfileModel!.id
                                                        .toString(),
                                                    gstFlag: gstFlag,
                                                  ),
                                                );
                                          },
                                          activeColor: Colors.amber,
                                        ),
                                      ],
                                    ),
                                    if (isGstEnabled)
                                      const SizedBox(height: 16),
                                    if (isGstEnabled)
                                      TextFormField(
                                        controller: gstNumberController,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                            color: blackColor, fontSize: 14),
                                        inputFormatters: [
                                          NoLeadingSpaceFormatter(),
                                          LengthLimitingTextInputFormatter(15)
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
                                          hintText: "Enter GST Number",
                                          hintStyle: TextStyle(
                                              color: hintTextColor,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Future<void> takeCameraImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 25,
    );

    if (pickedFile != null) {
      setState(
        () {
          profileImage = File(pickedFile.path);
          isLoading = true;
        },
      );
      await Future.delayed(
        const Duration(seconds: 1),
      );
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }
}
