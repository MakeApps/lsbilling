import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import '../../components/center_loader.dart';
import 'invoice_details_page.dart';
import 'package:local_shout_billing/models/invoice_payment_submodel.dart';

class AddPaymentForm extends StatefulWidget {
  const AddPaymentForm({super.key});

  @override
  State<AddPaymentForm> createState() => _AddPaymentFormState();
}

class _AddPaymentFormState extends State<AddPaymentForm> {
  //payment section
  TextEditingController paymentAccountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController remainingAmountController = TextEditingController();
  TextEditingController referenceNumberController = TextEditingController();
  TextEditingController paymentDateController = TextEditingController();
  String? _selectedPaymentType;
  TextEditingController notesController = TextEditingController();
  bool _showReferenceNumberField = false;
  final _formDailogKey = GlobalKey<FormState>();
  String? recivedError;
  DateTime? _selectedDate;
  List<InvoicePaymentSubModel>? payments;
  bool isTotalAmountPaid = false;
  late String initialRemainingAmount;

  @override
  void initState() {
    super.initState();
    remainingAmountController.text = totalAmountController.text;
    _selectedPaymentType = 'Cash';
    _selectedDate = DateTime.now();
    paymentDateController.text =
        DateFormat('yyyy-MM-dd').format(_selectedDate!);
  }

  @override
  void dispose() {
    paymentAccountController.dispose();
    totalAmountController.dispose();
    remainingAmountController.dispose();
    referenceNumberController.dispose();
    paymentDateController.dispose();
    notesController.dispose();
    super.dispose();
  }

  assignValues(JobSheetDetailsState state) {
    if (mounted) {
      setState(() {
        totalAmountController.text =
            state.paymentModel!.afterDiscountAmount.toString();

        initialRemainingAmount =
            state.paymentModel!.afterPayAmount.toString(); // 200.00

        remainingAmountController.text = initialRemainingAmount;

        payments = state.invoiceModel!.totalInvoicePayment?.reversed.toList();
        _calculateRemainingAmount();
      });
    }
  }

  void _calculateRemainingAmount() {
    double receivedAmount =
        double.tryParse(paymentAccountController.text) ?? 0.0;
    double remainingAmount = double.tryParse(initialRemainingAmount) ?? 0.0;

    if (receivedAmount > remainingAmount) {
      setState(() {
        recivedError = "Amount received should not exceed remaining amount.";
      });
    } else {
      setState(() {
        recivedError = null;
        final newRemaining = remainingAmount - receivedAmount;
        remainingAmountController.text = newRemaining.toStringAsFixed(2);
      });
    }
  }

  Future<void> _selectCustomDatePicker(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          now.hour,
          now.minute,
          now.second,
          now.microsecond,
        );

        paymentDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) {
        if (state.status == JobSheetDetailsStatus.loadingPaymentUpdating) {
          CenterLoader.show(context);
        }
        if (state.status == JobSheetDetailsStatus.paymentUpdated) {
          CenterLoader.hide();
          Fluttertoast.showToast(
              msg: "Payment added successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
          context.read<JobSheetDetailsBloc>().add(
                GetInvoiceByInvoice(
                    id: state.paymentModel!.invoiceId.toString(),
                    status: JobSheetDetailsStatus.updateSuccessfully),
              );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InvoiceDetailsPage(),
            ),
          );
        }
        if (state.status == JobSheetDetailsStatus.paymentError) {
          recivedError = state.errorMessage.toString();
        }
        if (state.status == JobSheetDetailsStatus.paymentSuccess) {
          assignValues(state);
        }
      },
      builder: (context, state) {
        return Dialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formDailogKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add Payment',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: blackColor),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(clearIcon),
                      )
                    ],
                  ),
                  const SizedBox(height: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Amount Received',
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: paymentAccountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13, color: blackColor),
                        textAlign: TextAlign.start,
                        cursorColor: blackColor,
                        decoration: InputDecoration(
                          errorText: recivedError,
                          errorStyle: const TextStyle(fontSize: 11),
                          hintStyle: const TextStyle(
                              color: hintTextColor,
                              fontFamily: 'Mulish',
                              fontSize: 11),
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 20),
                          hintText: '0000',
                          filled: true,
                          fillColor: lightGreyColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              recivedError = null;
                            }

                            // Compare with total amount
                            final enteredAmount = double.tryParse(value) ?? 0.0;
                            final totalAmount =
                                double.tryParse(totalAmountController.text) ??
                                    0.0;

                            // Auto toggle checkbox
                            if (enteredAmount == totalAmount) {
                              isTotalAmountPaid = true;
                            } else {
                              isTotalAmountPaid = false;
                            }

                            _calculateRemainingAmount();
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isTotalAmountPaid,
                        onChanged: (bool? value) {
                          setState(() {
                            isTotalAmountPaid = value!;
                            if (isTotalAmountPaid) {
                              paymentAccountController.text =
                                  initialRemainingAmount;
                              remainingAmountController.text = '0.00';
                              recivedError = null;
                            } else {
                              paymentAccountController.clear();
                              _calculateRemainingAmount();
                            }
                          });
                        },
                      ),
                      const Text(
                        'Pay Total Amount',
                        style: TextStyle(fontSize: 13, color: hintTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Remaining Amount',
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: remainingAmountController,
                              style: const TextStyle(
                                  fontSize: 13, color: blackColor),
                              readOnly: true,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                              cursorColor: blackColor,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    color: hintTextColor,
                                    fontFamily: 'Mulish',
                                    fontSize: 11),
                                contentPadding:
                                    const EdgeInsets.only(left: 15, right: 20),
                                hintText: '0000',
                                filled: true,
                                fillColor: lightGreyColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Received Date',
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: paymentDateController,
                              style: const TextStyle(
                                  fontSize: 13, color: blackColor),
                              readOnly: true,
                              onTap: () => _selectCustomDatePicker(context),
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    color: hintTextColor,
                                    fontFamily: 'Mulish',
                                    fontSize: 11),
                                contentPadding:
                                    const EdgeInsets.only(left: 15, right: 20),
                                hintText: 'dd/mm/yyyy',
                                filled: true,
                                fillColor: lightGreyColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: totalAmountController,
                              style: const TextStyle(
                                  fontSize: 13, color: blackColor),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                              readOnly: true,
                              cursorColor: blackColor,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    color: hintTextColor,
                                    fontFamily: 'Mulish',
                                    fontSize: 11),
                                contentPadding:
                                    const EdgeInsets.only(left: 15, right: 20),
                                hintText: '0000',
                                filled: true,
                                fillColor: lightGreyColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Method',
                              style: TextStyle(fontSize: 14, color: blackColor),
                            ),
                            const SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              value: _selectedPaymentType,
                              isExpanded: true,
                              style: const TextStyle(
                                  fontSize: 13, color: blackColor),
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    color: hintTextColor,
                                    fontFamily: 'Mulish',
                                    fontSize: 11),
                                contentPadding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                hintText: 'Payment Method',
                                filled: true,
                                fillColor: lightGreyColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                              ),
                              items: paymentType.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        color: blackColor, fontSize: 13),
                                  ),
                                );
                              }).toList(),
                              selectedItemBuilder: (BuildContext context) {
                                return paymentType.map((String value) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: blackColor, fontSize: 13),
                                    ),
                                  );
                                }).toList();
                              },
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPaymentType = newValue;
                                  _showReferenceNumberField =
                                      (newValue == 'Cheque' ||
                                          newValue == 'Card' ||
                                          newValue == 'UPI (Phonepe/Gpay)');
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (_showReferenceNumberField)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reference Number',
                          style: TextStyle(fontSize: 14, color: blackColor),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: referenceNumberController,
                          style:
                              const TextStyle(fontSize: 13, color: blackColor),
                          textAlign: TextAlign.start,
                          cursorColor: blackColor,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                                color: hintTextColor,
                                fontFamily: 'Mulish',
                                fontSize: 11),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20),
                            hintText: 'Enter Reference Number',
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 15),
                  const Text(
                    'Notes',
                    style: TextStyle(fontSize: 14, color: blackColor),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: notesController,
                    style: const TextStyle(fontSize: 13, color: blackColor),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    cursorColor: blackColor,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                          color: hintTextColor,
                          fontFamily: 'Mulish',
                          fontSize: 11),
                      contentPadding: const EdgeInsets.only(
                          left: 15, right: 20, top: 10, bottom: 10),
                      hintText: 'Enter Notes',
                      filled: true,
                      fillColor: lightGreyColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ), // 'Close'
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if (_formDailogKey.currentState!.validate() &&
                              recivedError == null &&
                              paymentAccountController.text.isNotEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: whiteColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    title: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: hintTextColor,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Confirm Payment',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    content: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 9, right: 9, bottom: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            'Are you sure you want to add payment?',
                                            style: TextStyle(
                                                color: blackColorDark,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                          const SizedBox(height: 13),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Payment Method: ',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: hintTextColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  _selectedPaymentType ?? 'N/A',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Text(
                                                'Received Date: ',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: hintTextColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                paymentDateController.text,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Text(
                                                'Received Amount: ',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: hintTextColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.currency_rupee,
                                                size: 13,
                                                color: blackColor,
                                              ),
                                              Text(
                                                paymentAccountController
                                                        .text.isNotEmpty
                                                    ? paymentAccountController
                                                        .text
                                                    : '0.00',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: whiteColor, fontSize: 13),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          foregroundColor: whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_formDailogKey.currentState!
                                              .validate()) {
                                            Map<String, dynamic> formData = {
                                              "address": state
                                                  .paymentModel!.address
                                                  .toString(),
                                              "afterDiscountAmount": state
                                                  .paymentModel!
                                                  .afterDiscountAmount
                                                  .toString(),
                                              "after_pay_total_balance":
                                                  totalAmountController.text,
                                              "alternet_number": state
                                                  .paymentModel!.alternetNumber
                                                  .toString(),
                                              "company_name": state
                                                  .paymentModel!.companyName
                                                  .toString(),
                                              "created_at_date": state
                                                  .paymentModel!.createdAtDate
                                                  .toString(),
                                              "created_at_time": state
                                                  .paymentModel!.createdAtTime
                                                  .toString(),
                                              "customer_id": state
                                                  .paymentModel!.customerId
                                                  .toString(),
                                              "deleted_at": state
                                                  .paymentModel!.deletedAt
                                                  .toString(),
                                              "description": notesController
                                                  .text
                                                  .toString(),
                                              "email": state.paymentModel!.email
                                                  .toString(),
                                              "full_name": state
                                                  .paymentModel!.fullName
                                                  .toString(),
                                              "invoice_id": state
                                                  .paymentModel!.invoiceId
                                                  .toString(),
                                              "mobile_number": state
                                                  .paymentModel!.mobileNumber
                                                  .toString(),
                                              "pay_method":
                                                  _selectedPaymentType,
                                              "payable_amount":
                                                  paymentAccountController.text
                                                      .toString(),
                                              "receipt_no": state
                                                  .paymentModel!.receiptNo
                                                  .toString(),
                                              "reference_number":
                                                  referenceNumberController.text
                                                      .toString(),
                                              "total_invoice_payment":
                                                  payments != null
                                                      ? payments!.reversed
                                                          .map((payment) => {
                                                                "afterDiscountAmount":
                                                                    payment
                                                                        .afterDiscountAmount,
                                                                "after_pay_total_balance":
                                                                    payment
                                                                        .afterPayTotalBalance,
                                                                "created_at":
                                                                    payment
                                                                        .createdAt,
                                                                "pay_method":
                                                                    payment
                                                                        .payMethod,
                                                                "payable_amount":
                                                                    payment
                                                                        .payableAmount,
                                                                'payment_id':
                                                                    payment
                                                                        .paymentId,
                                                                'received_amount_date':
                                                                    payment
                                                                        .recivedAmountDate,
                                                                "total_balance":
                                                                    payment
                                                                        .totalBalance,
                                                              })
                                                          .toList()
                                                      : [],
                                              "updated_at": state
                                                  .paymentModel!.updatedAt
                                                  .toString(),
                                              "total_balance":
                                                  remainingAmountController.text
                                                      .toString(),
                                              'received_amount_date':
                                                  _selectedDate?.toString() ??
                                                      DateTime.now().toString(),
                                              // paymentDateController.text
                                            };
                                            context
                                                .read<JobSheetDetailsBloc>()
                                                .add(
                                                  AddUpdatePayment(
                                                      formData: formData),
                                                );
                                          }
                                        },
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(color: whiteColor),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          } else if (paymentAccountController.text.isEmpty) {
                            setState(() {
                              recivedError = "This field is required";
                            });
                          }
                        },
                        child: const Text(
                          'Save Payment',
                          style: TextStyle(color: whiteColor, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
