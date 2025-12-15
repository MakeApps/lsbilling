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

  Widget _buildDrawerItem({
    required String title,
    required String iconPath,
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
                  iconPath,
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
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             // ---------------- HEADER (BIG LOGO + ZERO EXTRA SPACE) ----------------
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.asset(
                "assets/icons/ls-logo.png",
                fit: BoxFit.cover,
              ),
                        ),
            ),
          /// Very Thin Divider
          Container(
            width: double.infinity,
            height: 0.8,
            color: Colors.black.withOpacity(0.15),
          ),

          /// -------- MENU LIST --------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
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

          /// -------- FOOTER (Exact Image 2 Style) --------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black.withOpacity(0.15),
                  width: 0.8,
                ),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Powered by Localshouts Technologies",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
                if (appVersionInfo != null)
                  Text(
                    appVersionInfo!,
                    style: const TextStyle(
                      color: Colors.black87,
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