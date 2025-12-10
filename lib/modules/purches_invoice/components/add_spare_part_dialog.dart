import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';
import 'package:local_shout_billing/models/product_model.dart';
import 'package:local_shout_billing/modules/purches_invoice/components/create_stock_dailog.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

class PurchesAddSparePartDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSparePartAdded;
  final String? gstBill;
  final String? igstBill;
  const PurchesAddSparePartDialog({
    super.key,
    required this.onSparePartAdded,
    required this.gstBill,
    required this.igstBill,
  });

  @override
  State<PurchesAddSparePartDialog> createState() =>
      _PurchesAddSparePartDialogState();
}

class _PurchesAddSparePartDialogState extends State<PurchesAddSparePartDialog> {
  // Category dialog not used in this simplified flow
  late TextEditingController _sparePartController;
  late TextEditingController _rateController;
  bool isQuantityHidden = false;
  late TextEditingController _qtyController;
  late TextEditingController hsnController;
  int? selectedCategoryId;
  String _unit = "PCS";
  String _gst = "None";
  String? productId;
  int? selectCategoryId;
  String? selectedCategoryName;
  Timer? _debounce;
  bool _showAddButton = false;
  String? _errorText;
  bool _productConfirmed = false;
  String? _confirmedProductId;
  List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    _sparePartController = TextEditingController(text: '');
    _rateController = TextEditingController(text: "00");
    _qtyController = TextEditingController(text: "1");
    hsnController = TextEditingController(text: '');
    _unit = "PCS";
    _gst = "None";
    _errorText = null;
  }

  @override
  void dispose() {
    _rateController.dispose();
    _qtyController.dispose();
    hsnController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void addSparePart() {
    final newsparePartNameController = _sparePartController.text;
    final newQuantityController = _qtyController.text;
    final newRateController = _rateController.text;
    final newUnitListController = _unit;
    final newGstController = _gst;
    final hsnValue = hsnController.text;

    if ((newUnitListController.isNotEmpty) ||
        (newsparePartNameController.isNotEmpty &&
            newUnitListController.isNotEmpty)) {
      String productID = '';
      if (productId != null && productId!.isNotEmpty) {
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
        'product_name': newsparePartNameController,
        'product_qty': quantity,
        'product_unit': newUnitListController,
        'product_price': rate,
        'hsn_code': hsnValue,
        'product_gst': newGstController,
        'showQuantity': showQuantityValue,
        'flag': flagValue,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Text(
                  "Stock:",
                  style: TextStyle(fontSize: 14, color: blackColor),
                ),
                Icon(
                  Icons.star,
                  color: redColor,
                  size: 8,
                )
              ],
            ),

            _buildSparePartAutocomplete(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildQuantityField()),
                const SizedBox(width: 10),
                Expanded(child: _buildUnitDropdown()),
              ],
            ),
            // Hide Quantity Checkbox (optional)
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
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Rate:',
                style: TextStyle(fontSize: 14, color: blackColor),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _rateController,
              style: const TextStyle(color: blackColor, fontSize: 14),
              keyboardType: TextInputType.number,
              inputFormatters: [
                NoLeadingSpaceFormatter(),
                LengthLimitingTextInputFormatter(7)
              ],
              decoration: _inputDecoration(hint: '00'),
            ),
            const SizedBox(height: 10),
            if (widget.gstBill == "1") ...[
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'HSN Code:',
                  style: TextStyle(fontSize: 14, color: blackColor),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: hsnController,
                style: const TextStyle(color: blackColor, fontSize: 14),
                keyboardType: TextInputType.text,
                decoration: _inputDecoration(hint: 'Enter HSN Code'),
              ),
            ],

            const SizedBox(height: 10),
            if (widget.gstBill == "1") ...[
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'GST:',
                  style: TextStyle(fontSize: 16, color: blackColor),
                ),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField(
                style: const TextStyle(color: blackColor, fontSize: 14),
                menuMaxHeight: 450,
                isExpanded: true,
                value: _gst,
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
                  'None',
                  style: TextStyle(color: hintTextColor, fontSize: 13),
                ),
                items: (widget.gstBill == "1" && widget.igstBill == "1"
                        ? igstList
                        : widget.gstBill == "1" && widget.igstBill == "0"
                            ? gstList
                            : [])
                    .map<DropdownMenuItem<String>>((value) {
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
                  _gst = value!.toString();
                },
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  backgroundColor: primaryColor,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.8, 50),
                ),
                onPressed: () {
                  final typedName = _sparePartController.text.trim();

                  if (typedName.isEmpty) {
                    setState(() => _errorText = "Add product to continue.");
                    return;
                  }

                  final isExisting = _products.any((e) =>
                      (e.sparePartName ?? '').toLowerCase() ==
                      typedName.toLowerCase());

                  if (!(_productConfirmed || isExisting)) {
                    setState(() => _errorText = "Add product to continue.");
                    return;
                  }

                  setState(() => _errorText = null);
                  addSparePart();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 15, color: blackColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSparePartAutocomplete() {
    return BlocBuilder<JobSheetDetailsBloc, JobSheetDetailsState>(
      buildWhen: (prev, curr) => prev.productList != curr.productList,
      builder: (context, state) {
        final products = state.productList ?? [];

        return Autocomplete<ProductModel>(
          optionsBuilder: (TextEditingValue tev) {
            if (tev.text.isEmpty) return const Iterable.empty();

            final query = tev.text.trim().toLowerCase();
            final filtered = products.where(
              (e) => (e.sparePartName ?? '').toLowerCase().contains(query),
            );

            if (filtered.isEmpty) {
              _showAddButton = true;
              return [const ProductModel(sparePartName: "__NO_RESULT__")];
            }

            _showAddButton = false;

            return filtered.map((product) {
              // CONDITION: Only modify when both bills are 1
              if (widget.gstBill == "1" && widget.igstBill == "1") {
                final gst = product.sparePartGst ?? "";

                // GST @6% → IGST @6%
                if (gst.toLowerCase().startsWith("gst @")) {
                  return product.copyWith(
                    sparePartGst: gst.replaceFirst("GST", "IGST"),
                  );
                }
              }

              return product;
            });
          },
          displayStringForOption: (sp) => sp.sparePartName == "__NO_RESULT__"
              ? ""
              : (sp.sparePartName ?? ""),
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            if (_sparePartController != controller) {
              _sparePartController = controller;
            }

            return TextField(
              controller: _sparePartController,
              focusNode: focusNode,
              decoration: _sparePartInputDecoration(
                hint: 'Enter Item Name',
                suffix: _showAddButton
                    ? TextButton(
                        onPressed: () async {
                          await _showCreateSparePartPrompt();
                        },
                        child: const Text('Add'),
                      )
                    : null,
              ),
              style: const TextStyle(fontSize: 14, color: blackColor),
              onChanged: (text) {
                _productConfirmed = false;
                _confirmedProductId = null;

                if (_debounce?.isActive ?? false) _debounce!.cancel();

                if (text.length >= 2) {
                  _debounce = Timer(const Duration(milliseconds: 250), () {
                    context.read<JobSheetDetailsBloc>().add(
                          SearchProduct(searchKeyword: text.trim()),
                        );
                  });
                }
              },
            );
          },
          onSelected: (s) {
            if (s.sparePartName == "__NO_RESULT__") {
              return; //
            }

            _sparePartController.text = s.sparePartName ?? '';
            _unit = s.unitType.toString();
            _gst = s.sparePartGst.toString();
            hsnController.text = s.hsnCode.toString();
            _rateController.text =
                (double.tryParse(s.salesPrice.toString()) ?? 0)
                    .toInt()
                    .toString();

            _productConfirmed = true;
            _confirmedProductId = s.id?.toString();
            productId = _confirmedProductId;

            FocusScope.of(context).unfocus();
            setState(() {
              _showAddButton = false;
              _errorText = null;
            });
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 270,
                    maxHeight: options.isEmpty
                        ? 0
                        : (options.length.clamp(1, 5) * 48).toDouble(),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (_, i) {
                      final ProductModel o = options.elementAt(i);

                      if (o.sparePartName == "__NO_RESULT__") {
                        return const ListTile(
                          dense: true,
                          title: Text(
                            "No result found",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        );
                      }

                      return ListTile(
                        dense: true,
                        title: Text(
                          o.sparePartName ?? '',
                          style:
                              const TextStyle(fontSize: 14, color: blackColor),
                        ),
                        onTap: () => onSelected(o),
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
        const Text(
          'Quantity:',
          style: TextStyle(fontSize: 14, color: blackColor),
        ),
        (isQuantityHidden == false)
            ? TextFormField(
                controller: _qtyController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(),
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
          value: _unit,
          items: unitList
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => _unit = v ?? _unit),
          decoration: _inputDecoration(),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
          color: hintTextColor, fontFamily: 'Mulish', fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      filled: true,
      fillColor: lightGreyColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
    );
  }

  InputDecoration _sparePartInputDecoration({String? hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
          color: hintTextColor, fontFamily: 'Mulish', fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      filled: true,
      fillColor: lightGreyColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      errorText: _errorText,
      errorStyle: const TextStyle(
        color: redColor,
        fontSize: 12,
      ),
      suffixIcon: suffix == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(right: 6),
              child: suffix,
            ),
      suffixIconConstraints: const BoxConstraints(minHeight: 36, minWidth: 48),
    );
  }

  Future<void> _showCreateSparePartPrompt() async {
    final String typed = _sparePartController.text.trim();

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PurchesCreateSparePartPrompt(
        typedName: typed,
      ),
    );

    if (result == null) {
      setState(() {
        _productConfirmed = false;
        _errorText = "Add product to continue.";
      });
    } else {
      setState(() {
        _sparePartController.text = result["spare_part_name"] ?? typed;
        _rateController.text = result["sales_price"] ?? '';
        hsnController.text = result["hsn_code"] ?? '';
        _gst = result["tax"] ?? 'None';
        _productConfirmed = true;
        _showAddButton = false;
        _errorText = null;
      });
    }
  }
}






















































// Widget _buildSparePartAutocomplete() {
//     return BlocBuilder<JobSheetDetailsBloc, JobSheetDetailsState>(
//       builder: (context, state) {
//         _products = state.productList ?? []; // <- cache
//         return Autocomplete<ProductModel>(
//           optionsBuilder: (TextEditingValue tev) {
//             if (tev.text.isEmpty) return const Iterable.empty();
//             return state.productList!.where((e) => e.sparePartName!
//                 .toLowerCase()
//                 .contains(tev.text.trim().toLowerCase()));
//           },
//           displayStringForOption: (sp) => sp.sparePartName ?? '',
//           fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
//             if (_sparePartController.text.isEmpty) {
//               _sparePartController = controller;
//             }
//             return TextField(
//               controller: _sparePartController,
//               focusNode: focusNode,
//               decoration: _sparePartInputDecoration(
//                 hint: 'Enter Item Name',
//                 suffix: _showAddButton
//                     ? TextButton(
//                         onPressed: () async {
//                           await _showCreateSparePartPrompt();
//                         },
//                         child: const Text('Add'),
//                       )
//                     : null,
//               ),
//               style: const TextStyle(fontSize: 14, color: blackColor),
//               onChanged: (text) {
//                 // user edited text → un-confirm
//                 _productConfirmed = false;
//                 _confirmedProductId = null;

//                 // Cancel previous debounce
//                 if (_debounce?.isActive ?? false) _debounce!.cancel();

//                 // Only search if text >= 6
//                 if (text.length >= 6) {
//                   _debounce = Timer(const Duration(milliseconds: 300), () {
//                     context.read<JobSheetDetailsBloc>().add(
//                           SearchProduct(searchKeyword: text),
//                         );
//                   });
//                 }

//                 // Check for exact match in current product list
//                 final hasExact = state.productList!.any((e) =>
//                     (e.sparePartName ?? '').toLowerCase() ==
//                     text.trim().toLowerCase());

//                 // Show Add button only if length >= 3 AND no exact match
//                 setState(() {
//                   _showAddButton = text.trim().length >= 9 && !hasExact;
//                   if (hasExact) _errorText = null;
//                 });
//               },
//             );
//           },
//           onSelected: (s) {
//             _sparePartController.text = s.sparePartName ?? '';
//             _unit = s.unitType.toString();
//             _gst = s.sparePartGst.toString();
//             hsnController.text = s.hsnCode.toString();
//             final double parseDouble =
//                 double.tryParse(s.salesPrice.toString()) ?? 0;
//             _rateController.text = parseDouble.toInt().toString();

//             _productConfirmed = true;
//             _confirmedProductId = s.id?.toString();
//             productId = _confirmedProductId;

//             _sparePartController.selection = TextSelection.fromPosition(
//               TextPosition(offset: _sparePartController.text.length),
//             );
//             FocusScope.of(context).requestFocus(FocusNode());
//             setState(() {
//               _showAddButton = false;
//               _errorText = null;
//             });
//           },
//           optionsViewBuilder: (context, onSelected, options) {
//             return Align(
//               alignment: Alignment.topLeft,
//               child: Material(
//                 elevation: 4,
//                 child: Container(
//                   color: whiteColor,
//                   constraints: BoxConstraints(
//                       maxWidth: 270,
//                       maxHeight: options.isEmpty
//                           ? 0
//                           : (options.length * 50).toDouble()),
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: options.length,
//                     itemBuilder: (_, i) {
//                       final ProductModel o = options.elementAt(i);
//                       return ListTile(
//                         title: Text(
//                           o.sparePartName ?? '',
//                           style:
//                               const TextStyle(fontSize: 14, color: blackColor),
//                         ),
//                         onTap: () => onSelected(o),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }


// Future<void> _openCategoryDialog() async {
  //   final res = await showDialog<Map<String, dynamic>>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) => PurchesStockCategoryPicker(
  //       onSelected: (int id, String name) {
  //         setState(() {
  //           selectedCategoryId = id;
  //           _sparePartController.text = name;
  //         });
  //       },
  //       onCreateRequested: () async {
  //         // Close the first dialog immediately then open create dialog
  //         Navigator.of(context).pop();
  //         await _openCreateCategoryDialog();
  //       },
  //     ),
  //   );
  //   if (res != null) {
  //     setState(() {
  //       selectCategoryId = res['id'] as int?;
  //       selectedCategoryName = (res['name'] ?? '') as String;
  //       _showAddButton = false;
  //     });
  //     FocusScope.of(context).requestFocus(_qtyFocus);
  //   }
  // }

  // Future<void> _openCreateCategoryDialog() async {
  //   final String? createdName = await showDialog<String>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) => BlocProvider(
  //       create: (_) => CategoryNameUpdateBloc(),
  //       child: CreateCategoryDialog(
  //         onCreated: () async {},
  //       ),
  //     ),
  //   );
  //   if (createdName != null) {
  //     await _openCategoryDialog();
  //   }
  // }
