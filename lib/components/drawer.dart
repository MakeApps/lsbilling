import 'package:flutter/material.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
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
    setState(() {
      roleId = id;
    });
  }

  Future<void> _getBuildInformation() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersionInfo =
          "v${packageInfo.version} (Build ${packageInfo.buildNumber})";
    });
  }

  Widget _buildDrawerItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            height: 20,
            width: 20,
            color: whiteColor,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: whiteColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: drawerColor,
      shape: const RoundedRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [drawerColor, primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/icons/drawer-icon.png",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    roleId == "4" ? "Staff login..." : "Admin login...",
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  title: "Dashboard",
                  iconPath: "assets/icons/dashboard.png",
                  onTap: () => Navigator.pushNamed(context, '/dashboard_page'),
                ),
                _buildDrawerItem(
                  title: "Estimates",
                  iconPath: "assets/icons/estimate.png",
                  onTap: () =>
                      Navigator.pushNamed(context, '/estimate_listing'),
                ),
                _buildDrawerItem(
                  title: "Invoices",
                  iconPath: "assets/icons/invoice.png",
                  onTap: () =>
                      Navigator.pushNamed(context, '/invoice_page_listing'),
                ),
                _buildDrawerItem(
                  title: "Stocks",
                  iconPath: "assets/icons/stocks.png",
                  onTap: () =>
                      Navigator.pushNamed(context, '/stock_listing_screen'),
                ),
                _buildDrawerItem(
                  title: "Purchase Invoices",
                  iconPath: "assets/icons/invoice.png",
                  onTap: () =>
                      Navigator.pushNamed(context, '/purches_invoice_listing'),
                ),
                _buildDrawerItem(
                  title: "Vendors",
                  iconPath: "assets/icons/engineer.png",
                  onTap: () => Navigator.pushNamed(context, '/vendor_listing'),
                ),
                if (roleId != "4")
                  _buildDrawerItem(
                    title: "Staff",
                    iconPath: "assets/icons/staff.png",
                    onTap: () => Navigator.pushNamed(context, '/staff_listing'),
                  ),
                _buildDrawerItem(
                  title: "Settings",
                  iconPath: "assets/icons/setting.png",
                  onTap: () =>
                      Navigator.pushNamed(context, '/profile_info_page'),
                ),
              ],
            ),
          ),

          // Footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              border: const Border(
                top: BorderSide(color: Colors.white24, width: 0.5),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Powered by Localshout Technologies",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                if (appVersionInfo != null)
                  Text(
                    appVersionInfo!,
                    style: const TextStyle(
                      color: Colors.white38,
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
