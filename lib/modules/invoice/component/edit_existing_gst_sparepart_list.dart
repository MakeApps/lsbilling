import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';

class EditInvoiceExistingGstSparePart extends StatefulWidget {
  final int index;
  final String productName;
  final String rate;
  final String qty;
  final String unit;
  final String? sparePartProductId;
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

  const EditInvoiceExistingGstSparePart({
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
  State<EditInvoiceExistingGstSparePart> createState() =>
      _EditInvoiceExistingSparePartState();
}

class _EditInvoiceExistingSparePartState
    extends State<EditInvoiceExistingGstSparePart> {
  late TextEditingController productNameController;
  late TextEditingController rateController;
  late TextEditingController qtyController;
  late TextEditingController hsnController;

  late String unitController;
  late String gstController;
  late String? productId;

  bool isHideButtonSelected = false;

  @override
  void initState() {
    super.initState();

    productNameController = TextEditingController(text: widget.productName);
    rateController = TextEditingController(text: widget.rate);
    qtyController = TextEditingController(text: widget.qty);

    hsnController = TextEditingController(text: widget.hsnCode);
    unitController = widget.unit;
    gstController = widget.productGst;
    productId = widget.sparePartProductId;

    isHideButtonSelected = widget.showQuantity;
  }

  /// ------------------ UPDATE FUNCTION ------------------ ///

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
            /// TITLE -----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Item',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const SizedBox(height: 10),

            /// Item Name
            const Text("Item Name:", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            TextFormField(
              controller: productNameController,
              decoration: _fieldDecoration("Enter Item Name"),
            ),
            const SizedBox(height: 15),

            /// QUANTITY + UNIT ROW
            Row(
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
                            style: TextStyle(color: blackColor, fontSize: 14),
                          ),
                        ),
                      ),
                      (isHideButtonSelected == false)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: TextFormField(
                                controller: qtyController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    color: blackColor, fontSize: 14),
                                inputFormatters: [NoLeadingSpaceFormatter()],
                                textAlign: TextAlign.start,
                                cursorColor: blackColor,
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                    color: greyColor,
                                    fontFamily: 'Mulish',
                                    fontSize: 13,
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
                                  value: isHideButtonSelected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isHideButtonSelected = value!;
                                      if (isHideButtonSelected) {
                                        qtyController.text =
                                            "1"; // Set quantity to 1 when hiding
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

                const SizedBox(width: 12),

                /// UNIT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Unit:", style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      DropdownButtonFormField(
                        value: unitController,
                        decoration: _fieldDecoration(null),
                        items: unitList.map<DropdownMenuItem<String>>((value) {
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
                        onChanged: (v) {
                          setState(() => unitController = v!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (isHideButtonSelected == false)
              Row(
                children: [
                  Checkbox(
                    value: isHideButtonSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isHideButtonSelected = value!;
                        if (isHideButtonSelected) {
                          qtyController.text =
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

            /// Rate
            const Text("Rate:", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            TextFormField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: _fieldDecoration(""),
            ),
            const SizedBox(height: 15),

            /// GST
            const Text("GST:", style: TextStyle(fontSize: 14)),
            DropdownButtonFormField(
              menuMaxHeight: 450,
              isExpanded: true,
              style: const TextStyle(color: blackColor, fontSize: 14),
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
                setState(() {
                  gstController = value!.toString();
                });
              },
            ),

            const SizedBox(height: 15),

            /// HSN
            const Text("HSN Code:", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            TextFormField(
              controller: hsnController,
              decoration: _fieldDecoration("Enter HSN Code"),
            ),

            const SizedBox(height: 25),

            /// Update button
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
                    productNameController.text,
                    rateController.text,
                    qtyController.text,
                    unitController,
                    gstController,
                    hsnController.text,
                    widget.sparePartProductId.toString(),
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

  InputDecoration _fieldDecoration(String? hint) {
    return InputDecoration(
      hintStyle: const TextStyle(
        color: greyColor,
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
