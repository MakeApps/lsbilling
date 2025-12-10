import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/discard_dailog_component/show_exit_app/show_exit_dailog.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import '../../components/invoice page/invoice_list_row.dart';
import '../../components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

class InvoiceListingPage extends StatefulWidget {
  const InvoiceListingPage({super.key});

  @override
  State<InvoiceListingPage> createState() => _InvoiceListingPageState();
}

class _InvoiceListingPageState extends State<InvoiceListingPage> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String? _selectedPaymentStatus;
  bool isFilterApplied = false;
  String appliedFromDate = "";
  String appliedToDate = "";

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    _fetchInitialInvoice();
    context.read<ProfileSectionBloc>().add(
          const FetchProfileInfo(),
        );
  }

  @override
  void dispose() {
    _searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _fetchInitialInvoice() {
    context.read<JobSheetBloc>().add(
          const FetchInvoiceList(
            status: JobSheetStatus.loading,
          ),
        );
  }

  void _onScroll() {
    final jobSheetState = context.read<JobSheetBloc>().state;

    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !jobSheetState.hasReachedMax!) {
      context.read<JobSheetBloc>().add(
            FetchInvoiceList(
              status: JobSheetStatus.success,
              timestamp: jobSheetState.lastTimestamp,
              fromDate: "",
              toDate: "",
              searchKeyword: _searchController.text,
              direction: 'down',
              gstFilter: jobSheetState.selectedGstFilter,
              paymentStatus: _mapToApiPaymentStatus(_selectedPaymentStatus),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showExitConfirmation(context);
        return true;
      },
      child: MainLayout(
        key: _scaffoldKey,
        ctx: 2,
        title: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text(
              "Invoices",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Inter',
                  color: whiteColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        showLeading: true,
        titleSpacing: 0,
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

                  var tween = Tween(begin: begin, end: end).chain(
                    CurveTween(curve: curve),
                  );

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
            size: 24,
          ),
        ),
        bottomNavigationBar: const BottomAppBar(),
        drawer: const DrawerWidget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<JobSheetBloc, JobSheetState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 18, right: 18, top: 12, bottom: 12),
                    decoration: const BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --------------------------- ROW 1 : SEARCH BAR ---------------------------
                        Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: hintTextColor, width: 0),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              if (value.length > 2) {
                                context.read<JobSheetBloc>().add(
                                      FetchInvoiceList(
                                        searchKeyword: _searchController.text,
                                        fromDate: appliedFromDate,
                                        toDate: appliedToDate,
                                        paymentStatus: _mapToApiPaymentStatus(
                                            _selectedPaymentStatus),
                                        status: JobSheetStatus.loading,
                                      ),
                                    );
                              } else if (value.isEmpty) {
                                context.read<JobSheetBloc>().add(
                                      FetchInvoiceList(
                                        searchKeyword: "",
                                        fromDate: appliedFromDate,
                                        toDate: appliedToDate,
                                        paymentStatus: _mapToApiPaymentStatus(
                                            _selectedPaymentStatus),
                                        status: JobSheetStatus.loading,
                                      ),
                                    );
                              }
                            },
                            style: const TextStyle(color: whiteColor),
                            decoration: InputDecoration(
                              isCollapsed: true, //
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                              hintText: "Search by customer name..",
                              hintStyle: TextStyle(
                                color: whiteColor.withOpacity(0.5),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              fillColor: blackColor,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset(
                                  "assets/icons/search.png",
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            // FILTER BUTTON
                            PopupMenuButton<String>(
                              icon: Container(
                                height: 42,
                                width: 42,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isFilterApplied
                                      ? successColor
                                      : blackColor,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: hintTextColor,
                                    width: 0,
                                  ),
                                ),
                                child: Image.asset(
                                  "assets/icons/filter.png",
                                  color: whiteColor.withOpacity(0.7),
                                ),
                              ),
                              itemBuilder: (BuildContext context) {
                                return filterBy.map((String option) {
                                  return PopupMenuItem(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList();
                              },
                              onSelected: (String value) {
                                setState(() {
                                  isFilterApplied = true;
                                });
                                performFilterOperation(filterOption: value);
                              },
                              offset: const Offset(0, 60),
                              color: whiteColor,
                            ),

                            const SizedBox(width: 12),

                            // PAYMENT STATUS
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedPaymentStatus,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  filled: true,
                                  fillColor: blackColor,
                                ),
                                dropdownColor: blackColor,
                                hint: const Text(
                                  "Payment Status",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: 12),
                                ),
                                iconEnabledColor: whiteColor,
                                items: paymentStatusList.map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(color: whiteColor),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedPaymentStatus = newValue;
                                  });

                                  context.read<JobSheetBloc>().add(
                                        FetchInvoiceList(
                                          searchKeyword: _searchController.text,
                                          fromDate: appliedFromDate,
                                          toDate: appliedToDate,
                                          status: JobSheetStatus.loading,
                                          paymentStatus:
                                              _mapToApiPaymentStatus(newValue),
                                        ),
                                      );
                                },
                              ),
                            ),

                            const SizedBox(width: 8),

                            // REFRESH BUTTON
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedPaymentStatus = null;
                                  _searchController.clear();
                                  isFilterApplied = false;
                                });
                                _fetchInitialInvoice();
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                margin: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  color: blackColor,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: hintTextColor, width: 0),
                                ),
                                child: Icon(
                                  Icons.refresh,
                                  color: whiteColor.withOpacity(0.7),
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),

// --------------------------- ROW 3 : GST FILTER TABS ---------------------------

                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: _TabPill(
                                label: "All",
                                selected: state.selectedGstFilter == null,
                                onTap: () {
                                  context.read<JobSheetBloc>().add(
                                        FetchInvoiceList(
                                          searchKeyword: _searchController.text,
                                          fromDate: appliedFromDate,
                                          toDate: appliedToDate,
                                          status: JobSheetStatus.loading,
                                          gstFilter: null,
                                          paymentStatus: _mapToApiPaymentStatus(
                                              _selectedPaymentStatus),
                                        ),
                                      );
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _TabPill(
                                label: "GST",
                                selected: state.selectedGstFilter == "1",
                                onTap: () {
                                  context.read<JobSheetBloc>().add(
                                        FetchInvoiceList(
                                          searchKeyword: _searchController.text,
                                          fromDate: appliedFromDate,
                                          toDate: appliedToDate,
                                          status: JobSheetStatus.loading,
                                          gstFilter: "1",
                                          paymentStatus: _mapToApiPaymentStatus(
                                              _selectedPaymentStatus),
                                        ),
                                      );
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _TabPill(
                                label: "Non-GST",
                                selected: state.selectedGstFilter == "0",
                                onTap: () {
                                  context.read<JobSheetBloc>().add(
                                        FetchInvoiceList(
                                          searchKeyword: _searchController.text,
                                          fromDate: appliedFromDate,
                                          toDate: appliedToDate,
                                          status: JobSheetStatus.loading,
                                          gstFilter: "0",
                                          paymentStatus: _mapToApiPaymentStatus(
                                              _selectedPaymentStatus),
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: BlocConsumer<JobSheetBloc, JobSheetState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == JobSheetStatus.initial ||
                      state.status == JobSheetStatus.loading) {
                    return const Padding(
                      padding: EdgeInsets.all(8),
                      child: Skeleton(),
                    );
                  }
                  return (state.status == JobSheetStatus.failure ||
                          state.invoiceListing.isEmpty)
                      ? const NoDataFoundWidget()
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return (index >= state.invoiceListing.length)
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: primaryColor, strokeWidth: 2),
                                    ),
                                  )
                                : InvoiceListRow(
                                    invoiceList: state.invoiceListing[index],
                                  );
                          },
                          controller: scrollController,
                          itemCount: state.invoiceListing.length);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  performFilterOperation({String filterOption = "Today"}) async {
    FocusScope.of(context).unfocus();
    final getCurrentDate = app_instance.utility.getCurrentDate();
    var formatter = DateFormat('yyyy-MM-dd');
    final searchKeyword = _searchController.text.toString().trim();
    final jobSheetState = context.read<JobSheetBloc>().state;
    switch (filterOption) {
      case "Today":
        final todayDate = DateTime.now();
        final formattedTodayDate = DateFormat('yyyy-MM-dd').format(todayDate);
        appliedFromDate = formattedTodayDate;
        appliedToDate = formattedTodayDate;
        context.read<JobSheetBloc>().add(
              FetchInvoiceList(
                searchKeyword: searchKeyword,
                gstFilter: jobSheetState.selectedGstFilter,
                fromDate: appliedFromDate,
                toDate: appliedToDate,
                paymentStatus: _mapToApiPaymentStatus(_selectedPaymentStatus),
                status: JobSheetStatus.loading,
              ),
            );
        break;

      case "Yesterday":
        final getYesterdaysDate = app_instance.utility.getOldDate(dayCount: 1);
        appliedFromDate = getYesterdaysDate.toString();
        appliedToDate = getYesterdaysDate.toString();
        context.read<JobSheetBloc>().add(
              FetchInvoiceList(
                  searchKeyword: searchKeyword,
                  gstFilter: jobSheetState.selectedGstFilter,
                  fromDate: appliedFromDate,
                  toDate: appliedToDate,
                  paymentStatus: _mapToApiPaymentStatus(_selectedPaymentStatus),
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
        appliedFromDate = formattedStartDate;
        appliedToDate = formattedEndDate;
        context.read<JobSheetBloc>().add(
              FetchInvoiceList(
                searchKeyword: searchKeyword,
                gstFilter: jobSheetState.selectedGstFilter,
                fromDate: appliedFromDate,
                toDate: appliedToDate,
                paymentStatus: _mapToApiPaymentStatus(_selectedPaymentStatus),
                status: JobSheetStatus.loading,
              ),
            );
        break;

      case "This Month":
        final getFirstDate = app_instance.utility.thisMonthFirstDate();
        appliedFromDate = getFirstDate.toString();
        appliedToDate = getCurrentDate.toString();
        context.read<JobSheetBloc>().add(
              FetchInvoiceList(
                searchKeyword: searchKeyword,
                gstFilter: jobSheetState.selectedGstFilter,
                fromDate: appliedFromDate,
                toDate: appliedToDate,
                paymentStatus: _mapToApiPaymentStatus(_selectedPaymentStatus),
                status: JobSheetStatus.loading,
              ),
            );
        break;

      case "Last Month":
        final getFirstDateOfLastMonth =
            app_instance.utility.lastMonthFirstDate();
        final getLastDateOfLastMonth = app_instance.utility.lastMonthLastDate();
        appliedFromDate = getFirstDateOfLastMonth.toString();
        appliedToDate = getLastDateOfLastMonth.toString();
        context.read<JobSheetBloc>().add(
              FetchInvoiceList(
                searchKeyword: searchKeyword,
                gstFilter: jobSheetState.selectedGstFilter,
                fromDate: appliedFromDate,
                toDate: appliedToDate,
                paymentStatus: _mapToApiPaymentStatus(_selectedPaymentStatus),
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
              appliedFromDate = formattedDate;
              appliedToDate = "";
              context.read<JobSheetBloc>().add(
                    FetchInvoiceList(
                      searchKeyword: searchKeyword,
                      gstFilter: jobSheetState.selectedGstFilter,
                      fromDate: appliedFromDate,
                      toDate: appliedToDate,
                      paymentStatus:
                          _mapToApiPaymentStatus(_selectedPaymentStatus),
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
          appliedFromDate = formattedStartDate;
          appliedToDate = formattedEndDate;
          context.read<JobSheetBloc>().add(
                FetchInvoiceList(
                    searchKeyword: searchKeyword,
                    gstFilter: jobSheetState.selectedGstFilter,
                    fromDate: appliedFromDate,
                    toDate: appliedToDate,
                    paymentStatus:
                        _mapToApiPaymentStatus(_selectedPaymentStatus),
                    status: JobSheetStatus.loading),
              );
        }
        break;

      default:
        context.read<JobSheetBloc>().add(
              FetchInvoiceList(
                  searchKeyword: searchKeyword,
                  gstFilter: jobSheetState.selectedGstFilter,
                  fromDate: getCurrentDate.toString(),
                  toDate: getCurrentDate.toString(),
                  paymentStatus: _mapToApiPaymentStatus(_selectedPaymentStatus),
                  status: JobSheetStatus.loading),
            );
        break;
    }
  }

  String _mapToApiPaymentStatus(String? status) {
    switch (status) {
      case 'Paid':
        return 'Paid';
      case 'Partially Paid':
        return 'Partially Paid';
      case 'Unpaid':
        return 'Unpaid';
      default:
        return '';
    }
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  // final int count;
  final bool selected;
  final VoidCallback onTap;

  const _TabPill({
    required this.label,
    // required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? primaryColor : whiteColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: selected ? whiteColor : Colors.black87,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
