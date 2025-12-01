import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/stock/bloc/stock_bloc/stock_bloc.dart';
import 'package:local_shout_billing/modules/stock/bloc/stock_details_bloc/stock_details_bloc.dart';
import 'package:local_shout_billing/modules/stock/pages/edit_stock.dart';
import 'package:local_shout_billing/modules/stock/pages/manage_stock.dart';

class StockDetailsPage extends StatefulWidget {
  final String? stockId;
  const StockDetailsPage({super.key, this.stockId});
  @override
  State<StockDetailsPage> createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? stockQty;
  assignValues(StockDetailsState state) {
    double? qtyDouble =
        double.tryParse(state.stockDetails!.stockQuantity.toString());
    stockQty = qtyDouble?.toInt() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<StockBloc>().add(
              const FetchStockList(status: StockStatus.loading),
            );
        Navigator.pushNamed(context, '/stock_listing_screen');
        return true;
      },
      child: MainLayout(
        key: _scaffoldKey,
        showDefaultBottom: false,
        title: const Text(
          "Stock Details",
          style: TextStyle(
              fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
        ),
        showFloatingActionButton: false,
        showCurvedAppBar: true,
        showLeading: true,
        leading: IconButton(
          onPressed: () async {
            context.read<StockBloc>().add(
                  const FetchStockList(status: StockStatus.loading),
                );
            Navigator.pushNamed(context, '/stock_listing_screen');
          },
          icon: const Icon(backarrow, color: whiteColor),
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.only(left: 7, right: 7),
          child: BlocConsumer<StockDetailsBloc, StockDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.stockDetailsStatus == StockDetailsStatus.success) {
                assignValues(state);
              }

              if (state.stockDetailsStatus ==
                      StockDetailsStatus.detailsLoading ||
                  state.stockDetailsStatus == StockDetailsStatus.initial) {
                return const CenterLoader();
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: whiteColor,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide(
                              color: lightGreyColor.withOpacity(0.8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        state.stockDetails!.sparePartName ??
                                            "N/A",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: blackColorDark,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: blueColor),
                                          onPressed: () {
                                            context
                                                .read<StockDetailsBloc>()
                                                .add(
                                                  GetStockDetails(
                                                    id: state.stockDetails!.id
                                                        .toString(),
                                                  ),
                                                );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const EditStockPage(),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: redColor),
                                          onPressed: () {
                                            deleteStockRecord(context, state);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Manufactured By - ${state.stockDetails!.manufactured ?? '-'}",
                                  style: const TextStyle(color: hintTextColor),
                                ),
                                const SizedBox(height: 5),
                                const Divider(
                                  color: hintTextColor,
                                  thickness: 1,
                                ),
                                const SizedBox(height: 5),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    int columns = 2;
                                    if (constraints.maxWidth >= 1000) {
                                      columns = 4;
                                    } else if (constraints.maxWidth >= 600) {
                                      columns = 3;
                                    }

                                    double spacing = 12;
                                    final double itemWidth =
                                        (constraints.maxWidth -
                                                spacing * (columns - 1)) /
                                            columns;

                                    final items = <Widget>[
                                      _detailTile("Spare Part Category",
                                          state.stockDetails?.sparePartCat),
                                      _detailTile("Spare Part Code",
                                          state.stockDetails?.sparePartCode),
                                      _detailTile(
                                        "Purchase Price",
                                        state.stockDetails?.purchasePrice !=
                                                null
                                            ? (state.stockDetails!
                                                            .purchasePrice! %
                                                        1 ==
                                                    0
                                                ? state.stockDetails!
                                                    .purchasePrice!
                                                    .toInt()
                                                    .toString()
                                                : state
                                                    .stockDetails!.purchasePrice
                                                    .toString())
                                            : null,
                                      ),
                                      _detailTile(
                                        "Sales Price",
                                        state.stockDetails?.salesPrice != null
                                            ? (state.stockDetails!.salesPrice! %
                                                        1 ==
                                                    0
                                                ? state
                                                    .stockDetails!.salesPrice!
                                                    .toInt()
                                                    .toString()
                                                : state.stockDetails!.salesPrice
                                                    .toString())
                                            : null,
                                      ),
                                      _detailTile("Tax",
                                          state.stockDetails?.tax?.toString()),
                                      _detailTile("Unit Type",
                                          state.stockDetails?.unitType),
                                      _detailTile(
                                        "Stock Quantity",
                                        state.stockDetails?.stockQuantity !=
                                                null
                                            ? (state.stockDetails!
                                                            .stockQuantity! %
                                                        1 ==
                                                    0
                                                ? state.stockDetails!
                                                    .stockQuantity!
                                                    .toInt()
                                                    .toString()
                                                : state
                                                    .stockDetails!.stockQuantity
                                                    .toString())
                                            : null,
                                      ),
                                      _detailTile("HSN Code",
                                          state.stockDetails?.hsnCode),
                                    ];

                                    return Wrap(
                                      spacing: spacing,
                                      runSpacing: 10,
                                      children: items
                                          .map(
                                            (w) => SizedBox(
                                                width: itemWidth, child: w),
                                          )
                                          .toList(),
                                    );
                                  },
                                ),

                                const SizedBox(height: 12),

                                // Storage location
                                _detailRow(
                                  "Storage Location",
                                  state.stockDetails!.storageLocation ?? "-",
                                ),
                                const SizedBox(height: 8),

                                // Description
                                _detailRow("Description",
                                    state.stockDetails!.description ?? "-"),

                                // Tags
                                const Text(
                                  "Tags",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: hintTextColor,
                                      fontSize: 12),
                                ),
                                Wrap(
                                  spacing: 2,
                                  runSpacing: 2,
                                  children: state.stockDetails!.tag!.map((tag) {
                                    return Chip(
                                      label: Text(
                                        tag,
                                        style: const TextStyle(
                                          color: blackColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      backgroundColor:
                                          backgroundColor.withOpacity(0.8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: -2),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        ),

                        // Timeline header
                        Card(
                            color: whiteColor,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: BorderSide(
                                color: lightGreyColor.withOpacity(0.8),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(11),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          'Timeline',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          // Open dialog to adjust stock
                                          await showDialog(
                                            context: context,
                                            builder: (_) => AdjustStockDialog(
                                              stockId: state.stockDetails!.id
                                                  .toString(),
                                              stockQuantity: stockQty,
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          foregroundColor: blackColor,
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: const Text(
                                          'Manage Stocks',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  // Timeline list
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        state.stockDetails!.timelines!.length,
                                    itemBuilder: (context, index) {
                                      final timeline =
                                          state.stockDetails!.timelines![index];
                                      final bool isAdd =
                                          timeline.stockStatus.toLowerCase() ==
                                              "add";

                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: isAdd
                                              ? Colors.green.shade50
                                              : Colors.red.shade50,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "RO${timeline.productId} • ${timeline.stockStatus} Stock",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "Remark :- ${timeline.remark ?? ''}",
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  timeline.createdAt,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      isAdd
                                                          ? Icons.arrow_upward
                                                          : Icons
                                                              .arrow_downward,
                                                      color: isAdd
                                                          ? Colors.green
                                                          : Colors.red,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      "${timeline.productQty} UNT",
                                                      style: TextStyle(
                                                        color: isAdd
                                                            ? Colors.green
                                                            : Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _detailTile(String title, String? value) {
    final val =
        (value == null || value.isEmpty || value == "0.0" || value == "0")
            ? "-"
            : value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: hintTextColor,
              fontSize: 12),
        ),
        const SizedBox(height: 2),
        Text(
          val,
          style: const TextStyle(
              fontSize: 13, color: blackColorDark, fontWeight: FontWeight.w900),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ],
    );
  }

  Widget _detailRow(
    String title,
    String? value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: hintTextColor,
              fontSize: 12),
        ),
        Text(
          value ?? "-",
          style: const TextStyle(
            fontSize: 13,
            color: blackColorDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> deleteStockRecord(BuildContext context, state) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          title: const Text(
            "Are you sure you want to delete?",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: blackColorDark),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                context.read<StockBloc>().add(
                      DeleteStockRecord(
                        id: state.stockDetails!.id.toString(),
                      ),
                    );
                CenterLoader.show(context);
                await Future.delayed(
                  const Duration(seconds: 3),
                );
                setState(() {
                  context.read<StockBloc>().add(
                        const FetchStockList(status: StockStatus.loading),
                      );
                });
                Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_LONG,
                    msg: "Stock deleted succesfully",
                    backgroundColor: successDarkColor);
                CenterLoader.hide();
                setState(() {
                  Navigator.pushNamed(context, '/stock_listing_screen');
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  backgroundColor: primaryColor,
                  foregroundColor: blackColor),
              child: const Text(
                "Delete",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
                backgroundColor: whiteColor,
                side: const BorderSide(color: primaryColor, width: 1),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: blackColorDark),
              ),
            ),
          ],
        );
      },
    );
  }
}
