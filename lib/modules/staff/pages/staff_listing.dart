import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:local_shout_billing/modules/staff/bloc/staff_bloc/staff_bloc.dart';

import '../../job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'create_staff_form.dart';
import 'staff_list_row.dart';

class StaffListingScreen extends StatefulWidget {
  const StaffListingScreen({super.key});

  @override
  State<StaffListingScreen> createState() => _StaffListingScreenState();
}

class _StaffListingScreenState extends State<StaffListingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialStaff();
    context.read<ProfileSectionBloc>().add(
          const FetchProfileInfo(),
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _fetchInitialStaff() {
    context.read<StaffBloc>().add(
          const FetchStaffList(
            searchKeyword: "",
            createStaffStatus: CreateStaffStatus.loading,
          ),
        );
  }

  void _onScroll() {
    final jobSheetState = context.read<StaffBloc>().state;

    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !jobSheetState.hasReachedMax!) {
      context.read<StaffBloc>().add(
            FetchStaffList(
              searchKeyword: _searchController.text,
              timestamp: jobSheetState.lastTimestamp,
              createStaffStatus: CreateStaffStatus.success,
              direction: 'down',
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
        title: const Padding(
          padding: EdgeInsets.only(left: 14),
          child: Text(
            "Staff",
            style: TextStyle(
                fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
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
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 18, right: 18, top: 12, bottom: 12),
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
                              style: const TextStyle(
                                  color: whiteColor, fontSize: 14),
                              controller: _searchController,
                              onChanged: (value) {
                                if (value.length > 2) {
                                  context.read<StaffBloc>().add(
                                        FetchStaffList(
                                          searchKeyword: _searchController.text,
                                          createStaffStatus:
                                              CreateStaffStatus.loading,
                                        ),
                                      );
                                } else if (value.isEmpty) {
                                  _fetchInitialStaff();
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
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(15),
                                  child: Image.asset(
                                    "assets/icons/search.png",
                                    height: 30,
                                    width: 30,
                                    color: primaryColor,
                                  ),
                                ),
                                hintText: 'Search by staff name..',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: blackColor,
                              border:
                                  Border.all(color: hintTextColor, width: 0),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _fetchInitialStaff();
                                _searchController.clear();
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: whiteColor.withOpacity(0.8),
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: BlocConsumer<StaffBloc, StaffState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.staffStatus == CreateStaffStatus.initial ||
                            state.staffStatus == CreateStaffStatus.loading) {
                          return const Padding(
                            padding: EdgeInsets.all(8),
                            child: Skeleton(),
                          );
                        }

                        return (state.staffStatus ==
                                    CreateStaffStatus.failure ||
                                state.staffList.isEmpty)
                            ? const NoDataFoundWidget()
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return (index >= state.staffList.length)
                                      ? const Skeleton()
                                      : StaffListRow(
                                          staffList: state.staffList[index],
                                        );
                                },
                                controller: _scrollController,
                                itemCount: state.staffList.length,
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
                  heroTag: 'createStaff',
                  backgroundColor: primaryColor,
                  foregroundColor: whiteColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateStaffScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
