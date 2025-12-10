import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/stock/bloc/stock_details_bloc/stock_details_bloc.dart';
import 'package:local_shout_billing/modules/stock/components/category_picker_dialog.dart';
import 'package:local_shout_billing/modules/stock/components/create_category_dialog.dart';
import 'package:local_shout_billing/modules/stock/components/edit_category_dialog.dart';
import 'package:local_shout_billing/modules/stock/bloc/category_bloc/category_list_bloc.dart';
import 'package:local_shout_billing/modules/stock/bloc/update_category_bloc/category_name_update_bloc.dart';

class EditStockPage extends StatefulWidget {
  const EditStockPage({super.key});

  @override
  State<EditStockPage> createState() => _EditStockPageState();
}

class _EditStockPageState extends State<EditStockPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController sparePartNameController = TextEditingController();
  final TextEditingController sparePartCodeController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController salesPriceController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController hsnCodeController = TextEditingController();
  final TextEditingController storageLocationController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // Category selection
  int? selectedCategoryId;
  String? selectedGst;
  String? selectedUnitType;
  // Tags
  List<String> vehicleTags = <String>[];

  @override
  void dispose() {
    sparePartNameController.dispose();
    sparePartCodeController.dispose();
    purchasePriceController.dispose();
    salesPriceController.dispose();
    stockQuantityController.dispose();
    hsnCodeController.dispose();
    storageLocationController.dispose();
    descriptionController.dispose();
    manufacturerController.dispose();
    tagController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  assignValues(StockDetailsState state) {
    setState(() {
      sparePartCodeController.text =
          state.stockDetails!.sparePartCode.toString();
      sparePartNameController.text =
          state.stockDetails!.sparePartName.toString();
      purchasePriceController.text = state.stockDetails!.purchasePrice! % 1 == 0
          ? state.stockDetails!.purchasePrice!.toInt().toString()
          : state.stockDetails!.purchasePrice.toString();

      salesPriceController.text = state.stockDetails!.salesPrice! % 1 == 0
          ? state.stockDetails!.salesPrice!.toInt().toString()
          : state.stockDetails!.salesPrice.toString();

      stockQuantityController.text = state.stockDetails!.stockQuantity! % 1 == 0
          ? state.stockDetails!.stockQuantity!.toInt().toString()
          : state.stockDetails!.stockQuantity.toString();
      hsnCodeController.text = state.stockDetails!.hsnCode.toString();
      storageLocationController.text =
          state.stockDetails!.storageLocation?.toString() ?? '';
      descriptionController.text = state.stockDetails!.description.toString();
      manufacturerController.text = state.stockDetails!.manufactured.toString();
      selectedCategoryId = state.stockDetails!.categoryId;
      categoryController.text = state.stockDetails!.sparePartCat.toString();
      selectedGst = state.stockDetails!.tax.toString();
      selectedUnitType = state.stockDetails!.unitType.toString();
      // Other assignments...
      vehicleTags = state.stockDetails!.tag!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockDetailsBloc, StockDetailsState>(
      listener: (context, state) async {
        if (state.stockDetailsStatus ==
            StockDetailsStatus.stockDetailsUpdateSuccessfully) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Stock updated successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          await Future.delayed(
            const Duration(milliseconds: 300),
          );
          Navigator.pushNamed(context, '/stock_listing_screen');
        } else if (state.stockDetailsStatus ==
            StockDetailsStatus.updatingStockDetails) {
          CenterLoader.show(context);
        }
        if (state.stockDetailsStatus ==
            StockDetailsStatus.stockDetailsUpdateFailed) {
          CenterLoader.show(context);
        }
        //fetch stock details
        if (state.stockDetailsStatus == StockDetailsStatus.success) {
          Fluttertoast.cancel();
          assignValues(state);
        } else if (state.stockDetailsStatus == StockDetailsStatus.failure) {
          CenterLoader.hide();
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              Navigator.pushNamed(context, '/stock_listing_screen');
              return true;
            },
            child: MainLayout(
              title: const Text(
                'Edit Stock',
                style: TextStyle(
                  fontSize: 17,
                  color: whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              drawer: const DrawerWidget(),
              showCurvedAppBar: true,
              showLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: whiteColor),
                onPressed: () {
                  Navigator.pushNamed(context, '/stock_listing_screen');
                },
              ),
              showDefaultBottom: false,
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(color: whiteColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(blackColor),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(lightGreyColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          clearScreen();
                        },
                        child: const Text(
                          "Clear All",
                          style: TextStyle(color: blackColor, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(whiteColor),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(primaryColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: primaryColor),
                            ),
                          ),
                        ),
                        onPressed: () {
                          final bool isValid =
                              _formKey.currentState?.validate() ?? false;
                          // if (!isValid) return;
                          if (isValid == true) {
                            Map<String, dynamic> formData = {
                              "id": state.stockDetails!.id,
                              "spare_part_cat": categoryController.text.trim(),
                              "created_at_date":
                                  state.stockDetails!.createdAtDate,
                              "created_at_time":
                                  state.stockDetails!.createdAtTime,
                              "deleted_at": state.stockDetails!.deletedAt,
                              "category_id": selectedCategoryId,
                              "spare_part_name":
                                  sparePartNameController.text.trim(),
                              "spare_part_code":
                                  sparePartCodeController.text.trim(),
                              "purchase_price":
                                  purchasePriceController.text.trim(),
                              "sales_price": salesPriceController.text.trim(),
                              "tax": selectedGst ?? 'None',
                              "unit_type": selectedUnitType ?? 'PCS',
                              "stock_quantity":
                                  stockQuantityController.text.trim(),
                              "hsn_code": hsnCodeController.text.trim(),
                              "storage_location":
                                  storageLocationController.text.trim(),
                              "location_id": state.stockDetails!.locationId,
                              "description": descriptionController.text.trim(),
                              "manufactured":
                                  manufacturerController.text.trim(),
                              "timelines": jsonEncode(
                                (state.stockDetails!.timelines ?? [])
                                    .map((timeline) => {
                                          'created_at': timeline.createdAt,
                                          'deleted_at': timeline.deletedAt,
                                          'product_id': timeline.productId,
                                          'product_qty': timeline.productQty,
                                          'remark': timeline.remark,
                                          'timeline_id': timeline.timelineId,
                                          'stock_status': timeline.stockStatus,
                                          'updated_at': timeline.updatedAt,
                                        })
                                    .toList(),
                              ),
                              "tag": jsonEncode(
                                vehicleTags
                                    .map((String tagValue) => {"tag": tagValue})
                                    .toList(),
                              ),
                              "updated_at_date": state.stockDetails!.updatedAt,
                            };
                            context.read<StockDetailsBloc>().add(
                                  UpdateEditStock(
                                    id: state.stockDetails!.id.toString(),
                                    formData: formData,
                                  ),
                                );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Update",
                              style: TextStyle(color: blackColor, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: (state.stockDetailsStatus ==
                          StockDetailsStatus.detailsLoading ||
                      state.stockDetailsStatus == StockDetailsStatus.loading)
                  ? const CenterLoader()
                  : Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 8),
                            _Section(
                              title: 'Stocks:',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const _FieldLabel('Item Category :',
                                      required: true),
                                  TextFormField(
                                    controller: categoryController,
                                    readOnly: true,
                                    onTap: _openCategoryDialog,
                                    validator: (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Please select category'
                                            : null,
                                    decoration: _inputDecoration(
                                        'Select Item category'),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('Item Name:',
                                      required: true),
                                  TextFormField(
                                    controller: sparePartNameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: _inputDecoration(
                                        'Enter Item name'),
                                    validator: (value) =>
                                        (value == null || value.trim().isEmpty)
                                            ? 'Item name is required'
                                            : null,
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('Item Code:'),
                                  TextFormField(
                                    controller: sparePartCodeController,
                                    textInputAction: TextInputAction.next,
                                    decoration: _inputDecoration(
                                        'Enter Item code'),
                                  ),
                                ],
                              ),
                            ),
                            _Section(
                              title: 'Price:',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const _FieldLabel('Purchase Price:'),
                                  TextFormField(
                                    controller: purchasePriceController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: _inputDecoration(
                                        'Enter purchase price'),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('Sales Price:'),
                                  TextFormField(
                                    controller: salesPriceController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration:
                                        _inputDecoration('Enter sales price'),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('GST :'),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: DropdownButtonFormField(
                                      style: const TextStyle(
                                          fontSize: 14, color: blackColor),
                                      menuMaxHeight: 450,
                                      isExpanded: true,
                                      value: selectedGst,
                                      dropdownColor: whiteColor,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: lightGreyColor,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                      ),
                                      hint: const Text('None'),
                                      items: gstList.isEmpty
                                          ? null
                                          : gstList
                                              .map<DropdownMenuItem<String>>(
                                              (value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: const TextStyle(
                                                      color: blackColor,
                                                      fontFamily: 'Mulish',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      wordSpacing: 3,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                      onChanged: (value) {
                                        selectedGst = value?.toString();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            _Section(
                              title: 'Item Details:',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const _FieldLabel('Unit Type :'),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: DropdownButtonFormField(
                                      menuMaxHeight: 450,
                                      isExpanded: true,
                                      style: const TextStyle(
                                          color: blackColor, fontSize: 14),
                                      value: selectedUnitType,
                                      dropdownColor: whiteColor,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: lightGreyColor,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                      ),
                                      hint: const Text(
                                        'Unit',
                                        style: TextStyle(
                                            color: hintTextColor, fontSize: 13),
                                      ),
                                      items: unitList
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              color: blackColor,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              wordSpacing: 3,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedUnitType = value?.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('Stock Quantity:'),
                                  TextFormField(
                                    controller: stockQuantityController,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: _inputDecoration(
                                        'Enter stock quantity'),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('HSN Code:'),
                                  TextFormField(
                                    controller: hsnCodeController,
                                    textInputAction: TextInputAction.next,
                                    decoration:
                                        _inputDecoration('Enter HSN code'),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('Storage Location:'),
                                  TextFormField(
                                    controller: storageLocationController,
                                    textInputAction: TextInputAction.next,
                                    decoration: _inputDecoration(
                                        'Enter Storage Location'),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('Description :'),
                                  TextFormField(
                                    controller: descriptionController,
                                    maxLines: 4,
                                    textInputAction: TextInputAction.newline,
                                    decoration: _inputDecoration(
                                        'Enter your text here'),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('Manufactured By:'),
                                  TextFormField(
                                    controller: manufacturerController,
                                    textInputAction: TextInputAction.next,
                                    decoration: _inputDecoration(
                                        'Enter manufactured by'),
                                  ),
                                  const SizedBox(height: 12),
                                  const _FieldLabel('Vehicle Tags:'),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          controller: tagController,
                                          decoration: _inputDecoration(
                                              'Add vehicle tags'),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    successColor),
                                            foregroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    whiteColor),
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                          ),
                                          onPressed: () {
                                            final String value =
                                                tagController.text.trim();
                                            if (value.isEmpty) return;
                                            setState(() {
                                              vehicleTags.add(value);
                                              tagController.clear();
                                            });
                                          },
                                          child: const Text('Add Tag'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (vehicleTags.isNotEmpty) ...<Widget>[
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: vehicleTags
                                          .map(
                                            (tag) => Chip(
                                              label: Text(tag),
                                              onDeleted: () {
                                                setState(
                                                  () => vehicleTags.remove(tag),
                                                );
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: hintTextColor,
        fontFamily: 'Mulish',
        fontSize: 13,
      ),
      contentPadding: const EdgeInsets.only(left: 15, right: 20.0),
      filled: true,
      fillColor: lightGreyColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    );
  }

  Future<void> _openCategoryDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider(
        create: (_) => CategoryListBloc()
          ..add(const FetchCategoryList(status: CategoryListStatus.loading)),
        child: CategoryPickerDialog(
          onSelected: (int id, String name) {
            setState(() {
              selectedCategoryId = id;
              categoryController.text = name;
            });
          },
          onCreateRequested: () async {
            // Close the first dialog immediately then open create dialog
            Navigator.of(context).pop();
            await _openCreateCategoryDialog();
          },
          onEditRequested: (int id) async {
            Navigator.of(context).pop();
            await _openEditCategoryDialog(this.context, id);
          },
        ),
      ),
    );
  }

  Future<void> _openCreateCategoryDialog() async {
    final String? createdName = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) => CategoryNameUpdateBloc(),
        child: CreateCategoryDialog(
          onCreated: () async {},
        ),
      ),
    );
    if (createdName != null) {
      await _openCategoryDialog();
    }
  }

  Future<void> _openEditCategoryDialog(BuildContext ctx, int id) async {
    final String? updatedName = await showDialog<String>(
      context: ctx,
      barrierDismissible: false,
      builder: (_) => BlocProvider(
        create: (_) =>
            CategoryNameUpdateBloc()..add(GetCategoryData(id: id.toString())),
        child: EditCategoryDialog(
          id: id,
          onUpdated: (_) async {},
        ),
      ),
    );
    if (updatedName != null) {
      if (selectedCategoryId == id) {
        setState(() {
          categoryController.text = updatedName;
        });
      }
      await _openCategoryDialog();
    }
  }

  // function for clear text fields
  clearScreen() {
    setState(() {
      selectedCategoryId = null;
      categoryController.text = "";
      sparePartNameController.text = "";
      sparePartCodeController.text = "";
      purchasePriceController.text = "";
      salesPriceController.text = "";
      selectedGst = null;
      selectedUnitType = null;
      stockQuantityController.text = "";
      hsnCodeController.text = "";
      storageLocationController.text = "";
      descriptionController.text = "";
      vehicleTags.clear();
      tagController.text = "";
      manufacturerController.text = "";
    });
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(left: 6, right: 6, bottom: 5),
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 9),
            child,
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool required;

  const _FieldLabel(this.text, {this.required = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 6),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: blackColor),
          ),
          if (required) const Icon(Icons.star, size: 10, color: redColor),
        ],
      ),
    );
  }
}
