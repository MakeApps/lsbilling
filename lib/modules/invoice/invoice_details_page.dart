import 'dart:async';
import 'dart:convert';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/config/streamsControllers.dart';
import 'package:local_shout_billing/models/customer_model.dart';
import 'package:local_shout_billing/models/invoice_payment_submodel.dart';
import 'package:local_shout_billing/models/product_model.dart';
import 'package:local_shout_billing/models/spare_part_model.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'add_payment_form.dart';
import 'edit_invoice_customer.dart';

class InvoiceDetailsPage extends StatefulWidget {
  const InvoiceDetailsPage({
    super.key,
  });

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  String? productId;
  List<dynamic> sparePartsList = [];
  List<dynamic> sparePartsListNew = [];
  List<dynamic> sparePart = [];
  int updateIndex = 0;
  bool? isGenerate = false;
  bool? showUpdateButton = false;
  bool addNewMode = false;
  String unitProductControlller = "PCS";
  String gstController = "None";
  TextEditingController productNameController = TextEditingController();
  TextEditingController sparePartNameController = TextEditingController();
  TextEditingController quantityProductController =
      TextEditingController(text: '1');
  TextEditingController rateProductController =
      TextEditingController(text: '00');
  TextEditingController hsnCodeProductController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _invoiceDateController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  bool showAllTransactions = false;
  Timer? _debounce;
  StreamSubscription<String>? invoiceUpdateDetailsStream;
  double finalAmountAfterDiscount = 0.0;
  String? gstFlag;
  String? gstBill;
  DateTime _selectedDate = DateTime.now();
  String? invoiceTotalValue;
  double sgst = 0.0;
  double cgst = 0.0;
  double discountAmountPrice = 0.0;
  double subInvoiceTotal = 0.0;
  String? roleId;
  List<InvoicePaymentSubModel>? payments;
  bool isQuantityHidden = false;
  double totalRecived = 0.0;

  @override
  void initState() {
    super.initState();
    listenStreamController();
    discountController.addListener(_onDiscountChanged);
  }

  @override
  void dispose() {
    productNameController.dispose();
    sparePartNameController.dispose();
    rateProductController.dispose();
    quantityProductController.dispose();
    hsnCodeProductController.dispose();
    _fullNameController.dispose();
    _adressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _invoiceDateController.dispose();
    discountController.dispose();
    invoiceUpdateDetailsStream?.cancel();
    _debounce?.cancel();
    super.dispose();
  }

  assignValues(JobSheetDetailsState state) {
    _fullNameController.text = state.invoiceModel!.fullName.toString();
    _adressController.text = state.invoiceModel!.address.toString();
    _emailController.text = state.invoiceModel!.email.toString();
    _phoneNumberController.text = state.invoiceModel!.mobileNumber.toString();
    _invoiceDateController.text = state.invoiceModel!.tempDate.toString();
    sparePartsList = state.invoiceModel!.invoiceProducts!.toList();
    invoiceTotalValue = state.invoiceModel!.invoiceTotal.toString();
    gstFlag = state.invoiceModel!.gstFlag.toString();
    gstBill = state.invoiceModel!.gstBill.toString();
    discountController.text = state.invoiceModel!.discountAmount.toString();
    payments = state.invoiceModel!.totalInvoicePayment?.reversed.toList();
    totalRecived = double.parse(state.invoiceModel!.paidAmount.toString());
  }

  Future<void> _loadRoleId() async {
    final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');
    setState(() {
      roleId = id;
    });
  }

  listenStreamController() {
    invoiceUpdateDetailsStream =
        StreamsBrodcasts.updateInvoiceDetailsStream.stream.listen(
      (id) {
        setState(() {
          sparePartsListNew.clear();
        });
      },
    );
  }

  void _onDiscountChanged() {
    setState(
      () {
        discountController;
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: blackColor,
              onSurface: blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: blackColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _invoiceDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) async {
        if (state.status == JobSheetDetailsStatus.successInvoiceDetails) {
          CenterLoader.hide();
          assignValues(state);
          _loadRoleId();
        }

        if (state.status == JobSheetDetailsStatus.invoicePdfLoading) {
          CenterLoader.show(context);
        }

        if (state.status == JobSheetDetailsStatus.invoicePdfOpened ||
            state.status == JobSheetDetailsStatus.invoicePdfFailed) {
          CenterLoader.hide();
        }

        if (state.status == JobSheetDetailsStatus.invoiceUpdated &&
            state.triggerDownloadAfterGenerate == true) {
          context.read<JobSheetDetailsBloc>().add(
                DownloadInvoicePdf(
                  id: state.currentInvoiceId.toString(),
                ),
              );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.read<JobSheetBloc>().add(
                  const FetchInvoiceList(status: JobSheetStatus.success),
                );
            Navigator.pushReplacementNamed(context, '/invoice_page_listing');

            return true;
          },
          child: MainLayout(
            title: const Text(
              "Edit Invoice",
              style: TextStyle(
                  fontSize: 17, color: whiteColor, fontWeight: FontWeight.w600),
            ),
            drawer: const DrawerWidget(),
            ctx: 2,
            showFloatingActionButton: false,
            showDefaultBottom: false,
            showCurvedAppBar: true,
            showLeading: true,
            leading: IconButton(
              onPressed: () {
                context.read<JobSheetDetailsBloc>().add(
                      ResetLastInvoiceId(),
                    );
                context.read<JobSheetBloc>().add(
                      const FetchInvoiceList(status: JobSheetStatus.success),
                    );
                Navigator.pushNamed(context, '/invoice_page_listing');
              },
              icon: const Icon(
                backarrow,
                color: whiteColor,
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: whiteColor,
              child: SizedBox(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(blackColor),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(primaryColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              (calculateSubtotalGst() > 0 ||
                                  calculateSparePartSubtotal() > 0)) {
                            Map<String, dynamic> formData = {
                              "address": state.invoiceModel!.address.toString(),
                              "afterDiscountAmount": discountAmountPrice == 0.0
                                  ? subInvoiceTotal
                                  : finalAmountAfterDiscount,
                              "discountAmount":
                                  (discountController.text.trim().isEmpty ||
                                          discountController.text.trim() ==
                                              "0.00" ||
                                          discountController.text.trim() == "0")
                                      ? 0
                                      : discountController.text.trim(),
                              "after_pay_total_balance": state
                                  .invoiceModel!.afterPayTotalAmount
                                  .toString(),
                              "payable_amount":
                                  state.invoiceModel!.paidAmount.toString(),
                              "company_id": state.invoiceModel!.companyId,
                              "created_at_date":
                                  state.invoiceModel!.createdAtDate.toString(),
                              "created_at_time":
                                  state.invoiceModel!.createdAtTime.toString(),
                              "customer_id": state.invoiceModel!.customerId,
                              "deleted_at":
                                  state.invoiceModel!.deletedAt.toString(),
                              "email": state.invoiceModel!.email.toString(),
                              "invoiceTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "gst_flag": gstFlag.toString(),
                              "gst_bill": gstBill.toString(),
                              "taxablevalueTotal": gstBill == "1"
                                  ? calculateSparePartSubtotal()
                                  : 0,
                              "cgstTotal": gstBill == "1" ? calculateCgst() : 0,
                              "scgtTotal": gstBill == "1" ? calculateCgst() : 0,
                              "invoice_id": state.invoiceModel!.invoiceId,
                              "invoice_number":
                                  state.invoiceModel!.invoiceNumber.toString(),
                              "full_name":
                                  state.invoiceModel!.fullName.toString(),
                              "invoice_labours": "",
                              "invoice_products": mergeSparePart().isEmpty
                                  ? ''
                                  : jsonEncode(mergeSparePart()),
                              "labourTotal": 0,
                              "last_invoice_id":
                                  state.invoiceModel!.lastinvoiceId,
                              "total_invoice_payment": payments != null
                                  ? payments!.reversed
                                      .map((payment) => {
                                            "afterDiscountAmount":
                                                payment.afterDiscountAmount,
                                            "after_pay_total_balance":
                                                payment.afterPayTotalBalance,
                                            "created_at": payment.createdAt,
                                            "pay_method": payment.payMethod,
                                            "payable_amount":
                                                payment.payableAmount,
                                            "total_balance": state.invoiceModel!
                                                .afterPayTotalAmount
                                                .toString(),
                                          })
                                      .toList()
                                  : [],
                              "mobile_number":
                                  state.invoiceModel!.mobileNumber.toString(),
                              "productTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "temp_date": _invoiceDateController.text,
                              "updated_at":
                                  state.invoiceModel!.updatedAt.toString(),
                            };
                            context.read<JobSheetDetailsBloc>().add(
                                  GenerateInvoiceEvent(
                                      id: state.invoiceModel!.invoiceId
                                          .toString(),
                                      formData: formData),
                                );

                            Fluttertoast.showToast(
                                toastLength: Toast.LENGTH_SHORT,
                                msg: "Invoice updated successfully",
                                backgroundColor: successDarkColor);

                            isGenerate = true;
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                  "Please add at least one spare part and labour",
                                  style: TextStyle(
                                      color: blackColorDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                actions: [
                                  Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: blackColorDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                actionsAlignment: MainAxisAlignment.center,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                    ),
                    if (isGenerate == true ||
                        (calculateSubtotalGst() > 0 ||
                            calculateSparePartSubtotal() > 0))
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(blackColor),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(primaryColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              (calculateSubtotalGst() > 0 ||
                                  calculateSparePartSubtotal() > 0)) {
                            Map<String, dynamic> formData = {
                              "address": state.invoiceModel!.address.toString(),
                              "afterDiscountAmount": discountAmountPrice == 0.0
                                  ? subInvoiceTotal
                                  : finalAmountAfterDiscount,
                              "discountAmount":
                                  (discountController.text.trim().isEmpty ||
                                          discountController.text.trim() ==
                                              "0.00" ||
                                          discountController.text.trim() == "0")
                                      ? 0
                                      : discountController.text.trim(),
                              "after_pay_total_balance": state
                                  .invoiceModel!.afterPayTotalAmount
                                  .toString(),
                              "payable_amount":
                                  state.invoiceModel!.paidAmount.toString(),
                              "company_id": state.invoiceModel!.companyId,
                              "created_at_date":
                                  state.invoiceModel!.createdAtDate.toString(),
                              "created_at_time":
                                  state.invoiceModel!.createdAtTime.toString(),
                              "customer_id": state.invoiceModel!.customerId,
                              "deleted_at":
                                  state.invoiceModel!.deletedAt.toString(),
                              "email": state.invoiceModel!.email.toString(),
                              "invoiceTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "gst_flag": gstFlag.toString(),
                              "gst_bill": gstBill.toString(),
                              "taxablevalueTotal": gstBill == "1"
                                  ? calculateSparePartSubtotal()
                                  : 0,
                              "cgstTotal": gstBill == "1" ? calculateCgst() : 0,
                              "scgtTotal": gstBill == "1" ? calculateCgst() : 0,
                              "invoice_id": state.invoiceModel!.invoiceId,
                              "invoice_number":
                                  state.invoiceModel!.invoiceNumber.toString(),
                              "full_name":
                                  state.invoiceModel!.fullName.toString(),
                              "invoice_labours": "",
                              "invoice_products": mergeSparePart().isEmpty
                                  ? ''
                                  : jsonEncode(mergeSparePart()),
                              "labourTotal": 0,
                              "last_invoice_id":
                                  state.invoiceModel!.lastinvoiceId,
                              "total_invoice_payment": payments != null
                                  ? payments!.reversed
                                      .map((payment) => {
                                            "afterDiscountAmount":
                                                payment.afterDiscountAmount,
                                            "after_pay_total_balance":
                                                payment.afterPayTotalBalance,
                                            "created_at": payment.createdAt,
                                            "pay_method": payment.payMethod,
                                            "payable_amount":
                                                payment.payableAmount,
                                            "total_balance": state.invoiceModel!
                                                .afterPayTotalAmount
                                                .toString(),
                                          })
                                      .toList()
                                  : [],
                              "mobile_number":
                                  state.invoiceModel!.mobileNumber.toString(),
                              "productTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "temp_date": _invoiceDateController.text,
                              "updated_at":
                                  state.invoiceModel!.updatedAt.toString(),
                            };
                            context.read<JobSheetDetailsBloc>().add(
                                  GenerateInvoiceEvent(
                                    id: state.invoiceModel!.invoiceId
                                        .toString(),
                                    formData: formData,
                                    triggerDownloadAfterGenerate: true,
                                  ),
                                );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                  "Please add at least one spare part and labour",
                                  style: TextStyle(
                                      color: blackColorDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                actions: [
                                  Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: blackColorDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                actionsAlignment: MainAxisAlignment.center,
                              ),
                            );
                          }
                        },
                        child: const Icon(
                          Icons.download,
                          size: 18,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            body: (state.status == JobSheetDetailsStatus.initial ||
                    state.status == JobSheetDetailsStatus.loading)
                ? const CenterLoader()
                : Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: whiteColor,
                            shape: const RoundedRectangleBorder(),
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.invoiceModel!.fullName
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: blackColor),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showGeneralDialog(
                                                barrierLabel: "Label",
                                                barrierDismissible: true,
                                                barrierColor:
                                                    blackColor.withOpacity(0.5),
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 300),
                                                context: context,
                                                pageBuilder:
                                                    (context, anim1, anim2) {
                                                  return Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      height: 75,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 20,
                                                              left: 20,
                                                              right: 20),
                                                      decoration: BoxDecoration(
                                                        color: whiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Material(
                                                          color: whiteColor,
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(
                                                                    () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return InvoiceEditCustomer(
                                                                              id: state.invoiceModel!.invoiceId,
                                                                              customerModel: CustomerModel(id: state.invoiceModel!.customerId, fullName: _fullNameController.text, address: _adressController.text, email: _emailController.text, mobileNumber: _phoneNumberController.text),
                                                                            );
                                                                          });
                                                                    },
                                                                  );
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    const Text(
                                                                      'Edit Customer',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                transitionBuilder: (context,
                                                    anim1, anim2, child) {
                                                  return SlideTransition(
                                                    position: Tween(
                                                      begin: const Offset(0, 1),
                                                      end: const Offset(0, 0),
                                                    ).animate(anim1),
                                                    child: child,
                                                  );
                                                },
                                              );
                                            },
                                            child: const Icon(
                                              Icons.more_vert,
                                              color: blackColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: Image.asset(
                                              "assets/icons/email.png",
                                              color: blackColorLight,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            state.invoiceModel!.email
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: blackColorLight),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                    width: 15,
                                                    child: Image.asset(
                                                      "assets/icons/phone.png",
                                                      color: blackColorLight,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    state.invoiceModel!
                                                        .mobileNumber
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: blackColorLight),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: hintTextColor,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Expanded(
                                                      child: Text(
                                                        state.invoiceModel!
                                                            .address
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              blackColorLight,
                                                        ),
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 4, left: 6, right: 5),
                                    child: Divider(
                                      color: hintTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: whiteColor,
                            shape: const RoundedRectangleBorder(),
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 13, right: 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: const Text(
                                            'Invoice Date:',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: blackColor,
                                                fontFamily: 'Mulish',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _invoiceDateController,
                                    style: const TextStyle(
                                        fontSize: 13, color: blackColor),
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: const Icon(
                                            Icons.calendar_month_sharp),
                                        onPressed: () => _selectDate(context),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () => _selectDate(context),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: whiteColor,
                            shape: const RoundedRectangleBorder(),
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 10, bottom: 5, top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Spare Parts:',
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: blackColor,
                                                fontFamily: 'Mulish',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 4),
                                            child: Text(
                                              "Spare Parts  .  Qty  .   Rate",
                                              style: TextStyle(
                                                color: hintTextColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              showAddSpareParts(context);
                                            },
                                            icon: const Icon(
                                              addIcon,
                                              color: blackColor,
                                              size: 18,
                                            ),
                                            label: const Text(
                                              'Add',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            style: const ButtonStyle(
                                              shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                              ),
                                              foregroundColor:
                                                  WidgetStatePropertyAll(
                                                      blackColor),
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      primaryColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 13, right: 10, top: 3, bottom: 6),
                                  child: Divider(
                                    color: hintTextColor,
                                  ),
                                ),
                                if (sparePartsList.isNotEmpty) ...[
                                  Column(
                                    children: [
                                      for (var spareParts in sparePartsList)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// ---- Header (Product Name + More Button) ----
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      spareParts['product_name']
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black87,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  PopupMenuButton(
                                                    color: whiteColor,
                                                    itemBuilder: (context) =>
                                                        <PopupMenuEntry>[
                                                      const PopupMenuItem(
                                                        value: 'edit',
                                                        child: Text("Edit"),
                                                      ),
                                                      if (roleId != null &&
                                                          roleId != '4')
                                                        const PopupMenuItem(
                                                          value: 'delete',
                                                          child: Text("Delete"),
                                                        ),
                                                    ],
                                                    onSelected: (value) {
                                                      if (value == 'edit') {
                                                        setState(() {
                                                          gstBill == "1"
                                                              ? showEditAddSparePartWithGst(
                                                                  context,
                                                                  spareParts[
                                                                          'product_name']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_price']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_qty']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_unit']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_id']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_gst']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'hsn_code']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'showQuantity'] ??
                                                                      false,
                                                                  spareParts[
                                                                          'flag'] ??
                                                                      1,
                                                                  sparePartsList
                                                                      .indexOf(
                                                                          spareParts),
                                                                )
                                                              : showEditAddSparePart(
                                                                  context,
                                                                  spareParts[
                                                                          'product_name']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_price']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_qty']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_unit']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_id']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'showQuantity'] ??
                                                                      false,
                                                                  spareParts[
                                                                          'flag'] ??
                                                                      1,
                                                                  sparePartsList
                                                                      .indexOf(
                                                                          spareParts),
                                                                );
                                                        });
                                                      } else if (value ==
                                                              'delete' &&
                                                          roleId != null &&
                                                          roleId != '4') {
                                                        int index =
                                                            sparePartsList
                                                                .indexOf(
                                                                    spareParts);
                                                        setState(() {
                                                          sparePartsList
                                                              .removeAt(index);
                                                          state.invoiceModel!
                                                              .invoiceProducts!
                                                              .removeAt(index);

                                                          if (index ==
                                                              updateIndex) {
                                                            showUpdateButton =
                                                                false;
                                                            updateIndex = -1;
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: const Icon(
                                                        Icons.more_vert,
                                                        color: Colors.black87),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),

                                              /// GST ON → 4 rows layout
                                              if (gstBill == "1") ...[
                                                // Qty + Rate
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Qty: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                          "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Rate: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        const Icon(
                                                            Icons
                                                                .currency_rupee_sharp,
                                                            size: 12,
                                                            color: blackColor),
                                                        Text(
                                                          double.parse(spareParts[
                                                                      'product_price']
                                                                  .toString())
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),

                                                // GST + Taxable
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "GST: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        Text(
                                                          spareParts[
                                                              'product_gst'],
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Taxable: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        const Icon(
                                                            Icons
                                                                .currency_rupee_sharp,
                                                            size: 12,
                                                            color: blackColor),
                                                        Text(
                                                          calculateSubProductTotalNewList(
                                                                  spareParts)
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  blackColorDark),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),

                                                // HSN + Total
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "HSN: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        Text(
                                                          spareParts[
                                                                  'hsn_code'] ??
                                                              '',
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Total: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        const Icon(
                                                            Icons
                                                                .currency_rupee_sharp,
                                                            size: 12,
                                                            color: blackColor),
                                                        Text(
                                                          calculateTotalWithGstSparePartListNew(
                                                                  spareParts)
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  blackColorDark),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],

                                              /// GST OFF → single row layout
                                              if (gstBill != "1")
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Qty: ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    hintTextColor),
                                                          ),
                                                          Text(
                                                            "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                color:
                                                                    blackColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Rate: ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    hintTextColor),
                                                          ),
                                                          const Icon(
                                                              Icons
                                                                  .currency_rupee_sharp,
                                                              size: 12,
                                                              color:
                                                                  blackColor),
                                                          Text(
                                                            double.parse(spareParts[
                                                                        'product_price']
                                                                    .toString())
                                                                .toStringAsFixed(
                                                                    2),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                color:
                                                                    blackColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Total: ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    hintTextColor),
                                                          ),
                                                          const Icon(
                                                              Icons
                                                                  .currency_rupee_sharp,
                                                              size: 12,
                                                              color:
                                                                  blackColor),
                                                          Text(
                                                            calculateSubProductTotal(
                                                                    spareParts)
                                                                .toStringAsFixed(
                                                                    2),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    blackColorDark),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Divider(
                                                    color: hintTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                                if (sparePartsListNew.isNotEmpty) ...[
                                  Column(
                                    children: [
                                      for (var spareParts in sparePartsListNew)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// ---- Header (Product Name + More Button) ----
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      spareParts['product_name']
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: blackColor,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  PopupMenuButton(
                                                    color: whiteColor,
                                                    itemBuilder: (context) =>
                                                        <PopupMenuEntry>[
                                                      const PopupMenuItem(
                                                        value: 'edit',
                                                        child: Text("Edit"),
                                                      ),
                                                      if (roleId != null &&
                                                          roleId != '4')
                                                        const PopupMenuItem(
                                                          value: 'delete',
                                                          child: Text("Delete"),
                                                        )
                                                      else if (roleId == '4' &&
                                                          spareParts
                                                              .containsKey(
                                                                  'is_delete'))
                                                        const PopupMenuItem(
                                                          value: 'delete',
                                                          child: Text("Delete"),
                                                        ),
                                                    ],
                                                    onSelected: (value) {
                                                      if (value == 'edit') {
                                                        setState(() {
                                                          gstBill == "1"
                                                              ? showEditAddSparePartNewListWithGst(
                                                                  context,
                                                                  spareParts[
                                                                          'product_name']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_price']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_qty']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_unit']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_id']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_gst']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'hsn_code']
                                                                      .toString(),
                                                                  spareParts[
                                                                      'showQuantity'],
                                                                  spareParts[
                                                                      'flag'],
                                                                  sparePartsListNew
                                                                      .indexOf(
                                                                          spareParts),
                                                                )
                                                              : showEditAddSparePartNewList(
                                                                  context,
                                                                  spareParts[
                                                                          'product_name']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_price']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_qty']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_unit']
                                                                      .toString(),
                                                                  spareParts[
                                                                          'product_id']
                                                                      .toString(),
                                                                  spareParts[
                                                                      'showQuantity'],
                                                                  spareParts[
                                                                      'flag'],
                                                                  sparePartsListNew
                                                                      .indexOf(
                                                                          spareParts),
                                                                );
                                                        });
                                                      } else if (value ==
                                                          'delete') {
                                                        int index =
                                                            sparePartsListNew
                                                                .indexOf(
                                                                    spareParts);
                                                        setState(() {
                                                          sparePartsListNew
                                                              .removeAt(index);
                                                          if (index ==
                                                              updateIndex) {
                                                            showUpdateButton =
                                                                false;
                                                            updateIndex = -1;
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: const Icon(
                                                        Icons.more_vert,
                                                        color: Colors.black54,
                                                        size: 20),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 6),

                                              /// GST ON → 4 rows layout
                                              if (gstBill == "1") ...[
                                                // Qty + Rate
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Qty: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        Text(
                                                          "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Rate: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        const Icon(
                                                            Icons
                                                                .currency_rupee_sharp,
                                                            size: 12,
                                                            color: blackColor),
                                                        Text(
                                                          double.parse(spareParts[
                                                                      'product_price']
                                                                  .toString())
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),

                                                // GST + Taxable
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "GST: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        Text(
                                                          spareParts[
                                                              'product_gst'],
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Taxable: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        const Icon(
                                                            Icons
                                                                .currency_rupee_sharp,
                                                            size: 12,
                                                            color: blackColor),
                                                        Text(
                                                          calculateSubProductTotalNewList(
                                                                  spareParts)
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  blackColorDark),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),

                                                // HSN + Total
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "HSN: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        Text(
                                                          spareParts[
                                                                  'hsn_code'] ??
                                                              '',
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Total: ",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        const Icon(
                                                            Icons
                                                                .currency_rupee_sharp,
                                                            size: 12,
                                                            color: blackColor),
                                                        Text(
                                                          calculateTotalWithGstSparePartListNew(
                                                                  spareParts)
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  blackColorDark),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],

                                              /// GST OFF → single row layout
                                              if (gstBill != "1")
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Qty: ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    hintTextColor),
                                                          ),
                                                          Text(
                                                            "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                color:
                                                                    blackColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Rate: ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    hintTextColor),
                                                          ),
                                                          const Icon(
                                                              Icons
                                                                  .currency_rupee_sharp,
                                                              size: 12,
                                                              color:
                                                                  blackColor),
                                                          Text(
                                                            double.parse(spareParts[
                                                                        'product_price']
                                                                    .toString())
                                                                .toStringAsFixed(
                                                                    2),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                color:
                                                                    blackColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Total: ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    hintTextColor),
                                                          ),
                                                          const Icon(
                                                              Icons
                                                                  .currency_rupee_sharp,
                                                              size: 12,
                                                              color:
                                                                  blackColor),
                                                          Text(
                                                            calculateSubProductTotal(
                                                                    spareParts)
                                                                .toStringAsFixed(
                                                                    2),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    blackColorDark),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Divider(
                                                    color: hintTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  )
                                ] else
                                  const SizedBox.shrink(),
                                if (sparePartsList.isNotEmpty ||
                                    sparePartsListNew.isNotEmpty) ...[
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: darkgreyColor,
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                        bottomStart: Radius.circular(4),
                                        bottomEnd: Radius.circular(4),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "SparePart Total:",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .currency_rupee_sharp,
                                                      color: whiteColor,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      gstBill == "1"
                                                          ? calculateSubtotalGst()
                                                              .toStringAsFixed(
                                                                  2) // Show GST-inclusive total
                                                          : calculateSparePartSubtotal()
                                                              .toStringAsFixed(
                                                                  2)
                                                              .toString(), // Show regular subtotal
                                                      style: const TextStyle(
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                          Card(
                            color: whiteColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[300]!),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Text(
                                        'Subtotal',
                                        style: TextStyle(
                                            fontSize: 14.0, color: greyColor),
                                      ),
                                      Text(
                                        gstBill == "1"
                                            ? calculateSparePartSubtotal()
                                                .toStringAsFixed(2)
                                            : calculateSubtotalGst().toString(),
                                        style: const TextStyle(
                                          color: blackColorDark,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Text(
                                        'Discount',
                                        style: TextStyle(
                                            fontSize: 14.0, color: greyColor),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: TextFormField(
                                          controller: discountController,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: state.invoiceModel!
                                                        .afterPayTotalAmount !=
                                                    '0.00'
                                                ? blackColorDark
                                                : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          keyboardType: TextInputType.number,
                                          enabled: state.invoiceModel!
                                                  .afterPayTotalAmount !=
                                              '0.00',
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: state.invoiceModel!
                                                        .afterPayTotalAmount !=
                                                    '0.00'
                                                ? Colors.white
                                                : Colors.grey.shade200,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12),
                                          ),
                                          onChanged: (value) {
                                            double discount =
                                                double.tryParse(value) ?? 0.0;
                                            double totalAmount =
                                                double.tryParse(state
                                                        .invoiceModel!
                                                        .afterPayTotalAmount!) ??
                                                    0.0;

                                            if (discount > totalAmount) {
                                              discountController.text =
                                                  totalAmount
                                                      .toStringAsFixed(2);
                                              discountController.selection =
                                                  TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: discountController
                                                        .text.length),
                                              );
                                            }

                                            // Optionally update final amount after discount
                                            setState(() {
                                              finalAmountAfterDiscount =
                                                  totalAmount - discount;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // total amount show.
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text(
                                          'Total Amount',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: blackColorDark,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          finalAmountAfterDiscount
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                            color: blackColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (isGenerate == true ||
                              (calculateSubtotalGst() > 0 ||
                                  calculateSparePartSubtotal() > 0))
                            if (double.tryParse(state
                                    .invoiceModel!.afterDiscountAmount
                                    .toString()) !=
                                0)
                              Card(
                                color: whiteColor,
                                shape: const RoundedRectangleBorder(),
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, top: 10, bottom: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Amount Summary:',
                                            style: TextStyle(
                                              color: blackColor,
                                              fontFamily: 'Mulish',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          // Hide Add Payment if outstanding == 0
                                          if (calculateOutstandingAmount(
                                                  finalAmountAfterDiscount,
                                                  (state
                                                          .invoiceModel!
                                                          .paidAmount!
                                                          .isNotEmpty)
                                                      ? double.parse(state
                                                          .invoiceModel!
                                                          .paidAmount
                                                          .toString())
                                                      : 0.0) >
                                              0)
                                            ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  context
                                                      .read<
                                                          JobSheetDetailsBloc>()
                                                      .add(
                                                        GetInvoicePayment(
                                                          id: state
                                                              .invoiceModel!
                                                              .invoiceId
                                                              .toString(),
                                                        ),
                                                      );
                                                  setState(
                                                    () {
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return const AddPaymentForm();
                                                        },
                                                      );
                                                    },
                                                  );
                                                });
                                              },
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    WidgetStateProperty.all<
                                                        Color>(blackColor),
                                                backgroundColor:
                                                    WidgetStateProperty.all<
                                                        Color>(primaryColor),
                                                shape: WidgetStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                              ),
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    addIcon,
                                                    color: blackColor,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    "Add Payment",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: blackColorDark),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Total Amount",
                                                style: TextStyle(
                                                  color: hintTextColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                state.invoiceModel!
                                                    .afterDiscountAmount
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Received Amount",
                                                style: TextStyle(
                                                  color: hintTextColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                state.invoiceModel!.paidAmount
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Outstanding Amount",
                                                style: TextStyle(
                                                  color: hintTextColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                state.invoiceModel!
                                                    .afterPayTotalAmount
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          if (isGenerate == true ||
                              (calculateSubtotalGst() > 0 ||
                                  calculateSparePartSubtotal() > 0))
                            if (payments!.toList().isNotEmpty)
                              Card(
                                color: whiteColor,
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, top: 8, bottom: 10),
                                shape: const RoundedRectangleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Transaction List',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ListView.builder(
                                        itemCount: showAllTransactions
                                            ? payments?.length ?? 0
                                            : (payments?.length ?? 0) > 3
                                                ? 3
                                                : payments?.length ?? 0,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        itemBuilder: (context, index) {
                                          final payment = payments![index];
                                          return Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        const Text(
                                                          'Received Date: ',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              payment.recivedAmountDate ??
                                                                  '-',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          13),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        const SizedBox(
                                                            width: 6),
                                                        const Text(
                                                          'Payment Method: ',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        Text(
                                                          payment.payMethod ??
                                                              'N/A',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        const Text(
                                                          'Received Amount: ',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  hintTextColor),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .currency_rupee,
                                                                size: 13),
                                                            Text(
                                                              "${payment.payableAmount ?? 0}",
                                                              style: const TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      successColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const Divider(height: 10),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      if ((payments?.length ?? 0) > 3)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                showAllTransactions =
                                                    !showAllTransactions;
                                              });
                                            },
                                            child: Text(
                                              showAllTransactions
                                                  ? "Show Less"
                                                  : "Show More",
                                              style: const TextStyle(
                                                color: blackColorDark,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
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

  String formatQty(dynamic qty, dynamic flag) {
    if (flag == 0) return "-";

    final double value = double.tryParse(qty.toString()) ?? 0;
    if (value == value.toInt()) {
      return value.toInt().toString(); // 20.0 → 20
    } else {
      return value.toString(); // e.g. 20.5 → 20.5
    }
  }

  Future<void> showAddSpareParts(BuildContext context) async {
    productNameController = TextEditingController(text: '');
    sparePartNameController = TextEditingController(text: '');
    rateProductController = TextEditingController(text: '00');
    quantityProductController = TextEditingController(text: '1');
    hsnCodeProductController = TextEditingController(text: '');
    unitProductControlller = "PCS";
    gstController = "None";
    addNewMode = true;
    String? rateError;

    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: whiteColor,
              shape: const RoundedRectangleBorder(),
              insetPadding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
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
                              hsnCodeProductController.clear();
                              quantityProductController.text = '1';
                              unitProductControlller = "PCS";
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
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return [];
                              }
                              return state.sparePartList!.where(
                                (element) => element.productName!
                                    .trim()
                                    .toLowerCase()
                                    .contains(
                                      textEditingValue.text
                                          .trim()
                                          .toLowerCase(),
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
                                sparePartNameController =
                                    fieldTextEditingController;
                              }
                              return Padding(
                                padding: const EdgeInsets.only(right: 17),
                                child: TextField(
                                  controller: sparePartNameController,
                                  focusNode: fieldFocusNode,
                                  style: const TextStyle(
                                      color: blackColor, fontSize: 14),
                                  decoration: InputDecoration(
                                    hintText: "Enter Spare Part Name",
                                    hintStyle: const TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontSize: 13,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, right: 20.0),
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

                                    _debounce = Timer(
                                        const Duration(milliseconds: 300), () {
                                      if (text.length >= 3) {
                                        context.read<JobSheetDetailsBloc>().add(
                                              SearchSparePart(
                                                  searchKeyword: text),
                                            );
                                      }
                                    });

                                    sparePartNameController =
                                        fieldTextEditingController;
                                  },
                                ),
                              );
                            },
                            onSelected: (suggestion) {
                              sparePartNameController.text =
                                  suggestion.productName!;
                              productId = suggestion.productId.toString();
                              setState(
                                () {
                                  unitProductControlller =
                                      suggestion.productUnit.toString();
                                  gstController =
                                      suggestion.productGst.toString();
                                  hsnCodeProductController.text =
                                      suggestion.hashCode.toString();
                                },
                              );
                              double parseDouble = double.parse(
                                suggestion.productPrice.toString(),
                              );
                              int convertToInt = parseDouble.toInt();
                              setState(
                                () {
                                  rateProductController.text =
                                      convertToInt.toString();
                                },
                              );
                              sparePartNameController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset:
                                        sparePartNameController.text.length),
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return [];
                              }
                              return state.productList!.where(
                                (element) => element.sparePartName!
                                    .trim()
                                    .toLowerCase()
                                    .contains(
                                      textEditingValue.text
                                          .trim()
                                          .toLowerCase(),
                                    ),
                              );
                            },
                            displayStringForOption: (product) =>
                                product.sparePartName!,
                            fieldViewBuilder: (
                              BuildContext context,
                              TextEditingController fieldTextEditingController,
                              FocusNode fieldFocusNode,
                              VoidCallback onFieldSubmitted,
                            ) {
                              if (productNameController.text.isEmpty) {
                                productNameController =
                                    fieldTextEditingController;
                              }
                              return Padding(
                                padding: const EdgeInsets.only(right: 17),
                                child: TextField(
                                  controller: productNameController,
                                  style: const TextStyle(
                                      color: blackColor, fontSize: 14),
                                  focusNode: fieldFocusNode,
                                  decoration: InputDecoration(
                                    hintText: "Search Spare Part Name",
                                    hintStyle: const TextStyle(
                                      color: hintTextColor,
                                      fontFamily: 'Mulish',
                                      fontSize: 13,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 15, right: 20.0),
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

                                    _debounce = Timer(
                                        const Duration(milliseconds: 300), () {
                                      if (text.length >= 3) {
                                        context.read<JobSheetDetailsBloc>().add(
                                              SearchProduct(
                                                  searchKeyword: text),
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
                              productNameController.text =
                                  suggestion.sparePartName!;
                              gstController =
                                  suggestion.sparePartGst.toString();
                              hsnCodeProductController.text =
                                  suggestion.hashCode.toString();
                              productId = suggestion.id.toString();
                              setState(() {
                                unitProductControlller =
                                    suggestion.unitType.toString();
                              });
                              double parseDouble = double.parse(
                                suggestion.salesPrice.toString(),
                              );
                              int convertToInt = parseDouble.toInt();
                              setState(
                                () {
                                  rateProductController.text =
                                      convertToInt.toString();
                                },
                              );
                              productNameController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: productNameController.text.length),
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                                        inputFormatters: [
                                          NoLeadingSpaceFormatter()
                                        ],
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                    style: TextStyle(
                                        fontSize: 14, color: blackColor),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 18),
                                child: DropdownButtonFormField(
                                  style: const TextStyle(fontSize: 14),
                                  menuMaxHeight: 450,
                                  isExpanded: true,
                                  value: unitProductControlller,
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
                                  items: unitList
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
                                    unitProductControlller = value!.toString();
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
                    const SizedBox(height: 5),
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
                        style: const TextStyle(fontSize: 14),
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
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 20),
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
                    const SizedBox(height: 5),
                    if (gstBill == "1") ...[
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
                          style: const TextStyle(fontSize: 14),
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
                              : gstList.map<DropdownMenuItem<String>>((value) {
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
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20),
                            hintText: 'Enter HSN Code',
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
                            style: TextStyle(fontSize: 15, color: blackColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> showEditAddSparePartWithGst(
      BuildContext context,
      String productname,
      String rate,
      String qty,
      String unit,
      String sparePartproductId,
      String productGst,
      String hsnCode,
      bool showQuantity,
      int flag,
      int index) async {
    productNameController = TextEditingController(text: productname);
    rateProductController = TextEditingController(text: rate);
    quantityProductController = TextEditingController(text: qty);
    unitProductControlller = unit.toString();
    gstController = productGst.toString();
    productId = sparePartproductId;
    hsnCodeProductController = TextEditingController(text: hsnCode);
    bool isHideButtonSelected = showQuantity;
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
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
                            'Edit Spare Part',
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
                      const SizedBox(height: 10),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Spare Part Name:',
                            style: TextStyle(fontSize: 14, color: blackColor),
                          )),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFormField(
                          controller: productNameController,
                          textAlign: TextAlign.start,
                          cursorColor: blackColor,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: greyColor,
                              fontFamily: 'Mulish',
                              fontSize: 13,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20),
                            hintText: 'Enter Spare Part Name',
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
                                      style: TextStyle(
                                          color: blackColor, fontSize: 14),
                                    ),
                                  ),
                                ),
                                (isHideButtonSelected == false)
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          controller: quantityProductController,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(
                                              color: blackColor, fontSize: 14),
                                          inputFormatters: [
                                            NoLeadingSpaceFormatter()
                                          ],
                                          textAlign: TextAlign.start,
                                          cursorColor: blackColor,
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                              color: greyColor,
                                              fontFamily: 'Mulish',
                                              fontSize: 13,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 15, right: 20),
                                            hintText: '',
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                                  quantityProductController
                                                          .text =
                                                      "1"; // Set quantity to 1 when hiding
                                                }
                                              });
                                            },
                                          ),
                                          const Text(
                                            "Hide",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: blackColor),
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
                                      style: TextStyle(
                                          color: blackColor, fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 18),
                                  child: DropdownButtonFormField(
                                    menuMaxHeight: 450,
                                    isExpanded: true,
                                    value: unitProductControlller,
                                    style: const TextStyle(
                                        color: blackColor, fontSize: 14),
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
                                      style: TextStyle(
                                          color: hintTextColor, fontSize: 13),
                                    ),
                                    items: unitList
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
                                        unitProductControlller =
                                            value!.toString();
                                      });
                                    },
                                  ),
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
                          keyboardType: TextInputType.number,
                          style:
                              const TextStyle(color: blackColor, fontSize: 14),
                          inputFormatters: [
                            NoLeadingSpaceFormatter(),
                            LengthLimitingTextInputFormatter(7)
                          ],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: greyColor,
                              fontFamily: 'Mulish',
                              fontSize: 13,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20),
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
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'GST:',
                          style: TextStyle(fontSize: 14, color: blackColor),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 18),
                        child: DropdownButtonFormField(
                          menuMaxHeight: 450,
                          isExpanded: true,
                          style:
                              const TextStyle(color: blackColor, fontSize: 14),
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
                            style:
                                TextStyle(color: hintTextColor, fontSize: 13),
                          ),
                          items: gstList.map<DropdownMenuItem<String>>((value) {
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
                      ),
                      const SizedBox(height: 5),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'HSN Code:',
                          style: TextStyle(fontSize: 14, color: blackColor),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 18),
                        child: TextFormField(
                          controller: hsnCodeProductController,
                          keyboardType: TextInputType.text,
                          style:
                              const TextStyle(color: blackColor, fontSize: 14),
                          inputFormatters: [
                            NoLeadingSpaceFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: greyColor,
                              fontFamily: 'Mulish',
                              fontSize: 13,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20),
                            hintText: 'Enter HSN Code',
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
                              addEditSparePartWithGst(index, productId!,
                                  isHideButtonSelected, flag);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15, color: blackColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> showEditAddSparePart(
      BuildContext context,
      String productname,
      String rate,
      String qty,
      String unit,
      String sparePartproductId,
      bool showQuantity,
      int flag,
      int index) async {
    productNameController = TextEditingController(text: productname);
    rateProductController = TextEditingController(text: rate);
    quantityProductController = TextEditingController(text: qty);
    unitProductControlller = unit.toString();
    productId = sparePartproductId;
    // Show checkbox state as per server response
    bool isHideButtonSelected = showQuantity;
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
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
                            'Edit Spare Part',
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
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Spare Part Name:',
                          style: TextStyle(fontSize: 14, color: blackColor),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFormField(
                          controller: productNameController,
                          style:
                              const TextStyle(color: blackColor, fontSize: 14),
                          textAlign: TextAlign.start,
                          cursorColor: blackColor,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: greyColor,
                              fontFamily: 'Mulish',
                              fontSize: 13,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20),
                            hintText: 'Enter Spare Part Name',
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
                                      style: const TextStyle(
                                          color: blackColor, fontSize: 14),
                                    ),
                                  ),
                                ),
                                (isHideButtonSelected == false)
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: blackColor, fontSize: 14),
                                          controller: quantityProductController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            NoLeadingSpaceFormatter()
                                          ],
                                          textAlign: TextAlign
                                              .start, // Disable if hide is selected
                                          cursorColor: blackColor,
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                              color: greyColor,
                                              fontFamily: 'Mulish',
                                              fontSize: 13,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 15, right: 20),
                                            hintText: '',
                                            filled: true,
                                            fillColor: lightGreyColor,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                                  quantityProductController
                                                          .text =
                                                      "1"; // Set quantity to 1 when hiding
                                                }
                                              });
                                            },
                                          ),
                                          const Text(
                                            "Hide",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: blackColor),
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
                                      style: const TextStyle(
                                          color: blackColor, fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 18),
                                  child: DropdownButtonFormField(
                                    menuMaxHeight: 450,
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: blackColor, fontSize: 14),
                                    value: unitProductControlller,
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
                                    hint: const Text('Unit'),
                                    items: unitList
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
                                        unitProductControlller =
                                            value!.toString();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                          keyboardType: TextInputType.number,
                          style:
                              const TextStyle(color: blackColor, fontSize: 14),
                          inputFormatters: [
                            NoLeadingSpaceFormatter(),
                            LengthLimitingTextInputFormatter(7)
                          ],
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: greyColor,
                              fontFamily: 'Mulish',
                              fontSize: 13,
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 20),
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
                      ),
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
                              addEditSparePart(index, productId!,
                                  isHideButtonSelected, flag);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15, color: blackColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> showEditAddSparePartNewListWithGst(
      BuildContext context,
      String productname,
      String rate,
      String qty,
      String unit,
      String sparePartProductId,
      String productGst,
      String hsnCode,
      bool showQuantity,
      int flag,
      int index) async {
    productNameController = TextEditingController(text: productname);
    rateProductController = TextEditingController(text: rate);
    quantityProductController = TextEditingController(text: qty);
    unitProductControlller = unit.toString();
    gstController = productGst.toString();
    productId = sparePartProductId;
    hsnCodeProductController = TextEditingController(text: hsnCode);
    // Show checkbox state as per server response
    bool isHideButtonSelected = showQuantity;
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                          'Edit Spare part',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: blackColor),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Spare Part Name:',
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        controller: productNameController,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: hintTextColor,
                            fontFamily: 'Mulish',
                            fontSize: 13,
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 20),
                          hintText: 'Enter Spare Part Name',
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
                                    style: TextStyle(
                                        color: blackColor, fontSize: 14),
                                  ),
                                ),
                              ),
                              (isHideButtonSelected == false)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        controller: quantityProductController,
                                        style: const TextStyle(
                                            color: blackColor, fontSize: 14),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          NoLeadingSpaceFormatter()
                                        ],
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontSize: 13,
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 15, right: 20),
                                          hintText: '',
                                          filled: true,
                                          fillColor: lightGreyColor,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                          style: TextStyle(
                                              fontSize: 14, color: blackColor),
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
                                    style: const TextStyle(
                                        color: blackColor, fontSize: 14),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 18),
                                child: DropdownButtonFormField(
                                  menuMaxHeight: 450,
                                  style: const TextStyle(
                                      color: blackColor, fontSize: 14),
                                  isExpanded: true,
                                  value: unitProductControlller,
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
                                  hint: const Text('Unit'),
                                  items: unitList
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
                                    unitProductControlller = value!.toString();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Rate:',
                        style: TextStyle(color: blackColor, fontSize: 14),
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
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 20),
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
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'GST:',
                        style: TextStyle(color: blackColor, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 18),
                      child: DropdownButtonFormField(
                        menuMaxHeight: 450,
                        style: const TextStyle(color: blackColor, fontSize: 14),
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
                        items: gstList.map<DropdownMenuItem<String>>((value) {
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
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'HSN Code:',
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 18),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13),
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
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 20),
                          hintText: 'Enter HSN Code',
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
                            addEditSparePartNewListWithGst(
                                index, productId!, isHideButtonSelected, flag);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15, color: blackColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> showEditAddSparePartNewList(
      BuildContext context,
      String productname,
      String rate,
      String qty,
      String unit,
      String sparePartProductId,
      bool showQuantity,
      int flag,
      int index) async {
    productNameController = TextEditingController(text: productname);
    rateProductController = TextEditingController(text: rate);
    quantityProductController = TextEditingController(text: qty);
    unitProductControlller = unit.toString();
    productId = sparePartProductId;
    // Show checkbox state as per server response
    bool isHideButtonSelected = showQuantity;
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                          'Edit Spare part',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Spare Part Name:',
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        controller: productNameController,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 14, color: blackColor),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: hintTextColor,
                            fontFamily: 'Mulish',
                            fontSize: 13,
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 20),
                          hintText: 'Enter Spare Part Name',
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
                                    style: TextStyle(
                                        fontSize: 14, color: blackColor),
                                  ),
                                ),
                              ),
                              (isHideButtonSelected == false)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        controller: quantityProductController,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            fontSize: 14, color: blackColor),
                                        inputFormatters: [
                                          NoLeadingSpaceFormatter()
                                        ],
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontSize: 13,
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 15, right: 20),
                                          hintText: '',
                                          filled: true,
                                          fillColor: lightGreyColor,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                          style: TextStyle(
                                              fontSize: 14, color: blackColor),
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
                                    style: TextStyle(
                                        fontSize: 14, color: blackColor),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 18),
                                child: DropdownButtonFormField(
                                  menuMaxHeight: 450,
                                  style: const TextStyle(
                                      fontSize: 14, color: blackColor),
                                  isExpanded: true,
                                  value: unitProductControlller,
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
                                  hint: const Text('Unit'),
                                  items: unitList
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
                                    unitProductControlller = value!.toString();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14, color: blackColor),
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
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 20),
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
                    ),
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
                            addEditSparePartNewList(
                                index, productId!, isHideButtonSelected, flag);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15, color: blackColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addEditSparePartNewListWithGst(
      int index, String productId, bool showQuantity, int flag) {
    setState(() {
      final newProductNameController = productNameController.text;
      final newQuantityController = quantityProductController.text;
      final newRateController = rateProductController.text;
      final newUnitListController = unitProductControlller;
      final newGstController = gstController;
      final newHsnCodeController = hsnCodeProductController.text;

      if (newProductNameController.isNotEmpty &&
          newUnitListController.isNotEmpty &&
          newGstController.isNotEmpty) {
        sparePartsListNew[index]['product_name'] = newProductNameController;
        sparePartsListNew[index]['product_price'] =
            double.parse(newRateController.toString());
        sparePartsListNew[index]['product_id'] = productId.toString().isNotEmpty
            ? int.parse(productId.toString())
            : "";

        sparePartsListNew[index]['product_qty'] =
            double.parse(newQuantityController.toString());

        sparePartsListNew[index]['product_unit'] = newUnitListController;
        sparePartsListNew[index]['product_gst'] = newGstController;
        sparePartsListNew[index]['hsn_code'] = newHsnCodeController;

        if (!showQuantity && newQuantityController == "1") {
          sparePartsListNew[index]['showQuantity'] = false;
          sparePartsListNew[index]['flag'] = 1;
        } else {
          sparePartsListNew[index]['showQuantity'] = showQuantity;
          sparePartsListNew[index]['flag'] = showQuantity == false ? 1 : 0;
        }
      }
    });
  }

  void addEditSparePartNewList(
      int index, String productId, bool showQuantity, int flag) {
    setState(() {
      final newProductNameController = productNameController.text;
      final newQuantityController = quantityProductController.text;
      final newRateController = rateProductController.text;

      final newUnitListController = unitProductControlller;

      if (newProductNameController.isNotEmpty &&
          newUnitListController.isNotEmpty) {
        sparePartsListNew[index]['product_name'] = newProductNameController;
        sparePartsListNew[index]['product_price'] =
            double.parse(newRateController.toString());
        sparePartsListNew[index]['product_id'] = productId.toString().isNotEmpty
            ? int.parse(productId.toString())
            : "";
        sparePartsListNew[index]['product_qty'] =
            double.parse(newQuantityController.toString());
        sparePartsListNew[index]['product_unit'] = newUnitListController;

        ///
        if (!showQuantity && newQuantityController == "1") {
          sparePartsListNew[index]['showQuantity'] = false;
          sparePartsListNew[index]['flag'] = 1;
        } else {
          sparePartsListNew[index]['showQuantity'] = showQuantity;
          sparePartsListNew[index]['flag'] = showQuantity == false ? 1 : 0;
        }
      }
    });
  }

  List mergeSparePart() {
    List<Map<String, dynamic>> updatedNewSparePartList =
        sparePartsListNew.map((sparePart) {
      final updatedList = Map<String, dynamic>.from(sparePart);
      updatedList.remove('is_delete');
      return updatedList;
    }).toList();
    setState(() {
      sparePartsListNew = updatedNewSparePartList;
    });
    return sparePart = sparePartsList + sparePartsListNew;
  }

  deleteProduct(int spareParts) {
    setState(() {
      sparePartsList.removeAt(spareParts);
      if (spareParts == updateIndex) {
        showUpdateButton = false;
        updateIndex = -1;
      }
    });
  }

  void addSparePart() {
    setState(() {
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
        if (!addNewMode) {
          if (productId != null && productId!.isNotEmpty) {
            try {
              productID = int.parse(productId.toString()).toString();
            } catch (e) {
              print('Error parsing productId: $e');
            }
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
        if (!isQuantityHidden) {
          if (quantity == 1) {
            showQuantityValue = false;
            flagValue = 1;
          }
        } else {
          quantity = 1;
          showQuantityValue = true;
          flagValue = 0;
        }

        Map<String, dynamic> newSparePart = {
          'product_id': productID,
          'product_name': addNewMode
              ? newsparePartNameController
              : newProductNameController,
          'product_qty': quantity,
          'product_unit': newUnitListController,
          'product_price': rate,
          'product_gst': newGstController,
          'hsn_code': newHsnProductController,
          'showQuantity': showQuantityValue,
          'flag': flagValue,
          'is_delete': true,
        };

        sparePartsListNew.add(newSparePart);
      }
    });
    isQuantityHidden = false;
  }

  double calculateSubProductTotal(Map<String, dynamic> spareParts) {
    double productPrice =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double productQty =
        double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;

    return productPrice * productQty;
  }

  double calculateTotalWithGstSparePartList(Map<String, dynamic> spareParts) {
    double price =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
    double baseTotal = price * qty;
    String gstValue = spareParts['product_gst'].toString();
    double gstPercentage = 0.0;
    double cessPercentage = 0.0;
    if (gstValue.contains('@')) {
      List<String> parts = gstValue.split('+');
      String gstPart = parts[0].trim();
      if (gstPart.contains('@')) {
        gstPercentage =
            double.tryParse(gstPart.split('@')[1].replaceAll('%', '').trim()) ??
                0.0;
      }
      if (parts.length > 1) {
        String cessPart = parts[1].trim();
        if (cessPart.contains('@')) {
          cessPercentage = double.tryParse(
                  cessPart.split('@')[1].replaceAll('%', '').trim()) ??
              0.0;
        }
      }
    }
    double gstAmount = (baseTotal * gstPercentage) / 100;
    double cessAmount = (baseTotal * cessPercentage) / 100;
    double totalWithGst = baseTotal + gstAmount + cessAmount;
    return totalWithGst;
  }

  //calculation of total spare part amount applying gst
  double calculateTotalWithGstSparePartListNew(
      Map<String, dynamic> spareParts) {
    double price =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
    double baseTotal = price * qty;
    String gstValue = spareParts['product_gst'].toString();
    double gstPercentage = 0.0;
    double cessPercentage = 0.0;
    if (gstValue.contains('@')) {
      List<String> parts = gstValue.split('+');
      String gstPart = parts[0].trim();
      if (gstPart.contains('@')) {
        gstPercentage =
            double.tryParse(gstPart.split('@')[1].replaceAll('%', '').trim()) ??
                0.0;
      }
      if (parts.length > 1) {
        String cessPart = parts[1].trim();
        if (cessPart.contains('@')) {
          cessPercentage = double.tryParse(
                  cessPart.split('@')[1].replaceAll('%', '').trim()) ??
              0.0;
        }
      }
    }
    double gstAmount = (baseTotal * gstPercentage) / 100;
    double cessAmount = (baseTotal * cessPercentage) / 100;
    double totalWithGst = baseTotal + gstAmount + cessAmount;
    return totalWithGst;
  }

  double calculateSubProductTotalNewList(Map<String, dynamic> spareParts) {
    double productPrice =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double productQty =
        double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;

    return productPrice * productQty;
  }

  void addEditSparePart(
      int index, String productId, bool showQuantity, int flag) {
    setState(() {
      final newProductName = productNameController.text;
      final newQuantity = quantityProductController.text;
      final newRate = rateProductController.text;
      final newUnit = unitProductControlller;
      if (newProductName.isNotEmpty && newUnit.isNotEmpty) {
        sparePartsList[index]['product_name'] = newProductName;
        sparePartsList[index]['product_price'] = double.parse(newRate);
        sparePartsList[index]['product_qty'] = double.parse(newQuantity);
        sparePartsList[index]['product_unit'] = newUnit;
        sparePartsList[index]['product_id'] =
            productId.toString().isNotEmpty ? int.parse(productId) : "";

        if (!showQuantity && newQuantity == "1") {
          sparePartsList[index]['showQuantity'] = false;
          sparePartsList[index]['flag'] = 1;
        } else {
          sparePartsList[index]['showQuantity'] = showQuantity;
          sparePartsList[index]['flag'] = showQuantity == false ? 1 : 0;
        }
      }
    });
  }

  void addEditSparePartWithGst(
      int index, String productId, bool showQuantity, int flag) {
    setState(() {
      final newProductName = productNameController.text;
      final newQuantity = quantityProductController.text;
      final newRate = rateProductController.text;
      final newUnit = unitProductControlller;
      final newGst = gstController;
      final newHsnCodeController = hsnCodeProductController.text;

      if (newProductName.isNotEmpty &&
          newUnit.isNotEmpty &&
          newGst.isNotEmpty) {
        sparePartsList[index]['product_name'] = newProductName;
        sparePartsList[index]['product_price'] = double.parse(newRate);

        sparePartsList[index]['product_qty'] = double.parse(newQuantity);

        sparePartsList[index]['product_unit'] = newUnit;
        sparePartsList[index]['product_id'] =
            productId.toString().isNotEmpty ? int.parse(productId) : "";
        sparePartsList[index]['product_gst'] = newGst;
        sparePartsList[index]['hsn_code'] = newHsnCodeController;
        if (!showQuantity && newQuantity == "1") {
          sparePartsList[index]['showQuantity'] = false;
          sparePartsList[index]['flag'] = 1;
        } else {
          sparePartsList[index]['showQuantity'] = showQuantity;
          sparePartsList[index]['flag'] = showQuantity == false ? 1 : 0;
        }
      }
    });
  }

  // Function to calculate SparePartListTotal
  double calculateSparePartListTotal() {
    double subtotal = 0.0;
    for (var spareParts in sparePartsList) {
      double price =
          double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
      double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
      subtotal += price * qty;
    }
    return double.parse(subtotal.toStringAsFixed(2));
  }

  // Function to calculate SparePartListNewTotal
  double calculateSparePartListNewTotal() {
    double subtotal = 0;
    for (var spareParts in sparePartsListNew) {
      double price =
          double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
      double qty = double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
      subtotal += price * qty;
    }
    return double.parse(subtotal.toStringAsFixed(2));
  }

  // Function to calculate SparePartSubtotal
  double calculateSparePartSubtotal() {
    double subtotal = 0.0;
    if (calculateSparePartListTotal() != 0 ||
        calculateSparePartListNewTotal() != 0) {
      subtotal =
          calculateSparePartListTotal() + calculateSparePartListNewTotal();
    }
    subInvoiceTotal = gstBill == "1" ? subtotal : calculateSubtotalGst();
    discountAmountPrice = double.tryParse(discountController.text) ?? 0.0;
    finalAmountAfterDiscount = subInvoiceTotal - discountAmountPrice;
    return double.parse(subtotal.toStringAsFixed(2));
  }

//Gst Sub Total calculation for sparePartList and sparePartListNew
  double calculateSubtotalGst() {
    double subtotal = 0.0;
    if (calculateSubTotalWithGst() != 0 || calculateSubTotalWithGstNew() != 0) {
      subtotal = calculateSubTotalWithGst() + calculateSubTotalWithGstNew();
    }
    subInvoiceTotal = gstBill == "1" ? calculateSparePartSubtotal() : subtotal;
    discountAmountPrice = double.tryParse(discountController.text) ?? 0.0;
    finalAmountAfterDiscount = subInvoiceTotal - discountAmountPrice;
    return double.parse(subtotal.toStringAsFixed(2));
  }

  //Gst Sub Total calculation for sparePartList
  double calculateSubTotalWithGst() {
    double subtotalWithGst = 0.0;
    for (var spareParts in sparePartsList) {
      if (spareParts is Map<String, dynamic>) {
        double price =
            double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
        double qty =
            double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
        String gstString = spareParts['product_gst'];
        double baseValue = price * qty;
        double gstPercentage = getGstPercentage(gstString);
        double gstAmount = baseValue * (gstPercentage / 100);
        double finalValue = baseValue + gstAmount;
        subtotalWithGst += finalValue;
      }
    }
    return subtotalWithGst;
  }

  //Gst Sub Total calculation for sparePartListNew
  double calculateSubTotalWithGstNew() {
    double subtotalWithGst = 0.0;
    for (var spareParts in sparePartsListNew) {
      if (spareParts is Map<String, dynamic>) {
        double price =
            double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
        double qty =
            double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;
        String gstString = spareParts['product_gst'];
        double baseValue = price * qty;
        double gstPercentage = getGstPercentage(gstString);
        double gstAmount = baseValue * (gstPercentage / 100);
        double finalValue = baseValue + gstAmount;
        subtotalWithGst += finalValue;
      }
    }
    return subtotalWithGst;
  }

  double getGstPercentage(String gstString) {
    if (gstString == "None" || gstString == "Exempted") {
      return 0.0; // No GST
    }

    // Match all percentages in the string, e.g., both GST and Cess
    final matches = RegExp(r"(\d+(\.\d+)?)%").allMatches(gstString);

    double totalPercentage = 0.0;
    for (var match in matches) {
      totalPercentage += double.tryParse(match.group(1)!) ?? 0.0;
    }

    return totalPercentage;
  }

// Function to calculate total GST (from taxable subtotal)
  double calculateTotalGst() {
    double totalGst = calculateSubtotalGst() - calculateSparePartSubtotal();
    return double.parse(totalGst.toStringAsFixed(2));
  }

  double calculateCgst() {
    double totalGst = calculateTotalGst();
    return double.parse((totalGst / 2).toStringAsFixed(2));
  }

  double calculateOutstandingAmount(totalAmount, totalRecivedAmount) {
    return totalAmount - totalRecivedAmount;
  }
}
