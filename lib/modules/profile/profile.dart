import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/modules/Dashboard/dashboard_page.dart';
import 'package:local_shout_billing/modules/Profile/pages/change_password.dart';
import 'package:local_shout_billing/modules/Profile/pages/update_admin_profile.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profilesection_state.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import '../job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import '../job_sheet/bloc/profile_update_bloc/profile_update_bloc_bloc.dart';
import '../job_sheet/bloc/profile_update_bloc/profile_update_bloc_event.dart';
import 'pages/update_staff_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? roleId;

  @override
  void initState() {
    super.initState();

    _loadRoleId();
  }

  Future<void> _loadRoleId() async {
    final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');

    setState(() {
      roleId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
        );
        return true;
      },
      child: MainLayout(
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w600, color: whiteColor),
        ),
        showFloatingActionButton: false,
        showLeading: true,
        leading: IconButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardPage(),
              ),
            );
          },
          icon: const Icon(
            backarrow,
            color: whiteColor,
          ),
        ),
        showDefaultBottom: false,
        showCurvedAppBar: true,
        bottomNavigationBar: SafeArea(
          child: SizedBox(
            height: 90,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02,
              ),
              color: greyColor,
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: whiteColor,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () async {
                  bool? shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: whiteColor,
                        shape: const RoundedRectangleBorder(),
                        content: const Text(
                          'Are you sure you want to logout?',
                          style: TextStyle(
                            fontSize: 15,
                            color: blackColorDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(color: primaryColor),
                              backgroundColor: whiteColor,
                              foregroundColor: blackColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  if (shouldLogout == true) {
                    //FIRE EVENT
                    context.read<ProfileSectionBloc>().add(
                          const LogoutUser(),
                        );
                  }
                },
              ),
            ),
          ),
        ),
        body: BlocConsumer<ProfileSectionBloc, ProfileSectionState>(
          listener: (context, state) {
            if (state.logoutStatus == LogoutStatus.loading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                },
              );
            }

            if (state.logoutStatus == LogoutStatus.success) {
              Navigator.pop(context); // close loader

              context.read<JobSheetBloc>().add(
                    const ClearListingData(),
                  );
              context.read<JobSheetDetailsBloc>().add(
                    const ClearData(),
                  );

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login_screen',
                (route) => false,
              );
            }

            if (state.logoutStatus == LogoutStatus.failure) {
              Navigator.pop(context); // close loader
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logout failed! Please try again."),
                ),
              );
            }
          },
          builder: (context, state) {
            final profile = state.profileModel!.companyLogo.toString();

            return (state.status == ProfileSectionStatus.loading ||
                    state.status == ProfileSectionStatus.initial)
                ? const Padding(
                    padding: EdgeInsets.all(8),
                    child: CenterLoader(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (roleId != null && roleId != '4') {
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateProfile(),
                                    ),
                                  );
                                  context.read<EditBloc>().add(
                                        EditAdminEvent(
                                          id: state.profileModel!.companyId
                                              .toString(),
                                        ),
                                      );
                                },
                              );
                            } else {
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateStaffProfile(),
                                    ),
                                  );
                                  context.read<EditBloc>().add(
                                        EditStaffEvent(
                                          id: state.profileModel!.id.toString(),
                                        ),
                                      );
                                },
                              );
                            }
                          },
                          child: Card(
                            color: whiteColor,
                            shape: const RoundedRectangleBorder(),
                            margin: const EdgeInsets.only(
                                left: 13, right: 13, top: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 33,
                                        backgroundColor: blackColor,
                                        child: ClipOval(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(33),
                                            child: profile.isNotEmpty
                                                ? CachedNetworkImage(
                                                    imageUrl: profile,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(
                                                      color: whiteColor,
                                                      height: 250,
                                                      width: 164,
                                                      child: const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return const Icon(
                                                          imageNotSupport,
                                                          size: 68,
                                                          color: hintTextColor);
                                                    },
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 2),
                                                    child: Image.asset(
                                                      "assets/icons/user.png",
                                                      height: 30,
                                                      width: 30,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.profileModel!.name.toString(),
                                            style: const TextStyle(
                                                color: blackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            state.profileModel!.email
                                                .toString(),
                                            style: const TextStyle(
                                                color: hintTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: whiteColor,
                          shape: const RoundedRectangleBorder(),
                          margin: const EdgeInsets.only(
                              left: 13, right: 13, top: 15),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset(
                                  "assets/icons/user.png",
                                  height: 20,
                                  width: 20,
                                  color: hintTextColor,
                                ),
                                title: const Padding(
                                  padding: EdgeInsets.only(left: 3),
                                  child: Text(
                                    "Update Profile",
                                    style: TextStyle(
                                        color: blackColor, fontSize: 14),
                                  ),
                                ),
                                trailing: Image.asset(
                                  "assets/icons/next-arrow.png",
                                  height: 15,
                                  width: 15,
                                  color: hintTextColor,
                                ),
                                onTap: () {
                                  if (roleId != null && roleId != '4') {
                                    setState(
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const UpdateProfile(),
                                          ),
                                        );
                                        context.read<EditBloc>().add(
                                              EditAdminEvent(
                                                id: state
                                                    .profileModel!.companyId
                                                    .toString(),
                                              ),
                                            );
                                      },
                                    );
                                  } else {
                                    setState(
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const UpdateStaffProfile(),
                                          ),
                                        );
                                        context.read<EditBloc>().add(
                                              EditStaffEvent(
                                                id: state.profileModel!.id
                                                    .toString(),
                                              ),
                                            );
                                      },
                                    );
                                  }
                                },
                              ),
                              if (roleId != null && roleId != '4') ...[
                                const Divider(
                                  color: backgroundColor,
                                  thickness: 4,
                                ),
                              ],
                              if (roleId != null && roleId != '4') ...[
                                ListTile(
                                  leading: Image.asset(
                                    "assets/icons/lock.png",
                                    height: 20,
                                    width: 20,
                                    color: hintTextColor,
                                  ),
                                  title: const Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: Text(
                                      "Change Password",
                                      style: TextStyle(
                                          color: blackColor, fontSize: 14),
                                    ),
                                  ),
                                  trailing: Image.asset(
                                    "assets/icons/next-arrow.png",
                                    height: 15,
                                    width: 15,
                                    color: hintTextColor,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ChangePassword(),
                                      ),
                                    );
                                  },
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
