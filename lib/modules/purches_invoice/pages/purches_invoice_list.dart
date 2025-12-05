import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice/purchase_invoice_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/modules/purches_invoice/pages/create_purches_invoice.dart';
import 'purches_invoice_row.dart';

class PurchesInvoiceListingPage extends StatefulWidget {
  const PurchesInvoiceListingPage({super.key});

  @override
  State<PurchesInvoiceListingPage> createState() =>
      _PurchesInvoiceListingPageState();
}

class _PurchesInvoiceListingPageState extends State<PurchesInvoiceListingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String? selectedFilter;
  final ScrollController _scrollController = ScrollController();
  String? _selectedPaymentStatus;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchPurchaseInvoice();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _fetchPurchaseInvoice() {
    context.read<PurchesInvoiceBloc>().add(
          const FetchPurchesInvoiceList(
            status: PurchesInvoiceStatus.loading,
          ),
        );
  }

  void _onScroll() {
    final purchesInvoiceState = context.read<PurchesInvoiceBloc>().state;
    if (purchesInvoiceState.hasReachedMax == true) return;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !purchesInvoiceState.hasReachedMax!) {
      context.read<PurchesInvoiceBloc>().add(
            FetchPurchesInvoiceList(
              timestamp: purchesInvoiceState.lastTimestamp,
              status: PurchesInvoiceStatus.fetchSuccessfully,
              fromDate: '',
              toDate: '',
              gstBill: purchesInvoiceState.selectedGstFilter,
              searchKeyword: _searchController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/dashboard_page');
        return true;
      },
      child: MainLayout(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text(
              "Purchase Invoices",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Inter',
                  color: whiteColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        showDefaultBottom: false,
        drawer: const DrawerWidget(),
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
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<PurchesInvoiceBloc, PurchesInvoiceState>(
                  builder: (context, state) {
                    int? allCount = state.allPurchaseCount;
                    int? gstCount = state.gstPurchaseInvoiceCount;
                    int? nonGstCount = state.nonGstPurchaseInvoiceCount;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 18, bottom: 15, top: 10, right: 5),
                        decoration: const BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(25),
                            bottomEnd: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    style: const TextStyle(color: whiteColor),
                                    controller: _searchController,
                                    onChanged: (value) {
                                      if (value.length > 2) {
                                        context.read<PurchesInvoiceBloc>().add(
                                              FetchPurchesInvoiceList(
                                                searchKeyword:
                                                    _searchController.text,
                                                fromDate: "",
                                                toDate: "",
                                                status: PurchesInvoiceStatus
                                                    .loading,
                                              ),
                                            );
                                      } else if (value.isEmpty) {
                                        _fetchPurchaseInvoice();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: whiteColor.withOpacity(0.5),
                                        fontFamily: 'Mulish',
                                        fontSize: 13,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          color: hintTextColor,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          color: hintTextColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          color: hintTextColor,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: hintTextColor,
                                          width: 0,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 15.0,
                                      ),
                                      filled: true,
                                      fillColor: blackColor,
                                      suffixIcon: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: primaryColor, // LIGHT SHADE
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        child: Image.asset(
                                          "assets/icons/search.png",
                                          height: 30,
                                          width: 30,
                                          color: whiteColor,
                                        ),
                                      ),
                                      hintText: 'Search by vendor name ',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 15),
                                  child: DropdownButton<String>(
                                    value: _selectedPaymentStatus,
                                    hint: const Text(
                                      "Filter By",
                                      style: TextStyle(
                                          color: whiteColor, fontSize: 11),
                                    ),
                                    dropdownColor: blackColor,
                                    style: const TextStyle(
                                        color: whiteColor, fontSize: 13),
                                    iconEnabledColor: whiteColor,
                                    items: stockFilter.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                              color: whiteColor, fontSize: 13),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          selectedFilter = value;
                                          _selectedPaymentStatus = value;
                                        });
                                        performFilterOperation(
                                            filterOption: value);
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                    selectedTabIndex = 0;
                                    setState(() {
                                      _selectedPaymentStatus = null;
                                      selectedFilter = null;
                                    });
                                    _fetchPurchaseInvoice();
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color: whiteColor.withOpacity(0.7),
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            //  Tab Pills
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _TabPill(
                                    label: "All",
                                    count: allCount,
                                    selected: state.selectedGstFilter == null,
                                    onTap: () {
                                      context.read<PurchesInvoiceBloc>().add(
                                            FetchPurchesInvoiceList(
                                              status:
                                                  PurchesInvoiceStatus.loading,
                                              gstBill: null,
                                              searchKeyword:
                                                  _searchController.text,
                                            ),
                                          );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  _TabPill(
                                    label: "GST",
                                    count: gstCount,
                                    selected: state.selectedGstFilter == "1",
                                    onTap: () {
                                      context.read<PurchesInvoiceBloc>().add(
                                            FetchPurchesInvoiceList(
                                              status:
                                                  PurchesInvoiceStatus.loading,
                                              gstBill: "1", // GST
                                              searchKeyword:
                                                  _searchController.text,
                                            ),
                                          );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  _TabPill(
                                    label: "Non-GST",
                                    count: nonGstCount,
                                    selected: state.selectedGstFilter == "0",
                                    onTap: () {
                                      context.read<PurchesInvoiceBloc>().add(
                                            FetchPurchesInvoiceList(
                                              status:
                                                  PurchesInvoiceStatus.loading,
                                              gstBill: "0", // GST
                                              searchKeyword:
                                                  _searchController.text,
                                            ),
                                          );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: BlocConsumer<PurchesInvoiceBloc, PurchesInvoiceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.purchesStatus == PurchesInvoiceStatus.initial ||
                          state.purchesStatus == PurchesInvoiceStatus.loading) {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: Skeleton(),
                        );
                      }
                      return (state.purchesStatus ==
                                  PurchesInvoiceStatus.failure ||
                              state.purchesModel.isEmpty)
                          ? const NoDataFoundWidget()
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return (index >= state.purchesModel.length)
                                    ? const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                              color: primaryColor,
                                              strokeWidth: 2),
                                        ),
                                      )
                                    : PurchesItemRow(
                                        purchesItemData:
                                            state.purchesModel[index],
                                      );
                              },
                              controller: _scrollController,
                              itemCount: state.purchesModel.length);
                    },
                  ),
                )
              ],
            ),
            Positioned(
              right: 16,
              bottom: 20,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                heroTag: 'createStockFab',
                backgroundColor: primaryColor,
                foregroundColor: whiteColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePurchesInvoicePage(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  performFilterOperation({String filterOption = "Today"}) async {
    FocusScope.of(context).unfocus();
    final getCurrentDate = app_instance.utility.getCurrentDate();
    var formatter = DateFormat('yyyy-MM-dd');
    final purchesInvoiceState = context.read<PurchesInvoiceBloc>().state;
    switch (filterOption) {
      case "Filter By":
        context.read<PurchesInvoiceBloc>().add(
              const FetchPurchesInvoiceList(
                status: PurchesInvoiceStatus.loading,
              ),
            );
        break;

      case "Today":
        final todayDate = DateTime.now();
        final formattedTodayDate = DateFormat('yyyy-MM-dd').format(todayDate);
        context.read<PurchesInvoiceBloc>().add(
              FetchPurchesInvoiceList(
                fromDate: formattedTodayDate,
                toDate: formattedTodayDate,
                gstBill: purchesInvoiceState.selectedGstFilter,
                status: PurchesInvoiceStatus.loading,
              ),
            );
        break;

      case "Yesterday":
        final getYesterdaysDate = app_instance.utility.getOldDate(dayCount: 1);
        context.read<PurchesInvoiceBloc>().add(
              FetchPurchesInvoiceList(
                  fromDate: getYesterdaysDate.toString(),
                  toDate: getYesterdaysDate.toString(),
                  gstBill: purchesInvoiceState.selectedGstFilter,
                  status: PurchesInvoiceStatus.loading),
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
        context.read<PurchesInvoiceBloc>().add(
              FetchPurchesInvoiceList(
                fromDate: formattedStartDate,
                toDate: formattedEndDate,
                gstBill: purchesInvoiceState.selectedGstFilter,
                status: PurchesInvoiceStatus.loading,
              ),
            );
        break;

      case "This Month":
        final getFirstDate = app_instance.utility.thisMonthFirstDate();
        context.read<PurchesInvoiceBloc>().add(
              FetchPurchesInvoiceList(
                fromDate: getFirstDate.toString(),
                toDate: getCurrentDate.toString(),
                gstBill: purchesInvoiceState.selectedGstFilter,
                status: PurchesInvoiceStatus.loading,
              ),
            );
        break;

      case "Last Month":
        final getFirstDateOfLastMonth =
            app_instance.utility.lastMonthFirstDate();
        final getLastDateOfLastMonth = app_instance.utility.lastMonthLastDate();
        context.read<PurchesInvoiceBloc>().add(
              FetchPurchesInvoiceList(
                fromDate: getFirstDateOfLastMonth.toString(),
                toDate: getLastDateOfLastMonth.toString(),
                gstBill: purchesInvoiceState.selectedGstFilter,
                status: PurchesInvoiceStatus.loading,
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
              context.read<PurchesInvoiceBloc>().add(
                    FetchPurchesInvoiceList(
                      fromDate: formattedDate,
                      toDate: "",
                      gstBill: purchesInvoiceState.selectedGstFilter,
                      status: PurchesInvoiceStatus.loading,
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
          context.read<PurchesInvoiceBloc>().add(
                FetchPurchesInvoiceList(
                    fromDate: formattedStartDate,
                    toDate: formattedEndDate,
                    gstBill: purchesInvoiceState.selectedGstFilter,
                    status: PurchesInvoiceStatus.loading),
              );
        }
        break;

      default:
        context.read<PurchesInvoiceBloc>().add(
              FetchPurchesInvoiceList(
                  fromDate: getCurrentDate.toString(),
                  toDate: getCurrentDate.toString(),
                  gstBill: purchesInvoiceState.selectedGstFilter,
                  status: PurchesInvoiceStatus.loading),
            );
        break;
    }
  }
}

class _TabPill extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const _TabPill({
    required this.label,
    required this.count,
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
            Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? whiteColor : blackColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: selected ? blackColor : whiteColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: selected ? whiteColor : blackColorDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
