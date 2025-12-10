import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';
import 'package:local_shout_billing/models/storage_location.dart';
import 'package:local_shout_billing/modules/purches_invoice/bloc/purches_invoice_details_bloc/purches_invoice_details_bloc.dart';
import 'package:local_shout_billing/modules/purches_invoice/components/category_picker_purches_dialog.dart';
import 'package:local_shout_billing/modules/stock/bloc/category_bloc/category_list_bloc.dart';
import 'package:local_shout_billing/modules/stock/bloc/stock_bloc/stock_bloc.dart';
import 'package:local_shout_billing/modules/stock/bloc/update_category_bloc/category_name_update_bloc.dart';
import 'package:local_shout_billing/modules/stock/components/create_category_dialog.dart';

class PurchesCreateSparePartPrompt extends StatefulWidget {
  final String typedName;
  const PurchesCreateSparePartPrompt({
    super.key,
    required this.typedName,
  });

  @override
  State<PurchesCreateSparePartPrompt> createState() =>
      _PurchesCreateSparePartPromptState();
}

class _PurchesCreateSparePartPromptState
    extends State<PurchesCreateSparePartPrompt> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController sparePartNameController = TextEditingController();
  final TextEditingController sparePartCodeController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController salesPriceController = TextEditingController();
  final TextEditingController hsnCodeController = TextEditingController();
  TextEditingController storageLocationController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  Timer? _debounce;
  int? selectedCategoryId;
  String? selectedGst;
  final List<String> vehicleTags = <String>[];

  @override
  void initState() {
    super.initState();
    sparePartNameController.text = widget.typedName;
  }

  @override
  void dispose() {
    sparePartNameController.dispose();
    sparePartCodeController.dispose();
    purchasePriceController.dispose();
    salesPriceController.dispose();
    hsnCodeController.dispose();
    storageLocationController.dispose();
    tagController.dispose();
    categoryController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<StockBloc, StockState>(
      listener: (context, state) {
        if (state.stockStatus == StockStatus.createLoading) {
          CenterLoader.show(context);
        }
        if (state.stockStatus == StockStatus.createSuccess) {
          CenterLoader.hide();
          Fluttertoast.showToast(
            msg: "Stock created successfully",
            backgroundColor: successColor,
            textColor: whiteColor,
          );
          Navigator.of(context).pop({
            "sales_price": salesPriceController.text.trim(),
            "hsn_code": hsnCodeController.text.trim(),
            "spare_part_name": sparePartNameController.text.trim(),
            "tax": selectedGst,
          });
        }
        if (state.stockStatus == StockStatus.createFailure) {
          CenterLoader.hide();
          Fluttertoast.showToast(
            msg: "Failed to create stock",
            backgroundColor: redColor,
            textColor: whiteColor,
          );
        }
      },
      child: Dialog.fullscreen(
        backgroundColor: backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              // ---- Header (AppBar replacement) ----
              Container(
                height: kToolbarHeight,
                decoration: const BoxDecoration(
                  color: blackColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Create Item",
                        style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: whiteColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // ---- Body ----
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Section(
                          title: "Stocks",
                          child: _buildStocksSection(),
                        ),
                        _Section(
                          title: "Price",
                          child: _buildPriceSection(),
                        ),
                        _Section(
                          title: "Item Details",
                          child: _buildDetailsSection(),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  backgroundColor: whiteColor,
                                  side: const BorderSide(
                                      color: primaryColor, width: 1),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: blackColorDark,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(48),
                                  shape: const RoundedRectangleBorder(),
                                  backgroundColor: primaryColor,
                                ),
                                onPressed: _onCreatePressed,
                                child: const Text(
                                  "Create",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---- UI Sections ----
  Widget _buildStocksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel("Item category :", required: true),
        TextFormField(
          controller: categoryController,
          readOnly: true,
          onTap: _openCategoryDialog,
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Please select category'
              : null,
          decoration: _inputDecoration('Select Item category'),
        ),
        const SizedBox(height: 12),
        const _FieldLabel("Item name:", required: true),
        TextFormField(
          controller: sparePartNameController,
          decoration: _inputDecoration('Enter Item name'),
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Item name is required'
              : null,
        ),
        const SizedBox(height: 12),
        const _FieldLabel("Item code:"),
        TextFormField(
          controller: sparePartCodeController,
          decoration: _inputDecoration('Enter Item code'),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel("Purchase price:"),
        TextFormField(
          controller: purchasePriceController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Enter purchase price'),
        ),
        const SizedBox(height: 12),
        const _FieldLabel("Sales price:"),
        TextFormField(
          controller: salesPriceController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Enter sales price'),
        ),
        const SizedBox(height: 12),
        const _FieldLabel("GST:"),
        DropdownButtonFormField(
          value: selectedGst,
          isExpanded: true,
          items: gstList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => setState(() => selectedGst = value.toString()),
          decoration: _inputDecoration('Select GST'),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel("HSN Code:"),
        TextFormField(
          controller: hsnCodeController,
          decoration: _inputDecoration('Enter HSN code'),
        ),
        const SizedBox(height: 12),
        const _FieldLabel("Storage Location:"),
        BlocBuilder<PurchesInvoiceDetailsBloc, PurchesInvoiceDetailsState>(
          builder: (context, state) {
            return Autocomplete<StorageLocationModel>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return [];
                }
                return state.storageListing!.where(
                  (element) =>
                      element.location != null &&
                      element.location!.trim().toLowerCase().contains(
                            textEditingValue.text.trim().toLowerCase(),
                          ),
                );
              },
              displayStringForOption: (location) =>
                  location.location.toString(),
              fieldViewBuilder: (
                BuildContext context,
                TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted,
              ) {
                if (storageLocationController.text.isEmpty) {
                  storageLocationController = fieldTextEditingController;
                }
                return TextField(
                  controller: storageLocationController,
                  focusNode: fieldFocusNode,
                  style: const TextStyle(color: blackColor, fontSize: 14),
                  decoration: _inputDecoration("Enter Storage Location"),
                  onChanged: (text) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(
                      const Duration(milliseconds: 300),
                      () {
                        if (text.length >= 3) {
                          context
                              .read<PurchesInvoiceDetailsBloc>()
                              .add(FetchLocationList(searchKeyword: text));
                        }
                      },
                    );
                    storageLocationController = fieldTextEditingController;
                  },
                );
              },
              onSelected: (suggestion) {
                storageLocationController.text = suggestion.location.toString();
              },
            );
          },
        ),
        const SizedBox(height: 12),
        const _FieldLabel("Vehicle Tags:"),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: tagController,
                decoration: _inputDecoration('Add vehicle tags'),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: successColor,
                ),
                onPressed: () {
                  final String value = tagController.text.trim();
                  if (value.isEmpty) return;
                  setState(() {
                    vehicleTags.add(value);
                    tagController.clear();
                  });
                },
                child: const Text(
                  'Add Tag',
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ),
          ],
        ),
        if (vehicleTags.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: vehicleTags
                .map(
                  (tag) => Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() => vehicleTags.remove(tag));
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }

  // ---- Helper Methods ----
  void _onCreatePressed() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      Map<String, dynamic> formData = {
        "id": "",
        "spare_part_cat": categoryController.text.trim(),
        "category_id": selectedCategoryId,
        "spare_part_name": sparePartNameController.text.trim(),
        "spare_part_code": sparePartCodeController.text.trim(),
        "purchase_price": purchasePriceController.text.trim(),
        "sales_price": salesPriceController.text.trim(),
        "tax": selectedGst ?? 'None',
        "unit_type": 'PCS',
        "stock_quantity": "",
        "hsn_code": hsnCodeController.text.trim(),
        "storage_location": storageLocationController.text.trim(),
        "description": "",
        "manufactured": "",
        "tag": jsonEncode(
          vehicleTags.map((t) => {"tag": t}).toList(),
        ),
      };
      context.read<StockBloc>().add(
            CreateAddNewStock(formData: formData),
          );
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: lightGreyColor,
      hintStyle: const TextStyle(fontSize: 13, color: hintTextColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    );
  }

  Future<void> _openCategoryDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider(
        create: (_) => CategoryListBloc()
          ..add(const FetchCategoryList(status: CategoryListStatus.loading)),
        child: PurchesStockCategoryPicker(
          onSelected: (int id, String name) {
            setState(() {
              selectedCategoryId = id;
              categoryController.text = name;
            });
          },
          onCreateRequested: () async {
            Navigator.of(context).pop();
            await _openCreateCategoryDialog();
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
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool required;

  const _FieldLabel(this.text, {this.required = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: const TextStyle(fontSize: 13, color: blackColor)),
        if (required) const Icon(Icons.star, size: 10, color: Colors.red),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: const RoundedRectangleBorder(),
      elevation: 1,
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
