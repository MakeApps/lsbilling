import 'package:local_shout_billing/modules/Profile/profile.dart';
import 'package:local_shout_billing/modules/estimate/create_estimate_form.dart';
import 'package:local_shout_billing/modules/invoice/create_invoice_form.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import 'modules/job_sheet/bloc/profile_bloc/profilesection_state.dart';

// ignore: must_be_immutable
class MainLayout extends StatefulWidget {
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;
  final Widget? body;
  final Widget? title;
  final Widget? leading;
  final bool? showFloatingActionButton;
  final bool? showLeading;
  final Widget? floatingActionButtonLocation;
  final bool? showDefaultBottom;
  final bool? showCurvedAppBar;
  final bool? showUseIcon;
  final bool? resizeToAvoidBottomInset;
  int ctx;
  int titleSpacing;

  MainLayout(
      {super.key,
      this.drawer,
      this.bottomNavigationBar,
      this.actions = const [],
      this.body,
      this.title,
      this.leading,
      this.showFloatingActionButton = true,
      this.showUseIcon = true,
      this.showDefaultBottom = true,
      this.showLeading = false,
      this.floatingActionButtonLocation,
      this.ctx = 0,
      this.titleSpacing = 0,
      this.showCurvedAppBar = false,
      this.resizeToAvoidBottomInset = true});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset ?? true,
      appBar: AppBar(
        //centerTitle: true,
        title: widget.title,
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: blackColor,
        automaticallyImplyLeading: false,
        shape: (widget.showCurvedAppBar == true)
            ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(20, 20),
                ),
              )
            : null,
        leading: (!widget.showLeading!) ? null : widget.leading,

        actions: const [HumbergerIconButton()],
      ),
      drawer: widget.drawer,
      body: widget.body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (widget.showDefaultBottom != true ||
              widget.ctx == 0)
          ? null
          : Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100, right: 10),
                child: Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
                  child: FloatingActionButton(
                    backgroundColor: primaryColor,
                    foregroundColor: blackColor,
                    onPressed: () {
                      switch (widget.ctx) {
                        case 1:
                          if (widget.ctx == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateEstimateForm(),
                              ),
                            );
                          }
                          break;
                        case 2:
                          if (widget.ctx == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateInvoiceForm(),
                              ),
                            );
                          }
                          break;
                        default:
                          break;
                      }
                    },
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add,
                      size: 29,
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: (widget.showDefaultBottom != true)
          ? widget.bottomNavigationBar
          : Container(
              height: 70, // ← set desired height
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 0), // ← remove extra space
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: blackColor,
                unselectedItemColor: hintTextColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: widget.ctx,
                selectedFontSize: 13, // ← Smaller title
                unselectedFontSize: 11,
                iconSize: 20, // ← Smaller icon size
                onTap: (value) async {
                  if (widget.ctx != value) {
                    setState(() => widget.ctx = value);
                  }
                  Future.microtask(
                    () {
                      switch (value) {
                        case 0:
                          Navigator.pushReplacementNamed(
                              context, '/dashboard_page');
                          break;
                        case 1:
                          Navigator.pushReplacementNamed(
                              context, '/estimate_listing');
                          break;
                        case 2:
                          Navigator.pushReplacementNamed(
                              context, '/invoice_page_listing');
                          break;
                      }
                    },
                  );
                },
                items: [
                  BottomNavigationBarItem(
                    label: "Dashboard",
                    icon: navItemModern(
                      "assets/icons/dashboard.png",
                      widget.ctx == 0,
                      size: 30,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Estimate",
                    icon: navItemModern(
                      "assets/icons/estimate.png",
                      widget.ctx == 1,
                      size: 30,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Invoice",
                    icon: navItemModern(
                      "assets/icons/invoice.png",
                      widget.ctx == 2,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget navItemModern(String icon, bool isActive, {double size = 22}) {
    return Image.asset(
      icon,
      height: size,
      width: size,
      color: isActive ? blackColorDark : hintTextColor,
    );
  }
}

class CloseButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double curveHeight = 50;
    double curveWidth = 90;

    double bottomCornerRadius = 40;
    double rectangleHeight = 192;

    path.moveTo(0, 0);
    path.lineTo(0, rectangleHeight - bottomCornerRadius - curveHeight);
    path.quadraticBezierTo(
      0,
      rectangleHeight - curveHeight,
      bottomCornerRadius,
      rectangleHeight - curveHeight,
    );
    path.lineTo((size.width - curveWidth) / 2, rectangleHeight - curveHeight);

    path.quadraticBezierTo(
      size.width / 2,
      rectangleHeight + curveHeight / 2,
      (size.width + curveWidth) / 2,
      rectangleHeight - curveHeight,
    );

    path.lineTo(size.width - bottomCornerRadius, rectangleHeight - curveHeight);
    path.quadraticBezierTo(
      size.width,
      rectangleHeight - curveHeight,
      size.width,
      rectangleHeight - curveHeight - bottomCornerRadius,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HumbergerIconButton extends StatelessWidget {
  const HumbergerIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: BlocBuilder<ProfileSectionBloc, ProfileSectionState>(
        builder: (context, state) {
          final profile = state.profileModel!.companyLogo.toString();

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
              context.read<ProfileSectionBloc>().add(
                    const FetchProfileInfo(),
                  );
            },
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 16,
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(16),
                  child: profile.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: profile,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 80,
                            width: 40,
                            color: whiteColor,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) {
                            return const Icon(imageNotSupport,
                                size: 68, color: hintTextColor);
                          },
                        )
                      : Image.asset(
                          "assets/icons/user-blue.png",
                          height: 10,
                          width: 10,
                          color: blackColor,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
