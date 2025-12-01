import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';
import 'package:local_shout_billing/models/labour_model.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

// Pass these values via constructor or provide via Provider, if needed
late TextEditingController labourNameController;
late TextEditingController rateController;
late String gstController;
bool addNewMode = true;
bool isQuantityHidden = false;
String? productId;
bool _namevalidate = false;
final FocusNode nameFocusNode = FocusNode();
Timer? _debounce;

class AddLabourDailog extends StatefulWidget {
  final Function(Map<String, dynamic>) onLabourAdded;
  final String? gstBill;
  const AddLabourDailog(
      {super.key,
      required this.onLabourAdded,
      required this.gstBill,});

  @override
  State<AddLabourDailog> createState() => _AddLabourDailogState();
}

class _AddLabourDailogState extends State<AddLabourDailog> {
  @override
  void initState() {
    labourNameController = TextEditingController(text: '');
    rateController = TextEditingController(text: '00');
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

  void addLabourDetails() {
    final newLabourNameController = labourNameController.text;
    final newRateLabourController = rateController.text;
    final newGstLabourController = gstController;

    if (newLabourNameController.isNotEmpty) {
      Map<String, dynamic> newLabour = {
        'labour_name': newLabourNameController,
        'labour_qty': double.parse('1'.toString()),
        'labour_unit': 'UNT',
        'labour_price': double.parse(newRateLabourController.toString()),
        'labour_gst': newGstLabourController,
        'is_delete': true,
      };
      widget.onLabourAdded(newLabour);
      labourNameController.clear();
      rateController.clear();
      gstController = "None";
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Labour',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: blackColor),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    clearIcon,
                    size: 23,
                    color: blackColorDark,
                  ),
                )
              ],
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Labour name:',
                style: TextStyle(fontSize: 14, color: blackColor),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            BlocBuilder<JobSheetDetailsBloc, JobSheetDetailsState>(
              builder: (context, state) {
                return Autocomplete<LabourModel>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return [];
                    }
                    return state.labourList!.where(
                      (element) =>
                          element.labourName!.trim().toLowerCase().contains(
                                textEditingValue.text.trim().toLowerCase(),
                              ),
                    );
                  },
                  displayStringForOption: (labour) => labour.labourName!,
                  fieldViewBuilder: (
                    BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: TextField(
                        controller: fieldTextEditingController,
                        focusNode:
                            _namevalidate ? nameFocusNode : fieldFocusNode,
                        style: const TextStyle(fontSize: 14, color: blackColor),
                        decoration: InputDecoration(
                          hintText: "Enter labour name",
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
                          if (_debounce?.isActive ?? false) _debounce!.cancel();

                          _debounce =
                              Timer(const Duration(milliseconds: 300), () {
                            if (text.length >= 3) {
                              context.read<JobSheetDetailsBloc>().add(
                                    SearchLabour(searchKeyword: text),
                                  );
                            }
                          });

                          setState(() {
                            labourNameController.text = text;
                          });
                        },
                      ),
                    );
                  },
                  onSelected: (suggestion) {
                    int labourRate = suggestion.labourRate!.toInt();
                    setState(
                      () {
                        labourNameController.clear();
                        gstController = "None";
                        labourNameController.text = suggestion.labourName!;
                        gstController = suggestion.labourGst.toString();
                        rateController.text = labourRate.toString();

                        // Set cursor position to the end of the text
                        labourNameController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset: labourNameController.text.length),
                        );
                        FocusScope.of(context).requestFocus(
                          FocusNode(),
                        );
                      },
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
                              final LabourModel option =
                                  options.elementAt(index);
                              return ListTile(
                                title: Text(option.labourName!),
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
            const SizedBox(height: 10),
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
                controller: rateController,
                keyboardType: TextInputType.number,
                inputFormatters: [NoLeadingSpaceFormatter()],
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: hintTextColor,
                    fontFamily: 'Mulish',
                    fontSize: 13,
                  ),
                  contentPadding: const EdgeInsets.only(left: 15, right: 20),
                  hintText: '0',
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
            const SizedBox(height: 10),
            widget.gstBill == "1"
                ? const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Gst:',
                      style: TextStyle(fontSize: 14, color: blackColor),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 5),
            widget.gstBill == "1"
                ? Padding(
                    padding: const EdgeInsets.only(top: 5, right: 18),
                    child: DropdownButtonFormField(
                      style: const TextStyle(fontSize: 14, color: blackColor),
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
                      items: gstList.isEmpty
                          ? null
                          : gstList.map<DropdownMenuItem<String>>(
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
                              },
                            ).toList(),
                      onChanged: (value) {
                        gstController = value!.toString();
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
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
                    addLabourDetails();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 15, color: blackColor),
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
