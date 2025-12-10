import 'package:flutter/material.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/config/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? roleId;
  String? appVersionInfo;

  @override
  void initState() {
    super.initState();
    _loadRoleId();
    _getBuildInformation();
  }

  Future<void> _loadRoleId() async {
    final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');
    setState(() => roleId = id);
  }

  Future<void> _getBuildInformation() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersionInfo =
          "v${packageInfo.version} (Build ${packageInfo.buildNumber})";
    });
  }

  Widget _drawerItem({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: blackColorDark.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image.asset(
                  icon,
                  height: 18,
                  width: 18,
                  color: blackColorDark,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: blackColorDark,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 260,
      backgroundColor: drawerBg,
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/icons/local-shout-drawer.png",
                    height: 190,
                    width: 190,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: blackColorDark, thickness: 0.3),

          /// LISTING STARTS HERE (NO EXTRA SPACE)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerItem(
                    title: "Dashboard",
                    icon: "assets/icons/dashboard.png",
                    onTap: () =>
                        Navigator.pushNamed(context, '/dashboard_page'),
                  ),
                  _drawerItem(
                    title: "Customers",
                    icon: "assets/icons/user.png",
                    onTap: () =>
                        Navigator.pushNamed(context, '/customer_listing'),
                  ),
                  _drawerItem(
                    title: "Estimate",
                    icon: "assets/icons/estimate.png",
                    onTap: () =>
                        Navigator.pushNamed(context, '/estimate_listing'),
                  ),
                  _drawerItem(
                    title: "Invoices",
                    icon: "assets/icons/invoice.png",
                    onTap: () =>
                        Navigator.pushNamed(context, '/invoice_page_listing'),
                  ),
                  _drawerItem(
                    title: "Stocks",
                    icon: "assets/icons/stocks.png",
                    onTap: () =>
                        Navigator.pushNamed(context, '/stock_listing_screen'),
                  ),
                  _drawerItem(
                    title: "Purchase Invoice",
                    icon: "assets/icons/invoice.png",
                    onTap: () => Navigator.pushNamed(
                        context, '/purches_invoice_listing'),
                  ),
                  _drawerItem(
                    title: "Vendors",
                    icon: "assets/icons/engineer.png",
                    onTap: () =>
                        Navigator.pushNamed(context, '/vendor_listing'),
                  ),
                  if (roleId != "4")
                    _drawerItem(
                      title: "Staff",
                      icon: "assets/icons/staff.png",
                      onTap: () =>
                          Navigator.pushNamed(context, '/staff_listing'),
                    ),
                  _drawerItem(
                    title: "Settings",
                    icon: "assets/icons/setting.png",
                    onTap: () =>
                        Navigator.pushNamed(context, '/profile_info_page'),
                  ),
                ],
              ),
            ),
          ),

          /// ---------------------------------------------------------
          /// FOOTER
          /// ---------------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color:blackColor, width: 0.3),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Powered by Localshout Technologies",
                  style: TextStyle(color: blackColorDark, fontSize: 12),
                ),
                const SizedBox(height: 4),
                if (appVersionInfo != null)
                  Text(
                    appVersionInfo!,
                    style: const TextStyle(
                      color: blackColorDark,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:local_shout_billing/config/colors.dart';
// import 'package:local_shout_billing/config.dart' as app_instance;
// import 'package:package_info_plus/package_info_plus.dart';

// class DrawerWidget extends StatefulWidget {
//   const DrawerWidget({super.key});

//   @override
//   State<DrawerWidget> createState() => _DrawerWidgetState();
// }

// class _DrawerWidgetState extends State<DrawerWidget> {
//   String? roleId;
//   String? appVersionInfo;

//   @override
//   void initState() {
//     super.initState();
//     _loadRoleId();
//     _getBuildInformation();
//   }

//   Future<void> _loadRoleId() async {
//     final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');
//     setState(() {
//       roleId = id;
//     });
//   }

//   Future<void> _getBuildInformation() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     setState(() {
//       appVersionInfo =
//           "v${packageInfo.version} (Build ${packageInfo.buildNumber})";
//     });
//   }

//   Widget _buildDrawerItem({
//     required String title,
//     required String iconPath,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Container(
//         height: 36,
//         width: 36,
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: Image.asset(
//             iconPath,
//             height: 20,
//             width: 20,
//             color: hintTextColor,
//           ),
//         ),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: hintTextColor,
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       width: 280,
//       backgroundColor: drawerBg,
//       shape: const RoundedRectangleBorder(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//            Center(
//              child: ClipRRect(
//                borderRadius: BorderRadius.circular(12),
//                child: Image.asset(
//                  "assets/icons/ls-logo.png",
//                  height: 250, // logo height
//                  fit: BoxFit.contain,
//                ),
//              ),
//            ),

//           // Drawer Items
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildDrawerItem(
//                   title: "Dashboard",
//                   iconPath: "assets/icons/dashboard.png",
//                   onTap: () => Navigator.pushNamed(context, '/dashboard_page'),
//                 ),
//                 _buildDrawerItem(
//                   title: "Estimates",
//                   iconPath: "assets/icons/estimate.png",
//                   onTap: () =>
//                       Navigator.pushNamed(context, '/estimate_listing'),
//                 ),
//                 _buildDrawerItem(
//                   title: "Invoices",
//                   iconPath: "assets/icons/invoice.png",
//                   onTap: () =>
//                       Navigator.pushNamed(context, '/invoice_page_listing'),
//                 ),
//                 _buildDrawerItem(
//                   title: "Stocks",
//                   iconPath: "assets/icons/stocks.png",
//                   onTap: () =>
//                       Navigator.pushNamed(context, '/stock_listing_screen'),
//                 ),
//                 _buildDrawerItem(
//                   title: "Purchase Invoices",
//                   iconPath: "assets/icons/invoice.png",
//                   onTap: () =>
//                       Navigator.pushNamed(context, '/purches_invoice_listing'),
//                 ),
//                 _buildDrawerItem(
//                   title: "Vendors",
//                   iconPath: "assets/icons/engineer.png",
//                   onTap: () => Navigator.pushNamed(context, '/vendor_listing'),
//                 ),
//                 if (roleId != "4")
//                   _buildDrawerItem(
//                     title: "Staff",
//                     iconPath: "assets/icons/staff.png",
//                     onTap: () => Navigator.pushNamed(context, '/staff_listing'),
//                   ),
//                 _buildDrawerItem(
//                   title: "Settings",
//                   iconPath: "assets/icons/setting.png",
//                   onTap: () =>
//                       Navigator.pushNamed(context, '/profile_info_page'),
//                 ),
//               ],
//             ),
//           ),

          // // Footer
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(16),
          //   decoration: const BoxDecoration(
          //     color: drawerBg,
          //     border: Border(
          //       top: BorderSide(color: Colors.white24, width: 0.5),
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       const Text(
          //         "Powered by Localshout Technologies",
          //         style: TextStyle(
          //             color: hintTextColor,
          //             fontSize: 12,
          //             fontWeight: FontWeight.w500),
          //         textAlign: TextAlign.center,
          //       ),
          //       const SizedBox(height: 6),
          //       if (appVersionInfo != null)
          //         Text(
          //           appVersionInfo!,
          //           style: const TextStyle(
          //             color: hintTextColor,
          //             fontSize: 11,
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
//         ],
//       ),
//     );
//   }
// }
