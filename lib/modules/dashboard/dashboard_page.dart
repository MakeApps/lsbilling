import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/discard_dailog_component/show_exit_app/show_exit_dailog.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import '../../components/skeleton/dashbord_skeleton.dart';
import '../job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import '../job_sheet/bloc/profile_bloc/profile_section_event.dart';
import '../job_sheet/bloc/profile_bloc/profilesection_state.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? selectedFilter;
  @override
  void initState() {
    super.initState();
    context.read<ProfileSectionBloc>().add(
          const FetchProfileInfo(),
        );
    selectedFilter = 'Today';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      performFilterOperation(filterOption: "Today");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showExitConfirmation(context);
        return true;
      },
      child: MainLayout(
        title: Transform.translate(
          offset: const Offset(-9, 0),
          child: const Text(
            " My Dashboard",
            style: TextStyle(
                fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
          ),
        ),
        drawer: const DrawerWidget(),
        showFloatingActionButton: false,
        showLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.78,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(2, 0),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: const DrawerWidget(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset(0.0, 0.0);
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
                opaque: false,
              ),
            );
          },
          icon: const Icon(
            Icons.menu,
            color: whiteColor,
          ),
        ),
        showCurvedAppBar: false,
        ctx: 0,
        body: BlocConsumer<JobSheetBloc, JobSheetState>(
          listener: (context, state) {},
          builder: (context, state) {
            return (state.status == JobSheetStatus.loading ||
                    state.status == JobSheetStatus.initial)
                ? const Padding(
                    padding: EdgeInsets.all(8),
                    child: DashboardSkeleton(),
                  )
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Card(
                              color: backgroundColor,
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<ProfileSectionBloc,
                                          ProfileSectionState>(
                                      builder: (context, state) {
                                    final firstName = state.profileModel!.name;
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      child: Text(
                                        '''Hi, $firstName''',
                                        style: const TextStyle(
                                            color: blackColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    );
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Today's Status",
                                          style: TextStyle(
                                            color: blackColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 130,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border:
                                                  Border.all(color: blackColor),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: selectedFilter,
                                                hint: const Text(
                                                  "Filter By...",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: blackColor,
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: blackColor,
                                                ),
                                                isExpanded: true,
                                                alignment: Alignment.center,
                                                dropdownColor: whiteColor,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: blackColor,
                                                ),
                                                items: filterBy
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                        color: blackColor,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      selectedFilter = value;
                                                    });
                                                    performFilterOperation(
                                                        filterOption: value);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    _buildDashboardCard(
                                      title: "New Entries",
                                      count: state.dashboardModel!.newEntries
                                          .toString(),
                                      color: blueColor,
                                      icon: bill,
                                      arrowIcon: downarrow,
                                    ),
                                    _buildDashboardCard(
                                      title: "Delivered",
                                      count: state.dashboardModel!.delivered
                                          .toString(),
                                      color: successColor,
                                      icon: bill,
                                      arrowIcon: uparrow,
                                    ),
                                    _buildDashboardCardWithImage(
                                      title: "Total Outstanding",
                                      count: state
                                          .dashboardModel!.totalOutstanding
                                          .toString(),
                                      color: redColor,
                                      imagePath: 'assets/icons/estimate.png',
                                    ),
                                    _buildDashboardCardWithImage(
                                      title: "Total Revenue",
                                      count: state.dashboardModel!.totalRevenue
                                          .toString(),
                                      color: purpleColor,
                                      imagePath: 'assets/icons/estimate.png',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Estimate Card
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      context.read<JobSheetBloc>().add(
                                            const FetchEstimateList(
                                                status: JobSheetStatus.success),
                                          );
                                      Navigator.pushNamed(
                                          context, '/estimate_listing');
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      color: darkBlue,
                                      child: Container(
                                        width: 105,
                                        height: 136,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 44,
                                              width: 44,
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: const EdgeInsets.all(9),
                                              child: Image.asset(
                                                "assets/icons/estimate.png",
                                                height: 24,
                                                width: 24,
                                                color: darkBlue,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              state
                                                  .dashboardModel!.totalEstimate
                                                  .toString(),
                                              style: const TextStyle(
                                                color: whiteColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            const Text(
                                              "Estimate",
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Invoice Card
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      context.read<JobSheetBloc>().add(
                                            const FetchInvoiceList(
                                                status: JobSheetStatus.success),
                                          );
                                      Navigator.pushNamed(
                                          context, '/invoice_page_listing');
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      color: indigo,
                                      child: Container(
                                        width: 105,
                                        height: 136,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 44,
                                              width: 44,
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: const EdgeInsets.all(9),
                                              child: Image.asset(
                                                "assets/icons/invoice.png",
                                                height: 24,
                                                width: 24,
                                                color: indigo,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              state.dashboardModel!.totalInvoice
                                                  .toString(),
                                              style: const TextStyle(
                                                color: whiteColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            const Text(
                                              "Invoice",
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  performFilterOperation({String filterOption = "Today"}) async {
    FocusScope.of(context).unfocus();
    final getCurrentDate = app_instance.utility.getCurrentDate();
    var formatter = DateFormat('yyyy-MM-dd');

    switch (filterOption) {
      case "Today":
        final todayDate = DateTime.now();
        final formattedTodayDate = DateFormat('yyyy-MM-dd').format(todayDate);
        context.read<JobSheetBloc>().add(
              FetchDashboard(
                fromDate: formattedTodayDate,
                toDate: formattedTodayDate,
                status: JobSheetStatus.loading,
              ),
            );
        break;

      case "Yesterday":
        final getYesterdaysDate = app_instance.utility.getOldDate(dayCount: 1);
        context.read<JobSheetBloc>().add(
              FetchDashboard(
                  fromDate: getYesterdaysDate.toString(),
                  toDate: getYesterdaysDate.toString(),
                  status: JobSheetStatus.loading),
            );
        break;

      case "Last Week":
        DateTime now = DateTime.now();
        DateTime yesterday = now.subtract(
          const Duration(days: 1),
        );
        DateTime startDate = yesterday.subtract(
          const Duration(days: 6),
        );
        String formattedStartDate = formatter.format(startDate);
        String formattedEndDate = formatter.format(yesterday);
        context.read<JobSheetBloc>().add(
              FetchDashboard(
                fromDate: formattedStartDate,
                toDate: formattedEndDate,
                status: JobSheetStatus.loading,
              ),
            );
        break;

      case "This Month":
        final getFirstDate = app_instance.utility.thisMonthFirstDate();
        context.read<JobSheetBloc>().add(
              FetchDashboard(
                fromDate: getFirstDate.toString(),
                toDate: getCurrentDate.toString(),
                status: JobSheetStatus.loading,
              ),
            );
        break;

      case "Last Month":
        final getFirstDateOfLastMonth =
            app_instance.utility.lastMonthFirstDate();
        final getLastDateOfLastMonth = app_instance.utility.lastMonthLastDate();
        context.read<JobSheetBloc>().add(
              FetchDashboard(
                fromDate: getFirstDateOfLastMonth.toString(),
                toDate: getLastDateOfLastMonth.toString(),
                status: JobSheetStatus.loading,
              ),
            );
        break;

      case "Date":
        DateTime? selectedDate;
        DateTime? pickeddate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: primaryColor,
                  onPrimary: blackColor,
                  onSurface: blackColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: blackColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickeddate != null) {
          setState(
            () {
              selectedDate = pickeddate;
              var formatter = DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(selectedDate!);
              context.read<JobSheetBloc>().add(
                    FetchDashboard(
                      fromDate: formattedDate,
                      toDate: "",
                      status: JobSheetStatus.loading,
                    ),
                  );
            },
          );
        }
        break;

      case "Date Range":
        DateTimeRange? pickedDate = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: primaryColor,
                  onPrimary: blackColor,
                  onSurface: blackColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: blackColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          String formattedStartDate = formatter.format(pickedDate.start);
          String formattedEndDate = formatter.format(pickedDate.end);
          context.read<JobSheetBloc>().add(
                FetchDashboard(
                    fromDate: formattedStartDate,
                    toDate: formattedEndDate,
                    status: JobSheetStatus.loading),
              );
        }
        break;

      default:
        context.read<JobSheetBloc>().add(
              FetchDashboard(
                  fromDate: getCurrentDate.toString(),
                  toDate: getCurrentDate.toString(),
                  status: JobSheetStatus.loading),
            );
        break;
    }
  }

  Widget _buildDashboardCard({
    required String title,
    required String count,
    required Color color,
    required IconData icon,
    required IconData arrowIcon,
  }) {
    return Container(
      width: (MediaQuery.of(context).size.width - 30) / 2,
      height: 86,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14, color: color, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 3),
              Text(
                count,
                style: TextStyle(
                    color: color, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 3),
              Icon(arrowIcon, color: color),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDashboardCardWithImage({
    required String title,
    required String count,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      width: (MediaQuery.of(context).size.width - 30) / 2,
      height: 86,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14, color: color, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 19,
                height: 19,
                color: color,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 3),
              Text(
                count,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
