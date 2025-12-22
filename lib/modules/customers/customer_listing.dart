import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/customers/bloc/customer_bloc/customer_bloc.dart';
import 'package:local_shout_billing/modules/customers/pages/create_customer.dart';
import 'package:local_shout_billing/modules/customers/pages/customer_row.dart';

class CustomerListing extends StatefulWidget {
  const CustomerListing({super.key});

  @override
  State<CustomerListing> createState() => _CustomerListingState();
}

class _CustomerListingState extends State<CustomerListing> {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    final searchState = context.read<CustomerBloc>().state;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !searchState.hasReachedMax!) {
      context.read<CustomerBloc>().add(
            FetchCustomerList(
                status: CustomerStatus.success,
                timestamp: searchState.lastTimestamp,
                searchKeyword: searchController.text,
                direction: 'down'),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // showExitConfirmation(context);
        return true;
      },
      child: MainLayout(
        key: _scaffoldKey,
        title: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text(
              "Customer",
              style: TextStyle(
                  fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
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
        showDefaultBottom: false,
        showFloatingActionButton: true,
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<CustomerBloc, CustomerState>(
                  builder: (context, state) {
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextField(
                                style: const TextStyle(color: whiteColor),
                                controller: searchController,
                                onChanged: (value) {
                                  if (value.length > 2) {
                                    context.read<CustomerBloc>().add(
                                          FetchCustomerList(
                                            searchKeyword:
                                                searchController.text,
                                            status: CustomerStatus.loading,
                                            direction: 'down',
                                          ),
                                        );
                                  } else if (value.isEmpty) {
                                    context.read<CustomerBloc>().add(
                                          const FetchCustomerList(
                                            searchKeyword: "",
                                            status: CustomerStatus.loading,
                                          ),
                                        );
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
                                    padding: const EdgeInsets.only(right: 29),
                                    child: Image.asset(
                                      "assets/icons/search.png",
                                      height: 21,
                                      width: 21,
                                      color: primaryColor,
                                    ),
                                  ),
                                  hintText: 'Search by customer name..',
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.read<CustomerBloc>().add(
                                      const FetchCustomerList(
                                        status: CustomerStatus.success,
                                      ),
                                    );
                                searchController.clear();
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                margin: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  color: blackColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: hintTextColor, width: 0),
                                ),
                                child: Icon(Icons.refresh_rounded,
                                    color: whiteColor.withOpacity(0.8),
                                    size: 22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: BlocConsumer<CustomerBloc, CustomerState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.customerStatus == CustomerStatus.initial ||
                          state.customerStatus == CustomerStatus.loading) {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: Skeleton(),
                        );
                      }
                      return (state.customerStatus == CustomerStatus.failure ||
                              state.customerInfoList.isEmpty)
                          ? const NoDataFoundWidget()
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return (index >= state.customerInfoList.length)
                                    ? const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                              color: primaryColor,
                                              strokeWidth: 2),
                                        ),
                                      )
                                    : CustomerDetailsRow(
                                        customerListing:
                                            state.customerInfoList[index],
                                      );
                              },
                              controller: scrollController,
                              itemCount: state.customerInfoList.length,
                            );
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
                heroTag: 'createcustomerFab',
                backgroundColor: primaryColor,
                foregroundColor: whiteColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateCustomerForm(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
