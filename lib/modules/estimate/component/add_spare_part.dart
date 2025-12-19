import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';
import 'package:local_shout_billing/models/product_model.dart';
import 'package:local_shout_billing/models/spare_part_model.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

class AddSparePartsDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSparePartAdded;
  final String? gstBill;
  final String? igstBill;
  const AddSparePartsDialog(
      {super.key,
      required this.onSparePartAdded,
      required this.gstBill,
      required this.igstBill});

  @override
  State<AddSparePartsDialog> createState() => _AddSparePartsDialogState();
}

class _AddSparePartsDialogState extends State<AddSparePartsDialog> {
  // Pass these values via constructor or provide via Provider, if needed
  late TextEditingController productNameController;
  late TextEditingController sparePartNameController;
  late TextEditingController rateProductController;
  late TextEditingController quantityProductController;
  late String unitProductControlller;
  late TextEditingController hsnCodeProductController;
  late String gstController;
  bool addNewMode = true;
  bool isQuantityHidden = false;
  String? productId;
  Timer? _debounce;

  @override
  void initState() {
    productNameController = TextEditingController(text: '');
    sparePartNameController = TextEditingController(text: '');
    rateProductController = TextEditingController(text: '00');
    quantityProductController = TextEditingController(text: '1');
    hsnCodeProductController = TextEditingController(text: '');
    unitProductControlller = "PCS";
    gstController = "None";
    addNewMode = true;
    isQuantityHidden = false;
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  List<String> get currentGstList {
    if (widget.gstBill == "1" && widget.igstBill == "1") {
      return igstList; // IGST list
    } else if (widget.gstBill == "1" && widget.igstBill == "0") {
      return gstList; // SGST/CGST list
    }
    return []; // default empty
  }

  void addSparePart() {
    final newProductNameController = productNameController.text;
    final newsparePartNameController = sparePartNameController.text;
    final newQuantityController = quantityProductController.text;
    final newRateController = rateProductController.text;
    final newUnitListController = unitProductControlller;
    final newGstController = gstController;
    final newHsnProductController = hsnCodeProductController.text;

    if ((newProductNameController.isNotEmpty &&
            newUnitListController.isNotEmpty) ||
        (newsparePartNameController.isNotEmpty &&
            newUnitListController.isNotEmpty)) {
      String productID = '';
      if (!addNewMode && productId != null && productId!.isNotEmpty) {
        try {
          productID = int.parse(productId.toString()).toString();
        } catch (e) {
          print('Error parsing productId: $e');
        }
      }

      double quantity = 1.0;
      double rate = 0.0;
      try {
        quantity = double.parse(newQuantityController);
      } catch (e) {
        print('Error parsing quantity: $e');
      }
      try {
        rate = double.parse(newRateController);
      } catch (e) {
        print('Error parsing rate: $e');
      }

      bool showQuantityValue = isQuantityHidden;
      int flagValue = isQuantityHidden ? 0 : 1;

      if (!isQuantityHidden && quantity == 1) {
        showQuantityValue = false;
        flagValue = 1;
      } else if (isQuantityHidden) {
        quantity = 1;
      }
      Map<String, dynamic> newSparePart = {
        'product_id': productID,
        'product_name':
            addNewMode ? newsparePartNameController : newProductNameController,
        'product_qty': quantity,
        'product_unit': newUnitListController,
        'product_price': rate,
        'product_gst': newGstController,
        'hsn_code': newHsnProductController,
        'showQuantity': showQuantityValue,
        'flag': flagValue,
        'is_delete': true,
      };
      widget.onSparePartAdded(newSparePart);
      // isModified = true;
      Navigator.of(context).pop();
    }
    isQuantityHidden = false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: whiteColor,
      shape: const RoundedRectangleBorder(),
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Item',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: blackColor),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    isQuantityHidden = false;
                  },
                  icon: const Icon(clearIcon),
                )
              ],
            ),

            // Toggle Item Name / Stock
            DropdownButton<String>(
              value: addNewMode ? 'Items' : 'Stock',
              items: ['Items', 'Stock']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() {
                addNewMode = val == 'Items';
              }),
            ),

            // Dynamic Autocomplete
            if (addNewMode)
              _buildSparePartAutocomplete()
            else
              _buildStockAutocomplete(),

            const SizedBox(height: 10),

            // Quantity & Unit
            Row(
              children: [
                Expanded(child: _buildQuantityField()),
                const SizedBox(width: 10),
                Expanded(child: _buildUnitDropdown()),
              ],
            ),

            if (isQuantityHidden == false)
              Row(
                children: [
                  Checkbox(
                    value: isQuantityHidden,
                    onChanged: (value) {
                      setState(() {
                        isQuantityHidden = value!;
                      });
                    },
                  ),
                  const Text(
                    'Hide Quantity',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),

            // Rate field
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Rate:',
                style: TextStyle(fontSize: 14, color: blackColor),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 18),
              child: TextFormField(
                controller: rateProductController,
                style: const TextStyle(color: blackColor, fontSize: 14),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  NoLeadingSpaceFormatter(),
                  LengthLimitingTextInputFormatter(7)
                ],
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: hintTextColor,
                    fontFamily: 'Mulish',
                    fontSize: 13,
                  ),
                  contentPadding: const EdgeInsets.only(left: 15, right: 20),
                  hintText: '00',
                  filled: true,
                  fillColor: textfieldBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            if (widget.gstBill == "1") ...[
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'GST:',
                  style: TextStyle(fontSize: 14, color: blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 18),
                child: DropdownButtonFormField(
                  style: const TextStyle(fontSize: 13),
                  menuMaxHeight: 450,
                  isExpanded: true,
                  value: gstController,
                  dropdownColor: whiteColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textfieldBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  hint: const Text('None'),
                  items: currentGstList.isEmpty
                      ? null
                      : currentGstList.map<DropdownMenuItem<String>>((value) {
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
                    gstController = value!.toString();
                  },
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'HSN Code:',
                  style: TextStyle(fontSize: 14, color: blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 18),
                child: TextFormField(
                  style: const TextStyle(fontSize: 14),
                  controller: hsnCodeProductController,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    NoLeadingSpaceFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: hintTextColor,
                      fontFamily: 'Mulish',
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, right: 20),
                    hintText: 'Enter HSN Code',
                    filled: true,
                    fillColor: textfieldBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Add Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                backgroundColor: primaryColor,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
              ),
              onPressed: () {
                addSparePart();
              },
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 15, color: whiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSparePartAutocomplete() {
    return BlocBuilder<JobSheetDetailsBloc, JobSheetDetailsState>(
      builder: (context, state) {
        return Autocomplete<SparePartModel>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return [];
            }
            return state.sparePartList!.where(
              (element) => element.productName!.trim().toLowerCase().contains(
                    textEditingValue.text.trim().toLowerCase(),
                  ),
            );
          },
          displayStringForOption: (sparePart) => sparePart.productName!,
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            if (sparePartNameController.text.isEmpty) {
              sparePartNameController = fieldTextEditingController;
            }
            return Padding(
              padding: const EdgeInsets.only(right: 17),
              child: TextField(
                style: const TextStyle(
                    fontSize: 14,
                    color: blackColor,
                    fontWeight: FontWeight.normal),
                controller: sparePartNameController,
                focusNode: fieldFocusNode,
                decoration: InputDecoration(
                  hintText: "Enter Item Name",
                  hintStyle: const TextStyle(
                    color: hintTextColor,
                    fontFamily: 'Mulish',
                    fontSize: 13,
                  ),
                  contentPadding: const EdgeInsets.only(left: 15, right: 20.0),
                  filled: true,
                  fillColor: textfieldBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                onChanged: (text) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();

                  _debounce = Timer(const Duration(milliseconds: 300), () {
                    if (text.length >= 3) {
                      context.read<JobSheetDetailsBloc>().add(
                            SearchSparePart(searchKeyword: text),
                          );
                    }
                  });

                  setState(() {
                    sparePartNameController = fieldTextEditingController;
                  });
                },
              ),
            );
          },
          onSelected: (suggestion) {
            sparePartNameController.text = suggestion.productName!;
            productId = suggestion.productId.toString();
            hsnCodeProductController.text = suggestion.hashCode.toString();
            setState(
              () {
                unitProductControlller = suggestion.productUnit.toString();
                gstController = suggestion.productGst.toString();
              },
            );
            double parseDouble = double.parse(
              suggestion.productPrice.toString(),
            );
            int convertToInt = parseDouble.toInt();
            setState(
              () {
                rateProductController.text = convertToInt.toString();
              },
            );
            sparePartNameController.selection = TextSelection.fromPosition(
              TextPosition(offset: sparePartNameController.text.length),
            );

            FocusScope.of(context).requestFocus(
              FocusNode(),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: Container(
                  color: whiteColor,
                  constraints: BoxConstraints(
                    maxWidth: 270,
                    maxHeight:
                        options.isEmpty ? 0 : (options.length * 50).toDouble(),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final SparePartModel option = options.elementAt(index);
                      return ListTile(
                        title: Text(
                          option.productName!,
                          style: const TextStyle(
                              fontSize: 14,
                              color: blackColor,
                              fontWeight: FontWeight.normal),
                        ),
                        onTap: () {
                          onSelected(option);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStockAutocomplete() {
    return BlocBuilder<JobSheetDetailsBloc, JobSheetDetailsState>(
      builder: (context, state) {
        return Autocomplete<ProductModel>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return [];
            }
            return state.productList!.where(
              (element) => element.sparePartName!.trim().toLowerCase().contains(
                    textEditingValue.text.trim().toLowerCase(),
                  ),
            );
          },
          displayStringForOption: (product) => product.sparePartName!,
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            if (productNameController.text.isEmpty) {
              productNameController = fieldTextEditingController;
            }
            return Padding(
              padding: const EdgeInsets.only(right: 17),
              child: TextField(
                  controller: productNameController,
                  focusNode: fieldFocusNode,
                  style: const TextStyle(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: "Search Item Name",
                    hintStyle: const TextStyle(
                      color: hintTextColor,
                      fontFamily: 'Mulish',
                      fontSize: 13,
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 15, right: 20.0),
                    filled: true,
                    fillColor: textfieldBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  onChanged: (text) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();

                    _debounce = Timer(const Duration(milliseconds: 300), () {
                      if (text.length >= 3) {
                        context.read<JobSheetDetailsBloc>().add(
                              SearchProduct(searchKeyword: text),
                            );
                      }
                    });

                    setState(() {
                      productNameController = fieldTextEditingController;
                    });
                  }),
            );
          },
          onSelected: (suggestion) {
            productNameController.text = suggestion.sparePartName!;
            productId = suggestion.id.toString();
            setState(() {
              unitProductControlller = suggestion.unitType.toString();
              gstController = suggestion.sparePartGst.toString();
              hsnCodeProductController.text = suggestion.hashCode.toString();
            });
            double parseDouble = double.parse(suggestion.salesPrice.toString());
            int convertToInt = parseDouble.toInt();
            setState(() {
              rateProductController.text = convertToInt.toString();
            });
            productNameController.selection = TextSelection.fromPosition(
              TextPosition(offset: productNameController.text.length),
            );

            FocusScope.of(context).requestFocus(
              FocusNode(),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: Container(
                  color: whiteColor,
                  constraints: BoxConstraints(
                    maxWidth: 270,
                    maxHeight:
                        options.isEmpty ? 0 : (options.length * 50).toDouble(),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ProductModel option = options.elementAt(index);
                      return ListTile(
                        title: Text(
                          option.sparePartName!,
                          style: const TextStyle(
                              fontSize: 14,
                              color: blackColor,
                              fontWeight: FontWeight.normal),
                        ),
                        onTap: () {
                          onSelected(option);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quantity:',
            style: TextStyle(fontSize: 14, color: blackColor)),
        (isQuantityHidden == false)
            ? TextFormField(
                controller: quantityProductController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: blackColor, fontSize: 14),
                inputFormatters: [NoLeadingSpaceFormatter()],
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: hintTextColor,
                    fontFamily: 'Mulish',
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.only(left: 15, right: 20),
                  hintText: '',
                  filled: true,
                  fillColor: textfieldBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  Checkbox(
                    value: isQuantityHidden,
                    onChanged: (value) {
                      setState(() {
                        isQuantityHidden = value!;
                      });
                    },
                  ),
                  const Text(
                    'Hide Quantity',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildUnitDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Unit:', style: TextStyle(fontSize: 14, color: blackColor)),
        DropdownButtonFormField<String>(
          value: unitProductControlller,
          items: unitList
              .map((val) => DropdownMenuItem(value: val, child: Text(val)))
              .toList(),
          onChanged: (val) => setState(() {
            unitProductControlller = val!;
          }),
          decoration: _inputDecoration(),
        )
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      filled: true,
      fillColor: textfieldBg,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
