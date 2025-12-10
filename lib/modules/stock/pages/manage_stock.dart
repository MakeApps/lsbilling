import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/modules/stock/bloc/stock_details_bloc/stock_details_bloc.dart';

import 'stock_details_page.dart';

class AdjustStockDialog extends StatefulWidget {
  final String? stockId;
  final int? stockQuantity;
  const AdjustStockDialog({super.key, this.stockId, this.stockQuantity});

  @override
  State<AdjustStockDialog> createState() => _AdjustStockDialogState();
}

class _AdjustStockDialogState extends State<AdjustStockDialog> {
  bool isAddStock = true;
  String? errorMessage;
  bool _showError = false;
  final _formKey = GlobalKey<FormState>(); // form key for validation

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockDetailsBloc, StockDetailsState>(
      listener: (context, state) {
        if (state.stockDetailsStatus == StockDetailsStatus.updatingStock) {
          CenterLoader.show(context);
        }
        if (state.stockDetailsStatus == StockDetailsStatus.failure) {
          CenterLoader.hide();
        }
        if (state.stockDetailsStatus ==
            StockDetailsStatus.stockManageSuccessfully) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Stock updated successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          context.read<StockDetailsBloc>().add(
                GetStockDetails(
                  id: widget.stockId.toString(),
                ),
              );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StockDetailsPage(
                stockId: widget.stockId
                    .toString(), // Pass the stockId explicitly if needed
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: whiteColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Adjust Stock",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: hintTextColor.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              elevation: 0,
                              backgroundColor: isAddStock
                                  ? blueColor.withOpacity(0.7)
                                  : whiteColor,
                            ),
                            onPressed: () {
                              setState(() => isAddStock = true);
                            },
                            child: Text(
                              "Add Stock",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: isAddStock ? whiteColor : blackColor),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if ((widget.stockQuantity ?? 0) > 2)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(),
                                elevation: 0,
                                backgroundColor: !isAddStock
                                    ? blueColor.withOpacity(0.7)
                                    : whiteColor,
                              ),
                              onPressed: () {
                                setState(() => isAddStock = false);
                              },
                              child: Text(
                                "Reduce Stock",
                                style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        !isAddStock ? whiteColor : blackColor),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Quantity Field
                    const Text(
                      "Quantity:*",
                      style: TextStyle(color: blackColor, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 18),
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          NoLeadingSpaceFormatter(),
                        ],
                        style: const TextStyle(
                          color: blackColor,
                          fontFamily: 'Mulish',
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter quantity",
                          hintStyle: const TextStyle(
                            color: hintTextColor,
                            fontFamily: 'Mulish',
                            fontSize: 13,
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 20),
                          filled: true,
                          fillColor: textfieldBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                          errorText: _showError
                              ? _validateQuantity(quantityController.text)
                              : null,
                          errorStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        onChanged: (val) {
                          if (_showError) {
                            setState(() => _showError = false);
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Remark Field
                    const Text(
                      "Remark:",
                      style: TextStyle(color: blackColor, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: remarkController,
                      maxLines: 3,
                      style: const TextStyle(
                        color: blackColor,
                        fontFamily: 'Mulish',
                        fontSize: 13,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancel",
                            style:
                                TextStyle(color: blackColorDark, fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            backgroundColor: primaryColor,
                            foregroundColor: blackColor,
                          ),
                          onPressed: () {
                            final error =
                                _validateQuantity(quantityController.text);
                            if (error != null) {
                              setState(() => _showError = true);
                            } else {
                              final int quantity = int.parse(
                                quantityController.text.trim(),
                              );

                              Map<String, dynamic> formData = {
                                "id": "",
                                "stock_status": isAddStock ? "Add" : "Reduce",
                                "product_qty": quantity,
                                "remark": remarkController.text,
                              };
                              context.read<StockDetailsBloc>().add(
                                    UpdateManageStock(
                                      formData: formData,
                                      id: widget.stockId,
                                    ),
                                  );
                            }
                          },
                          child: const Text(
                            "Save Details",
                            style:
                                TextStyle(color: blackColorDark, fontSize: 13),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// custom validator
  String? _validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Quantity is required";
    }
    final q = int.tryParse(value);
    if (q == null || q <= 0) {
      return "Please enter a valid quantity (> 0)";
    }
    if (!isAddStock && q > (widget.stockQuantity ?? 0)) {
      return "Quantity must be less than current stock.";
    }
    return null;
  }
}
