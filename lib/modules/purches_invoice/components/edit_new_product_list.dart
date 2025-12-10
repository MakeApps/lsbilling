import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';

class EditNewProductDialog extends StatefulWidget {
  final Map<String, dynamic> sparePart;

  const EditNewProductDialog({
    super.key,
    required this.sparePart,
  });

  @override
  State<EditNewProductDialog> createState() => _EditNewProductDialogState();
}

class _EditNewProductDialogState extends State<EditNewProductDialog> {
  late TextEditingController nameController;
  late TextEditingController rateController;
  late TextEditingController qtyController;
  late String unitController = "PCS";
  late String gstController;
  late bool isHideButtonSelected;
  late TextEditingController hsnCodeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.sparePart['product_name'].toString());
    rateController = TextEditingController(
        text: widget.sparePart['product_price'].toString());
    qtyController =
        TextEditingController(text: widget.sparePart['product_qty'].toString());
    hsnCodeController =
        TextEditingController(text: widget.sparePart['hsn_code'].toString());
    gstController = widget.sparePart['product_gst'];
    unitController = widget.sparePart['product_unit'].toString();
    isHideButtonSelected = widget.sparePart['showQuantity'] ?? false;
  }

  @override
  void dispose() {
    nameController.dispose();
    rateController.dispose();
    qtyController.dispose();
    hsnCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(),
      backgroundColor: whiteColor,
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Item',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Stock:",
              style: TextStyle(fontSize: 14, color: blackColor),
            ),
            // Name
            TextFormField(
              controller: nameController,
              style: const TextStyle(color: blackColor, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Enter Stock Name",
                filled: true,
                fillColor: lightGreyColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildQuantityField()),
                const SizedBox(width: 10),
                Expanded(child: _buildUnitDropdown()),
              ],
            ),

            // Hide Quantity
            if (isHideButtonSelected == false)
              Row(
                children: [
                  Checkbox(
                    value: isHideButtonSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isHideButtonSelected = value!;
                        if (isHideButtonSelected) {
                          qtyController.text = "1";
                        }
                      });
                    },
                  ),
                  const Text(
                    "Hide",
                    style: TextStyle(fontSize: 14, color: blackColor),
                  ),
                ],
              ),

            // Rate

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
              controller: rateController,
              style: const TextStyle(color: blackColor, fontSize: 14),
              keyboardType: TextInputType.number,
              inputFormatters: [
                NoLeadingSpaceFormatter(),
                LengthLimitingTextInputFormatter(7)
              ],
              decoration: _inputDecoration(hint: '00'),
            ),
            // GST

            const SizedBox(height: 10),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                onPressed: () {
                  final showQuantity =
                      (!isHideButtonSelected && qtyController.text == "1")
                          ? false
                          : isHideButtonSelected;

                  final flag =
                      (!isHideButtonSelected && qtyController.text == "1")
                          ? 1
                          : (isHideButtonSelected == false ? 1 : 0);

                  final updatedSparePart = {
                    'product_id': widget.sparePart['product_id'],
                    'product_name': nameController.text,
                    'product_qty': double.tryParse(qtyController.text) ?? 1,
                    'product_unit': unitController,
                    'product_price': double.tryParse(rateController.text) ?? 0,
                    'product_gst': gstController,
                    'hsn_code': hsnCodeController,
                    'showQuantity': showQuantity,
                    'flag': flag,
                  };
                  Navigator.pop(context, updatedSparePart);
                },
                child: const Text(
                  "Update",
                  style: TextStyle(fontSize: 15, color: blackColor),
                ),
              ),
            ),
          ],
        ),
      ),
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
        (isHideButtonSelected == false)
            ? TextFormField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: blackColor, fontSize: 14),
                inputFormatters: [NoLeadingSpaceFormatter()],
                textAlign: TextAlign.start,
                cursorColor: blackColor,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: hintTextColor,
                    fontFamily: 'Mulish',
                    fontSize: 13,
                  ),
                  contentPadding: const EdgeInsets.only(left: 15, right: 20),
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
              )
            : Row(
                children: [
                  Checkbox(
                    value: isHideButtonSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isHideButtonSelected = value!;
                        if (isHideButtonSelected) {
                          qtyController.text = "1";
                        }
                      });
                    },
                  ),
                  const Text(
                    "Hide",
                    style: TextStyle(fontSize: 14, color: blackColor),
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
        const Text(
          'Unit:',
          style: TextStyle(fontSize: 14, color: blackColor),
        ),
        DropdownButtonFormField<String>(
          value: unitController,
          items: unitList
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (v) =>
              setState(() => unitController = v ?? unitController),
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
}
