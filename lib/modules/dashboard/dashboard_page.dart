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
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileSectionBloc, ProfileSectionState>(
                        builder: (context, state) {
                          final firstName = state.profileModel!.name;
                          return Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                const Text(
                                  '''Welcome Back , ''',
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  firstName.toString(),
                                  style: const TextStyle(
                                      color: indigo,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        color: whiteColor,
                        shape: const RoundedRectangleBorder(),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 12, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Overview",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
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
                                                        color: blackColorDark,
                                                        fontWeight:
                                                            FontWeight.w500,
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

                              //box
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 10,
                                    children: [
                                      _buildDashboardCardWithImage(
                                        title: "Total Outstanding",
                                        count: state
                                            .dashboardModel!.totalOutstanding
                                            .toString(),
                                        color: redColor,
                                        boxBgColor: dashboardbox1,
                                        imagePath: 'assets/icons/estimate.png',
                                      ),
                                      _buildDashboardCardWithImage(
                                        title: "Total Revenue",
                                        count: state
                                            .dashboardModel!.totalRevenue
                                            .toString(),
                                        color: optButton,
                                        boxBgColor: dashboardbox2,
                                        imagePath: 'assets/icons/estimate.png',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),

                              Column(
                                children: [
                                  _buildCardWithCountAndTitle(
                                    title: "Total Estimate",
                                    count: state.dashboardModel!.totalEstimate
                                        .toString(),
                                    imageColor: redColor,
                                    boxBgColor: dashboardbox1,
                                    imagePath: 'assets/icons/estimate.png',
                                    route: '/estimate_listing',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _buildCardWithCountAndTitle(
                                    title: "Total Invoices",
                                    count: state.dashboardModel!.totalInvoice
                                        .toString(),
                                    imageColor: optButton,
                                    boxBgColor: dashboardbox2,
                                    imagePath: 'assets/icons/invoice.png',
                                    route: '/invoice_page_listing',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _buildCardWithCountAndTitle(
                                    title: "Total Stocks",
                                    count: state.dashboardModel!.totalProduct
                                        .toString(),
                                    imageColor: stockImage,
                                    boxBgColor: dashboardbox4,
                                    imagePath: 'assets/icons/stocks.png',
                                    route: '/stock_listing_screen',
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildDashboardCardWithImage({
    required String title,
    required String count,
    required Color color,
    required Color boxBgColor,
    required String imagePath,
  }) {
    return Container(
      width: (MediaQuery.of(context).size.width - 30) / 2,
      height: 86,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: boxBgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              imagePath,
              width: 25,
              height: 25,
              color: whiteColor,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 13,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 3),
              Text(
                count,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: blackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardWithCountAndTitle({
    required String title,
    required String count,
    required Color imageColor,
    required Color boxBgColor,
    required String imagePath,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 25),
        height: 86,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: hintTextColor),
          color: whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: boxBgColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                imagePath,
                width: 25,
                height: 25,
                color: imageColor,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 13,
                      color: blackColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 3),
                Text(
                  count,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: blackColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
