import 'dart:async';
import 'package:local_shout_billing/components/no_data_found.dart';
import 'package:local_shout_billing/discard_dailog_component/show_exit_app/show_exit_dailog.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import '../../components/Estimate page/estimate_list_row.dart';
import '../../components/skeleton/listing_skeleton.dart';

class EstimateListing extends StatefulWidget {
  const EstimateListing({super.key});

  @override
  State<EstimateListing> createState() => _EstimateListingState();
}

class _EstimateListingState extends State<EstimateListing> {
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
    final jobSheetState = context.read<JobSheetBloc>().state;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !jobSheetState.hasReachedMax!) {
      context.read<JobSheetBloc>().add(
            FetchEstimateList(
                status: JobSheetStatus.success,
                timestamp: jobSheetState.lastTimestamp,
                searchKeyword: searchController.text,
                gstFilter: jobSheetState.selectedGstFilter,
                direction: 'down'),
          );
    }
  }

  void _searchEstimates() {
    final jobSheetState = context.read<JobSheetBloc>().state;
    final keyword = searchController.text;
    context.read<JobSheetBloc>().add(
          FetchEstimateList(
              status: JobSheetStatus.success,
              timestamp: null,
              searchKeyword: keyword,
              direction: 'down',
              gstFilter: jobSheetState.selectedGstFilter),
        );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      _searchEstimates();
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
        key: _scaffoldKey,
        ctx: 1,
        title: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text(
              "Estimates",
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
                              color: Colors.white,
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
                // int? allCount = state.allEstimateCount;
                // int? gstCount = state.gstEstimateCount;
                // int? nonGstCount = state.nonGstEstimateCount;
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextField(
                                style: const TextStyle(color: whiteColor),
                                controller: searchController,
                                onChanged: _onSearchChanged,
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
                                context.read<JobSheetBloc>().add(
                                      const FetchEstimateList(
                                        status: JobSheetStatus.success,
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
                        const SizedBox(height: 18),
                        //  Tab Pills
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: _TabPill(
                                    label: "All",
                                    // count: allCount!,
                                    selected: state.selectedGstFilter == null,
                                    onTap: () {
                                      context.read<JobSheetBloc>().add(
                                            FetchEstimateList(
                                              status: JobSheetStatus.loading,
                                              gstFilter: null,
                                              searchKeyword:
                                                  searchController.text,
                                            ),
                                          );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _TabPill(
                                    label: "GST",
                                    // count: gstCount!,
                                    selected: state.selectedGstFilter == "1",
                                    onTap: () {
                                      context.read<JobSheetBloc>().add(
                                            FetchEstimateList(
                                              status: JobSheetStatus.loading,
                                              gstFilter: "1", // GST
                                              searchKeyword:
                                                  searchController.text,
                                            ),
                                          );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _TabPill(
                                    label: "Non-GST",
                                    // count: nonGstCount!,
                                    selected: state.selectedGstFilter == "0",
                                    onTap: () {
                                      context.read<JobSheetBloc>().add(
                                            FetchEstimateList(
                                              status: JobSheetStatus.loading,
                                              gstFilter: "0", // Non-GST
                                              searchKeyword:
                                                  searchController.text,
                                            ),
                                          );
                                    },
                                  ),
                                )
                              ]),
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
                          state.estimateListing.isEmpty)
                      ? const NoDataFoundWidget()
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return (index >= state.estimateListing.length)
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: primaryColor, strokeWidth: 2),
                                    ),
                                  )
                                : EstimateListRow(
                                    estimateList: state.estimateListing[index],
                                  );
                          },
                          controller: scrollController,
                          itemCount: state.estimateListing.length,
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
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
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: selected ? whiteColor : blackColor,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
