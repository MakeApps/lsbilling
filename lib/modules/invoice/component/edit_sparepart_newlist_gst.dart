import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/colors.dart';

class EditInvoiceNewGstSparePart extends StatefulWidget {
  final int index;
  final String productName;
  final String rate;
  final String qty;
  final String unit;
  final String sparePartProductId;
  final String productGst;
  final String hsnCode;
  final bool showQuantity;
  final int flag;

  final List<String> unitList;
  final List<String> gstList;
  final List<String> igstList;
  final String? gstBill;
  final String? igstBill;

  // Callback to update parent UI
  final Function(
    int index,
    String name,
    String price,
    String qty,
    String unit,
    String gst,
    String hsn,
    String productId,
    bool showQty,
    int flag,
  ) onUpdate;

  const EditInvoiceNewGstSparePart({
    super.key,
    required this.index,
    required this.productName,
    required this.rate,
    required this.qty,
    required this.unit,
    required this.sparePartProductId,
    required this.productGst,
    required this.hsnCode,
    required this.showQuantity,
    required this.flag,
    required this.unitList,
    required this.gstList,
    required this.igstList,
    required this.gstBill,
    required this.igstBill,
    required this.onUpdate,
  });

  @override
  State<EditInvoiceNewGstSparePart> createState() =>
      _EditInvoiceNewGstSparePartState();
}

class _EditInvoiceNewGstSparePartState
    extends State<EditInvoiceNewGstSparePart> {
  late TextEditingController nameController;
  late TextEditingController rateController;
  late TextEditingController quantityProductController;
  late TextEditingController hsnController;

  late String selectedUnit;
  late String selectedGst;

  late bool isHideButtonSelected;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.productName);
    rateController = TextEditingController(text: widget.rate);
    quantityProductController = TextEditingController(text: widget.qty);
    hsnController = TextEditingController(text: widget.hsnCode);

    selectedUnit = widget.unit;
    selectedGst = widget.productGst;

    isHideButtonSelected = widget.showQuantity;
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
                  "Edit Item",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.clear),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text("Item Name:", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            TextField(
              controller: nameController,
              decoration: _inputDecoration("Enter Item Name"),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _qtySection()),
                const SizedBox(width: 10),
                Expanded(child: _unitSection()),
              ],
            ),
            // **Hide Checkbox**
            if (isHideButtonSelected == false)
              Row(
                children: [
                  Checkbox(
                    value: isHideButtonSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isHideButtonSelected = value!;
                        if (isHideButtonSelected) {
                          quantityProductController.text =
                              "1"; // Set quantity to 1 when hiding
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
            const SizedBox(height: 10),
            const Text(
              "Rate:",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration(""),
            ),
            const SizedBox(height: 15),
            const Text(
              "GST:",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField(
              menuMaxHeight: 450,
              style: const TextStyle(color: blackColor, fontSize: 14),
              isExpanded: true,
              value: selectedGst,
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
              items: (widget.gstBill == "1" && widget.igstBill == "1"
                      ? widget.igstList
                      : widget.gstBill == "1" && widget.igstBill == "0"
                          ? widget.gstList
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
                setState(() {
                  selectedGst = value!.toString();
                });
              },
            ),
            const SizedBox(height: 15),
            const Text("HSN Code:", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            TextField(
              controller: hsnController,
              decoration: _inputDecoration("Enter HSN Code"),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  backgroundColor: primaryColor,
                ),
                onPressed: () {
                  widget.onUpdate(
                    widget.index,
                    nameController.text,
                    rateController.text,
                    quantityProductController.text,
                    selectedUnit,
                    selectedGst,
                    hsnController.text,
                    widget.sparePartProductId,
                    isHideButtonSelected,
                    widget.flag,
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  "Update",
                  style: TextStyle(fontSize: 15, color: whiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ----------------------
  //  Helper Widgets
  // ----------------------

  Widget _qtySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Quantity:',
              style: TextStyle(color: blackColor, fontSize: 14),
            ),
          ),
        ),
        (isHideButtonSelected == false)
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextFormField(
                  controller: quantityProductController,
                  style: const TextStyle(color: blackColor, fontSize: 14),
                  keyboardType: TextInputType.number,
                  inputFormatters: [NoLeadingSpaceFormatter()],
                  textAlign: TextAlign.start,
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
                          quantityProductController.text =
                              "1"; // Set quantity to 1 when hiding
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

  Widget _unitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Unit:", style: TextStyle(fontSize: 14)),
        const SizedBox(height: 5),
        DropdownButtonFormField(
          value: selectedUnit,
          items: widget.unitList
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => selectedUnit = v.toString()),
          decoration: _inputDecoration("Unit"),
        )
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintStyle: const TextStyle(
        color: hintTextColor,
        fontFamily: 'Mulish',
        fontSize: 13,
      ),
      contentPadding: const EdgeInsets.only(left: 15, right: 20),
      hintText: hint,
      filled: true,
      fillColor: lightGreyColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    );
  }
}
