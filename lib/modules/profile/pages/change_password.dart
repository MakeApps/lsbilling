import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/modules/Profile/profile.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import 'package:local_shout_billing/modules/login/pages/login_page.dart';
import '../../job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import '../../job_sheet/bloc/profile_bloc/profilesection_state.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? passwordErrorMessage;
  String? confirmPasswordErrorMessage;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileSectionBloc, ProfileSectionState>(
      listener: (context, state) {
        if (state.status == ProfileSectionStatus.passwrordLoading) {
          CenterLoader.show(context);
        } else if (state.status == ProfileSectionStatus.passwordUpdated) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Password change Successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);

          newPasswordController.clear();
          confirmPasswordController.clear();
        } else if (state.status == ProfileSectionStatus.passwordFailure) {
          CenterLoader.hide();
          setState(() {
            passwordErrorMessage = state.passwordErrorMessage;
            confirmPasswordErrorMessage = state.errorMessage;
          });
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: MainLayout(
          title: const Text(
            "Password Change",
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
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    color: whiteColor,
                    margin: const EdgeInsets.only(left: 13, right: 13, top: 18),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 15, right: 15, bottom: 10),
                      child: Column(
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "New Password:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10)
                                ],
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: newPasswordController,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              NoLeadingSpaceFormatter(),
                            ],
                            style: const TextStyle(
                                color: blackColor, fontSize: 14),
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
                              errorText: passwordErrorMessage,
                              filled: true,
                              fillColor: lightGreyColor,
                              hintText: "Enter New Password",
                              hintStyle: const TextStyle(
                                  color: hintTextColor,
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                            onChanged: (value) {
                              setState(() {
                                passwordErrorMessage = null;
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
                                    "Confirm Password:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star, color: redColor, size: 10)
                                ],
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
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
                              filled: true,
                              errorText: confirmPasswordErrorMessage,
                              fillColor: lightGreyColor,
                              hintText: "Confirm Password",
                              hintStyle: const TextStyle(
                                  color: hintTextColor,
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                            onChanged: (value) {
                              setState(() {
                                confirmPasswordErrorMessage = null;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                backgroundColor:
                                    const WidgetStatePropertyAll(primaryColor),
                              ),
                              onPressed: () async {
                                final String? id =
                                    await app_instance.storage.read(key: 'id');
                                setState(
                                  () {
                                    // clear old errors before API call
                                    passwordErrorMessage = null;
                                    confirmPasswordErrorMessage = null;
                                  },
                                );
                                 if (_formKey.currentState!.validate()) {
                                  context.read<ProfileSectionBloc>().add(
                                        UpdatePassword(
                                          id: id.toString(),
                                          password: newPasswordController.text,
                                          confPassword:
                                              confirmPasswordController.text,
                                        ),
                                      );
                                }
                              },
                              child: const Text(
                                "Change Password",
                                style:
                                    TextStyle(color: blackColor, fontSize: 15),
                              ),
                            ),
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
  }
}
