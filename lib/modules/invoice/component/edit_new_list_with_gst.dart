import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';

class EditSparePartWithGstDialog extends StatefulWidget {
  final String productName;
  final String rate;
  final String qty;
  final String unit;
  final String productId;
  final String gst;
  final bool showQuantity;
  final int flag;
  final String hsnCode;
  final int index;
  final Function(int index, String productId, bool showQuantity, int flag)
      onUpdate;

  const EditSparePartWithGstDialog({
    super.key,
    required this.productName,
    required this.rate,
    required this.qty,
    required this.unit,
    required this.productId,
    required this.gst,
    required this.showQuantity,
    required this.flag,
    required this.hsnCode,
    required this.index,
    required this.onUpdate,
  });

  @override
  State<EditSparePartWithGstDialog> createState() =>
      _EditSparePartWithGstDialogState();
}

class _EditSparePartWithGstDialogState
    extends State<EditSparePartWithGstDialog> {
  late TextEditingController productNameController;
  late TextEditingController rateController;
  late TextEditingController qtyController;
  late TextEditingController hsnCodeController;
  late String unitController;
  late String gstController;
  late bool isHideButtonSelected;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController(text: widget.productName);
    rateController = TextEditingController(text: widget.rate);
    qtyController = TextEditingController(text: widget.qty);
    unitController = widget.unit;
    gstController = widget.gst;
    hsnCodeController = TextEditingController(text: widget.hsnCode);
    isHideButtonSelected = widget.showQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: whiteColor,
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Spare part",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: blackColor),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Spare part name
            const Text("Spare Part Name:",
                style: TextStyle(fontSize: 14, color: blackColor)),
            const SizedBox(height: 5),
            TextFormField(
              controller: productNameController,
              style: const TextStyle(color: blackColor, fontSize: 14),
              decoration: _inputDecoration("Enter Spare Part Name"),
            ),

            const SizedBox(height: 10),
            // Quantity + Unit Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Quantity:",
                          style: TextStyle(color: blackColor, fontSize: 14)),
                      const SizedBox(height: 5),
                      !isHideButtonSelected
                          ? TextFormField(
                              controller: qtyController,
                              style: const TextStyle(
                                  color: blackColor, fontSize: 14),
                              keyboardType: TextInputType.number,
                              inputFormatters: [NoLeadingSpaceFormatter()],
                              decoration: _inputDecoration(""),
                            )
                          : Row(
                              children: [
                                Checkbox(
                                  value: isHideButtonSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      isHideButtonSelected = value ?? false;
                                      if (isHideButtonSelected) {
                                        qtyController.text = "1";
                                      }
                                    });
                                  },
                                ),
                                const Text(
                                  "Hide",
                                  style: TextStyle(
                                      fontSize: 14, color: blackColor),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Unit
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Unit:",
                        style: TextStyle(color: blackColor, fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField(
                        isExpanded: true,
                        value: unitController,
                        decoration: _inputDecoration("Unit"),
                        items: unitList
                            .map(
                              (u) => DropdownMenuItem(
                                value: u,
                                child: Text(
                                  u,
                                  style: const TextStyle(
                                      fontSize: 14, color: blackColor),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => unitController = val!),
                      ),
                    ],
                  ),
                )
              ],
            ),

            // Hide checkbox (when not selected already)
            if (!isHideButtonSelected)
              Row(
                children: [
                  Checkbox(
                    value: isHideButtonSelected,
                    onChanged: (val) {
                      setState(() {
                        isHideButtonSelected = val ?? false;
                        if (isHideButtonSelected) qtyController.text = "1";
                      });
                    },
                  ),
                  const Text("Hide",
                      style: TextStyle(fontSize: 14, color: blackColor)),
                ],
              ),

            const SizedBox(height: 10),
            // Rate
            const Text("Rate:",
                style: TextStyle(color: blackColor, fontSize: 14)),
            const SizedBox(height: 5),
            TextFormField(
              controller: rateController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                NoLeadingSpaceFormatter(),
                LengthLimitingTextInputFormatter(7)
              ],
              style: const TextStyle(color: blackColor, fontSize: 14),
              decoration: _inputDecoration(""),
            ),

            const SizedBox(height: 10),
            // GST
            const Text("GST:",
                style: TextStyle(color: blackColor, fontSize: 14)),
            const SizedBox(height: 5),
            DropdownButtonFormField(
              value: gstController,
              isExpanded: true,
              decoration: _inputDecoration("None"),
              items: gstList
                  .map((g) => DropdownMenuItem(
                        value: g,
                        child: Text(g,
                            style: const TextStyle(
                                fontSize: 14, color: blackColor)),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => gstController = val!),
            ),
            const SizedBox(height: 10),
            const Text("HSN Code:",
                style: TextStyle(color: blackColor, fontSize: 14)),
            const SizedBox(height: 5),
            TextFormField(
              controller: hsnCodeController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                NoLeadingSpaceFormatter(),
                LengthLimitingTextInputFormatter(7)
              ],
              style: const TextStyle(color: blackColor, fontSize: 14),
              decoration: _inputDecoration(""),
            ),
            const SizedBox(height: 20),
            // Update button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  widget.onUpdate(widget.index, widget.productId,
                      isHideButtonSelected, widget.flag);
                  Navigator.pop(context);
                },
                child: const Text("Update",
                    style: TextStyle(fontSize: 15, color: blackColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
          color: hintTextColor, fontFamily: 'Mulish', fontSize: 13),
      filled: true,
      fillColor: lightGreyColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
