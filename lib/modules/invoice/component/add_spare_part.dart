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

// import your bloc, models, colors, formatters, etc.

class InvoiceAddSparePartDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSparePartAdded;
  final String? gstBill;
  final String? igstBill;

  const InvoiceAddSparePartDialog(
      {super.key,
      required this.onSparePartAdded,
      required this.gstBill,
      required this.igstBill});

  @override
  State<InvoiceAddSparePartDialog> createState() => _AddSparePartDialogState();
}

class _AddSparePartDialogState extends State<InvoiceAddSparePartDialog> {
  late TextEditingController productNameController;
  late TextEditingController sparePartNameController;
  late TextEditingController rateProductController;
  late TextEditingController quantityProductController;
  late TextEditingController hsnCodeController;
  String? rateError;
  String unitProductController = "PCS";
  String gstController = "None";
  bool addNewMode = true;
  bool isQuantityHidden = false;
  String? productId;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController(text: '');
    sparePartNameController = TextEditingController(text: '');
    rateProductController = TextEditingController(text: '00');
    quantityProductController = TextEditingController(text: '1');
    hsnCodeController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void addSparePart() {
    setState(() {
      final newProductName = productNameController.text;
      final newSparePartName = sparePartNameController.text;
      final newQuantity = quantityProductController.text;
      final newRate = rateProductController.text;
      final newUnit = unitProductController;
      final newGst = gstController;
      final newHSNCode = hsnCodeController.text;

      if ((newProductName.isNotEmpty && newUnit.isNotEmpty) ||
          (newSparePartName.isNotEmpty && newUnit.isNotEmpty)) {
        String productID = '';
        if (!addNewMode && productId != null && productId!.isNotEmpty) {
          try {
            productID = int.parse(productId.toString()).toString();
          } catch (e) {
            debugPrint('Error parsing productId: $e');
          }
        }

        double quantity = 1.0;
        double rate = 0.0;
        try {
          quantity = double.parse(newQuantity);
        } catch (_) {}
        try {
          rate = double.parse(newRate);
        } catch (_) {}

        bool showQuantityValue = isQuantityHidden;
        int flagValue = isQuantityHidden ? 0 : 1;

        if (!isQuantityHidden && quantity == 1) {
          showQuantityValue = false;
          flagValue = 1;
        } else {
          quantity = 1;
          showQuantityValue = true;
          flagValue = 0;
        }

        Map<String, dynamic> newSparePart = {
          'product_id': productID.toString(),
          'product_name': addNewMode
              ? newSparePartName.toString()
              : newProductName.toString(),
          'product_qty': quantity.toString(),
          'product_unit': newUnit,
          'product_price': rate.toString(),
          'product_gst': newGst,
          'hsn_code': newHSNCode.toString(),
          'showQuantity': showQuantityValue,
          'flag': flagValue,
          'is_delete': true,
        };
        widget.onSparePartAdded(newSparePart);
      }
    });

    isQuantityHidden = false;
  }

  List<String> get currentGstList {
    if (widget.gstBill == "1" && widget.igstBill == "1") {
      return igstList; // IGST list
    } else if (widget.gstBill == "1" && widget.igstBill == "0") {
      return gstList; // SGST/CGST list
    }
    return []; // default empty
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: whiteColor,
      shape: const RoundedRectangleBorder(),
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Spare Part',
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
                  icon: const Icon(
                    clearIcon,
                    size: 23,
                    color: blackColorDark,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: DropdownButton<String>(
                style: const TextStyle(fontSize: 14, color: blackColor),
                dropdownColor: whiteColor,
                value: addNewMode ? 'Spare Part Name' : 'Stock',
                onChanged: (String? newValue) {
                  setState(() {
                    addNewMode = newValue == 'Spare Part Name';
                    if (addNewMode) {
                      productNameController.clear();
                      rateProductController.text = '00';
                    } else {
                      sparePartNameController.clear();
                      hsnCodeController.clear();
                      quantityProductController.text = '1';
                      unitProductController = "PCS";
                      gstController = "None";
                    }
                  });
                },
                items: <String>['Spare Part Name', 'Stock']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 5),
            if (addNewMode) ...[
              BlocBuilder<JobSheetDetailsBloc, JobSheetDetailsState>(
                builder: (context, state) {
                  return Autocomplete<SparePartModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return [];
                      }
                      return state.sparePartList!.where(
                        (element) =>
                            element.productName!.trim().toLowerCase().contains(
                                  textEditingValue.text.trim().toLowerCase(),
                                ),
                      );
                    },
                    displayStringForOption: (sparePart) =>
                        sparePart.productName!,
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
                          controller: sparePartNameController,
                          focusNode: fieldFocusNode,
                          style:
                              const TextStyle(color: blackColor, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: "Enter Spare Part Name",
                            hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20.0),
                            filled: true,
                            fillColor: lightGreyColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            if (_debounce?.isActive ?? false)
                              _debounce!.cancel();

                            _debounce =
                                Timer(const Duration(milliseconds: 300), () {
                              if (text.length >= 3) {
                                context.read<JobSheetDetailsBloc>().add(
                                      SearchSparePart(searchKeyword: text),
                                    );
                              }
                            });

                            setState(
                              () {
                                sparePartNameController =
                                    fieldTextEditingController;
                              },
                            );
                          },
                        ),
                      );
                    },
                    onSelected: (suggestion) {
                      sparePartNameController.text = suggestion.productName!;
                      productId = suggestion.productId.toString();
                      setState(
                        () {
                          unitProductController =
                              suggestion.productUnit.toString();
                          gstController = suggestion.productGst.toString();
                          hsnCodeController.text =
                              suggestion.hashCode.toString();
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
                      sparePartNameController.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                            offset: sparePartNameController.text.length),
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
                              maxWidth: 290,
                              maxHeight: options.isEmpty
                                  ? 0
                                  : (options.length * 50).toDouble(),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final SparePartModel option =
                                    options.elementAt(index);
                                return ListTile(
                                  title: Text(option.productName!),
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
              )
            ] else
              BlocBuilder<JobSheetDetailsBloc, JobSheetDetailsState>(
                builder: (context, state) {
                  return Autocomplete<ProductModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return [];
                      }
                      return state.productList!.where(
                        (element) => element.sparePartName!
                            .trim()
                            .toLowerCase()
                            .contains(
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
                          style:
                              const TextStyle(color: blackColor, fontSize: 14),
                          focusNode: fieldFocusNode,
                          decoration: InputDecoration(
                            hintText: "Search Spare Part Name",
                            hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 13,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20.0),
                            filled: true,
                            fillColor: lightGreyColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            if (_debounce?.isActive ?? false)
                              _debounce!.cancel();

                            _debounce =
                                Timer(const Duration(milliseconds: 300), () {
                              if (text.length >= 3) {
                                context.read<JobSheetDetailsBloc>().add(
                                      SearchProduct(searchKeyword: text),
                                    );
                              }
                            });

                            setState(() {
                              productNameController =
                                  fieldTextEditingController;
                            });
                          },
                        ),
                      );
                    },
                    onSelected: (suggestion) {
                      productNameController.text = suggestion.sparePartName!;
                      gstController = suggestion.sparePartGst.toString();
                      productId = suggestion.id.toString();
                      hsnCodeController.text = suggestion.hashCode.toString();
                      setState(() {
                        unitProductController = suggestion.unitType.toString();
                      });
                      double parseDouble = double.parse(
                        suggestion.salesPrice.toString(),
                      );
                      int convertToInt = parseDouble.toInt();
                      setState(
                        () {
                          rateProductController.text = convertToInt.toString();
                        },
                      );
                      productNameController.selection =
                          TextSelection.fromPosition(
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
                              maxWidth: 290,
                              maxHeight: options.isEmpty
                                  ? 0
                                  : (options.length * 50).toDouble(),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final ProductModel option =
                                    options.elementAt(index);
                                return ListTile(
                                  title: Text(option.sparePartName!),
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
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Quantity:',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      (isQuantityHidden == false)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextFormField(
                                controller: quantityProductController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    color: blackColor, fontSize: 14),
                                inputFormatters: [NoLeadingSpaceFormatter()],
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                    color: hintTextColor,
                                    fontFamily: 'Mulish',
                                    fontSize: 14,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 20),
                                  hintText: '',
                                  filled: true,
                                  fillColor: lightGreyColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
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
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Unit:',
                            style: TextStyle(fontSize: 14, color: blackColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 18),
                        child: DropdownButtonFormField(
                          style: const TextStyle(fontSize: 14),
                          menuMaxHeight: 450,
                          isExpanded: true,
                          value: unitProductController,
                          dropdownColor: whiteColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: lightGreyColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          hint: const Text(
                            'Unit',
                            style: TextStyle(fontSize: 14),
                          ),
                          items:
                              unitList.map<DropdownMenuItem<String>>((value) {
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
                            unitProductController = value!.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
            const SizedBox(height: 7),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Rate:',
                style: TextStyle(fontSize: 14, color: blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 18),
              child: TextFormField(
                style: const TextStyle(fontSize: 13),
                controller: rateProductController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  NoLeadingSpaceFormatter(),
                  LengthLimitingTextInputFormatter(7)
                ],
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: hintTextColor,
                    fontFamily: 'Mulish',
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.only(left: 15, right: 20),
                  hintText: '00',
                  filled: true,
                  fillColor: lightGreyColor,
                  errorText: rateError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                onChanged: (value) {
                  final parsed = double.tryParse(value);
                  setState(() {
                    if (parsed != null && parsed < 0) {
                      rateError = "Negative values are not allowed";
                    } else {
                      rateError = null;
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 7),
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
                    fillColor: lightGreyColor,
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
              const SizedBox(height: 7),
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
                  controller: hsnCodeController,
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
                    hintText: 'Enter HSN code',
                    filled: true,
                    fillColor: lightGreyColor,
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
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    if (rateError == null) {
                      addSparePart();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 15, color: whiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
