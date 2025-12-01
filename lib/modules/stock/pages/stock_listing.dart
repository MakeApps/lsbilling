import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/models/stock_filter_model.dart';
import 'package:local_shout_billing/modules/stock/bloc/stock_bloc/stock_bloc.dart';
import 'package:local_shout_billing/modules/stock/pages/stock_item_row.dart';
import 'package:local_shout_billing/modules/stock/pages/create_stock_page.dart';

class StockListing extends StatefulWidget {
  const StockListing({super.key});

  @override
  State<StockListing> createState() => _StockListingState();
}

class _StockListingState extends State<StockListing> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int _selectedTabIndex = 0;
  bool isFilterApplied = false;

  @override
  void initState() {
    super.initState();
    Fluttertoast.cancel();
    _fetchInitialsStock();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _fetchInitialsStock() {
    context.read<StockBloc>().add(
          const FetchStockList(
            status: StockStatus.loading,
          ),
        );
  }

  void _onScroll() {
    final stockState = context.read<StockBloc>().state;
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !stockState.hasReachedMax! &&
        stockState.lastTimestamp != null &&
        (stockState.stockItems?.products.isNotEmpty ?? false)) {
      context.read<StockBloc>().add(FetchStockList(
            timestamp: stockState.lastTimestamp,
            search: _searchController.text.trim(),
            filter: stockState.filter, // Pass current filter
            storageLocation:
                stockState.storageLocation, // Pass current storage location
            status: StockStatus.success,
          ));
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
            offset: const Offset(-14, 0),
            child: const Text(
              "Stocks",
              style: TextStyle(
                  fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        showDefaultBottom: false,
        drawer: const DrawerWidget(),
        titleSpacing: 0,
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
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //  Wrap the whole Padding in BlocBuilder
                BlocBuilder<StockBloc, StockState>(
                  builder: (context, state) {
                    final int inStock = state.stockItems?.totalInStock ?? 0;
                    final int outOfStock =
                        state.stockItems?.totalOutOfStock ?? 0;
                    final int bestSeller =
                        state.stockItems?.totalMaxSellCount ?? 0;

                    // If you also want dynamic filter options from state
                    final List<String> filterOptions =
                        state.stockItems?.stockLocation ?? [];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 15, top: 10, right: 10),
                        decoration: const BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(25),
                            bottomEnd: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    style: const TextStyle(color: whiteColor),
                                    controller: _searchController,
                                    onChanged: (value) {
                                      context.read<StockBloc>().add(
                                            FilterItems(
                                              state.stockParams!.copyWith(
                                                search: _searchController.text
                                                    .trim(),
                                                filter:
                                                    state.filter ?? "in_stock",
                                              ),
                                            ),
                                          );
                                    },
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: whiteColor.withOpacity(0.7),
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
                                      suffixIcon: IconButton(
                                        icon: Image.asset(
                                          "assets/icons/search.png",
                                          height: 16,
                                          width: 16,
                                          color: whiteColor,
                                        ),
                                        onPressed: () {
                                          context.read<StockBloc>().add(
                                                FilterItems(
                                                  state.stockParams!.copyWith(
                                                    search: _searchController
                                                        .text
                                                        .trim(),
                                                    // Maintain current filter when searching
                                                    filter: state.filter ??
                                                        "in_stock",
                                                  ),
                                                ),
                                              );
                                        },
                                      ),
                                      hintText: 'Search by stock name....',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                PopupMenuButton<String>(
                                  icon: Container(
                                    height: 35,
                                    width: 35,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isFilterApplied
                                          ? successColor
                                          : blackColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: hintTextColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Image.asset(
                                        "assets/icons/filter.png",
                                        height: 24,
                                        width: 24,
                                        color: whiteColor),
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return filterOptions.map((String option) {
                                      return PopupMenuItem<String>(
                                        textStyle: const TextStyle(
                                            backgroundColor: whiteColor),
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (String value) {
                                    setState(() {
                                      isFilterApplied = true;
                                    });
                                    context.read<StockBloc>().add(
                                          FilterItems(
                                            state.stockParams!.copyWith(
                                              storageLocation: value,
                                              // Maintain current filter when changing storage location
                                              filter:
                                                  state.filter ?? "in_stock",
                                            ),
                                          ),
                                        );
                                  },
                                  offset: const Offset(0, 60),
                                  color: whiteColor,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFilterApplied = false;
                                    });
                                    _searchController.clear();
                                    _selectedTabIndex = 0;
                                    context.read<StockBloc>().add(
                                          FilterItems(StockParams.empty()),
                                        );
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
                                    label: 'In Stock',
                                    count: inStock,
                                    selected: _selectedTabIndex == 0,
                                    onTap: () {
                                      setState(() => _selectedTabIndex = 0);
                                      context.read<StockBloc>().add(
                                            FilterItems(
                                              state.stockParams!.copyWith(
                                                filter: "in_stock",
                                                search: _searchController.text
                                                    .trim(),
                                              ),
                                            ),
                                          );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  _TabPill(
                                    label: 'Out of Stock',
                                    count: outOfStock,
                                    selected: _selectedTabIndex == 1,
                                    onTap: () {
                                      setState(() => _selectedTabIndex = 1);
                                      context.read<StockBloc>().add(
                                            FilterItems(
                                              state.stockParams!.copyWith(
                                                search: _searchController.text
                                                    .trim(),
                                                filter: "out_of_stock",
                                              ),
                                            ),
                                          );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  _TabPill(
                                    label: 'Best Seller',
                                    count: bestSeller,
                                    selected: _selectedTabIndex == 2,
                                    onTap: () {
                                      setState(() => _selectedTabIndex = 2);
                                      context.read<StockBloc>().add(
                                            FilterItems(
                                              state.stockParams!.copyWith(
                                                search: _searchController.text
                                                    .trim(),
                                                filter: "max_sell",
                                              ),
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
                  child: BlocConsumer<StockBloc, StockState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.stockStatus == StockStatus.initial ||
                          state.stockStatus == StockStatus.loading ||
                          state.stockStatus == StockStatus.searching) {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: Skeleton(),
                        );
                      }

                      return (state.stockStatus == StockStatus.failure ||
                              state.stockItems!.products.isEmpty)
                          ? const NoDataFoundWidget()
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return (index >=
                                        state.stockItems!.products.length)
                                    ? const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                              color: primaryColor,
                                              strokeWidth: 2),
                                        ),
                                      )
                                    : StockItemRow(
                                        product:
                                            state.stockItems!.products[index],
                                      );
                              },
                              controller: _scrollController,
                              itemCount: state.stockItems!.products.length +
                                  (state.hasReachedMax! ? 0 : 1),
                            );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              right: 16,
              bottom: 20,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                heroTag: 'createStockFab',
                backgroundColor: primaryColor,
                foregroundColor: blackColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateStockPage(),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? primaryColor : whiteColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Container(
              height: 21,
              width: 21,
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
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: selected ? blackColorDark : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
