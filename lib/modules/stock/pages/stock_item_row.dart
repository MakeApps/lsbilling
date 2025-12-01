import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/models/stock_list_model.dart';
import 'package:local_shout_billing/modules/stock/bloc/stock_bloc/stock_bloc.dart';
import 'package:local_shout_billing/modules/stock/bloc/stock_details_bloc/stock_details_bloc.dart';
import 'package:local_shout_billing/modules/stock/pages/edit_stock.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'stock_details_page.dart';

class StockItemRow extends StatefulWidget {
  final ProductModel product;

  const StockItemRow({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<StockItemRow> createState() => _StockItemRowState();
}

class _StockItemRowState extends State<StockItemRow> {
   String? roleId;

     @override
  void initState() {
    super.initState();
    _loadRoleId();
  }

  Future<void> _loadRoleId() async {
    final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');
    setState(() {
      roleId = id;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<StockDetailsBloc>().add(
              GetStockDetails(
                id: widget.product.id.toString(),
              ),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StockDetailsPage(
              stockId: widget.product.id.toString(),
            ),
          ),
        );
      },
      child: Card(
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.product.sparePartName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.product.stockQuantity <= 2 &&
                          widget.product.stockQuantity >= 1)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Low Stock Alert!",
                            style: TextStyle(
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
               PopupMenuButton<String>(
                    color: whiteColor,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    itemBuilder: (context) {
                      final items = <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18, color: blackColorDark),
                              SizedBox(width: 8),
                              Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: blackColorDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];

                      if (roleId != null && roleId != '4') {
                        items.add(
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: blackColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return items;
                    },
                    onSelected: (value) {
                      if (value == 'edit') {
                        context.read<StockDetailsBloc>().add(
                              GetStockDetails(
                                id: widget.product.id.toString(),
                              ),
                            );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditStockPage(),
                          ),
                        );
                      } else if (value == 'delete') {
                        deleteStockRecord(
                          context,
                        );
                      }
                    },
                    child: const Icon(
                      verticleDot,
                      color: hintTextColor,
                      size: 30
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Info rows
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(
                            "Spare Part Code:", widget.product.sparePartCode),
                        _infoRow(
                          "Quantity:",
                          "${widget.product.stockQuantity.toInt()} ${widget.product.unitType}",
                        ),
                        _infoRow(
                            "Manufactured By:", widget.product.manufactured),
                      ],
                    ),
                  ),

                  // Right Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow("Category:", widget.product.sparePartCat),
                        _infoRow(
                          "Sales Price:",
                          widget.product.salesPrice % 1 == 0
                              ? widget.product.salesPrice.toInt().toString()
                              : widget.product.salesPrice.toStringAsFixed(2),
                        ),
                        _infoRow("Storage Location:",
                            widget.product.storageLocation),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Tags
              if (widget.product.tags.isNotEmpty) ...[
                const Text(
                  "Tags:",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: hintTextColor),
                ),
                Wrap(
                  spacing: 2,
                  runSpacing: 2,
                  children: widget.product.tags.map((tag) {
                    return Chip(
                      label: Text(
                        tag,
                        style: const TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: backgroundColor.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: -2),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: hintTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteStockRecord(BuildContext context) async {
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
            "Are you sure you want to delete stock?",
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
                        id: widget.product.id.toString(),
                      ),
                    );
                CenterLoader.show(context);
                await Future.delayed(
                  const Duration(seconds: 3),
                );

                context.read<StockBloc>().add(
                      const FetchStockList(status: StockStatus.success),
                    );
                Fluttertoast.showToast(
                    toastLength: Toast.LENGTH_LONG,
                    msg: "Stock deleted succesfully",
                    backgroundColor: successDarkColor);
                CenterLoader.hide();
                Navigator.pushNamed(context, '/stock_listing_screen');
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
