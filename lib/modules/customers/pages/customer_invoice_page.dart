import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/models/customer_model.dart';
import 'package:local_shout_billing/modules/invoices/component/add_spare_part.dart';
import 'package:local_shout_billing/modules/invoices/component/edit_existing_gst_sparepart_list.dart';
import 'package:local_shout_billing/modules/invoices/component/edit_existing_list_part.dart';
import 'package:local_shout_billing/modules/invoices/component/edit_sparepart_newlist_gst.dart';
import 'package:local_shout_billing/modules/invoices/edit_invoice_customer_byjobsheet.dart';
import 'package:local_shout_billing/modules/invoices/invoice_details_page.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';

class GenerateInvoiceByJobSHeet extends StatefulWidget {
  const GenerateInvoiceByJobSHeet({
    super.key,
  });

  @override
  State<GenerateInvoiceByJobSHeet> createState() =>
      _GenerateInvoiceByJobSHeetState();
}

class _GenerateInvoiceByJobSHeetState extends State<GenerateInvoiceByJobSHeet> {
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  String? productId;
  List<dynamic> sparePartsList = [];
  List<dynamic> sparePartsListNew = [];
  List<dynamic> sparePart = [];
  int updateIndex = 0;
  bool? isGenerate = false;
  final FocusNode nameFocusNode = FocusNode();
  bool? showUpdateButton = false;
  bool addNewMode = false;
  String manufacturerController = '';
  int productTotalValue = 0;
  String unitProductControlller = "PCS";
  TextEditingController productNameController = TextEditingController();
  TextEditingController sparePartNameController = TextEditingController();
  TextEditingController quantityProductController =
      TextEditingController(text: '1');
  TextEditingController rateProductController =
      TextEditingController(text: '00');
  String gstController = "None";
  TextEditingController hsnCodeProductController = TextEditingController();

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _vehicleNameController = TextEditingController();
  TextEditingController _invoiceDateController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  double finalAmountAfterDiscount = 0.0;
  DateTime _selectedDate = DateTime.now();
  double sgst = 0.0;
  double cgst = 0.0;
  String? gstFlag;
  String? gstBill;
  String? igstBill;
  String? roleId;
  bool isQuantityHidden = false;
  double subInvoiceTotal = 0.0;
  double discountAmountPrice = 0.0;
  bool isDiscountEnabled = false;
  Timer? _debounce; // Define at class level

  assignValues(JobSheetDetailsState state) {
    _fullNameController.text = state.invoiceModel!.fullName.toString();
    _adressController.text = state.invoiceModel!.address.toString();
    _emailController.text = state.invoiceModel!.email.toString();
    _phoneNumberController.text = state.invoiceModel!.mobileNumber.toString();

    _invoiceDateController.text = state.invoiceModel!.tempDate.toString();
    sparePartsList = state.invoiceModel!.invoiceProducts!.toList();
    gstFlag = state.invoiceModel!.gstFlag.toString();
    gstBill = state.invoiceModel!.gstBill.toString();
    discountController.text = state.invoiceModel!.discountAmount.toString();
  }

  Future<void> _loadRoleId() async {
    final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');
    setState(() {
      roleId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    discountController.addListener(_onDiscountChanged);
    // _calculateInitialFinalAmount();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    productNameController.dispose();
    sparePartNameController.dispose();
    quantityProductController.dispose();
    rateProductController.dispose();
    _invoiceDateController.dispose();
    discountController.dispose();
    _fullNameController.dispose();
    _adressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _vehicleNumberController.dispose();
    _vehicleNameController.dispose();
    nameFocusNode.dispose();
  }

  void _onDiscountChanged() {
    setState(() {
      discountController;
    });
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
              onPrimary: whiteColor,
              onSurface: blackColorDark,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: whiteColor,
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
        if (state.status == JobSheetDetailsStatus.invoiceSuccessJobcard) {
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
        if (state.status == JobSheetDetailsStatus.invoiceUpdated) {
          context.read<JobSheetDetailsBloc>().add(
                ResetLastInvoiceId(),
              );
          context.read<JobSheetDetailsBloc>().add(
                GetInvoiceByInvoice(
                    id: state.currentInvoiceIdByJobSheet.toString(),
                    status: JobSheetDetailsStatus.updateSuccessfully),
              );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InvoiceDetailsPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.read<JobSheetDetailsBloc>().add(
                  ResetLastInvoiceId(),
                );
            Future.microtask(
              () {
                if (mounted) {
                  Navigator.pushNamed(context, '/invoice_page_listing');
                }
              },
            );
            return true;
          },
          child: MainLayout(
            title: const Text(
              "Create invoice",
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
                Future.microtask(
                  () {
                    if (mounted) {
                      Navigator.pushNamed(context, '/invoice_page_listing');
                    }
                  },
                );
              },
              icon: const Icon(
                backarrow,
                color: whiteColor,
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: whiteColor,
              child: Container(
                height: 60.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          foregroundColor: WidgetStatePropertyAll(whiteColor),
                          backgroundColor: WidgetStatePropertyAll(primaryColor),
                        ),
                        onPressed: () {
                          setState(() {
                            isDiscountEnabled = true;
                          });
                          if (_formKey.currentState!.validate() &&
                              (calculateSubTotalWithGstNew() > 0 ||
                                  calculateSparePartSubtotal() > 0)) {
                            Map<String, dynamic> formData = {
                              "address": state.invoiceModel!.address.toString(),
                              "afterDiscountAmount": finalAmountAfterDiscount,
                              "after_pay_total_balance": state
                                  .invoiceModel!.afterPayTotalAmount
                                  .toString(),
                              "discountAmount":
                                  discountController.text.toString(),
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
                              "igstTotal": igstBill == "1"
                                  ? calculateFinalIgstTotal()
                                  : 0,
                              "taxablevalueTotal": gstBill == "1"
                                  ? calculateSparePartSubtotal()
                                  : 0,
                              "cgstTotal": (gstBill == "1" && igstBill == "0")
                                  ? calculateCgst()
                                  : 0,
                              "scgtTotal": (gstBill == "1" && igstBill == "0")
                                  ? calculateCgst()
                                  : 0,
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
                                  state.currentInvoiceIdByJobSheet,
                              "manufacturers":
                                  state.invoiceModel!.manufacturers.toString(),
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

                            setState(() {
                              isGenerate = true;
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                  "Please add at least one spare part",
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
                                          color: whiteColor,
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
                          'Save',
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    if (isGenerate == true ||
                        (calculateTotal() > 0 || calculateTaxableTotal() > 0))
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(whiteColor),
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
                          setState(() {
                            isDiscountEnabled = true;
                          });
                          if (_formKey.currentState!.validate() &&
                              (calculateSubTotalWithGstNew() > 0 ||
                                  calculateSparePartSubtotal() > 0)) {
                            Map<String, dynamic> formData = {
                              "address": state.invoiceModel!.address.toString(),
                              "afterDiscountAmount": finalAmountAfterDiscount,
                              "discountAmount":
                                  discountController.text.toString(),
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
                              "cgstTotal": (gstBill == "1" && igstBill == "0")
                                  ? calculateCgst()
                                  : 0,
                              "scgtTotal": (gstBill == "1" && igstBill == "0")
                                  ? calculateCgst()
                                  : 0,
                              "igstTotal": igstBill == "1"
                                  ? calculateFinalIgstTotal()
                                  : 0,
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
                                  state.currentInvoiceIdByJobSheet.toString(),
                              "manufacturers":
                                  state.invoiceModel!.manufacturers.toString(),
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
                                      id: state.currentInvoiceIdByJobSheet
                                          .toString(),
                                      formData: formData),
                                );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                  "Please add at least one spare part",
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
                                          color: whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                actionsAlignment: MainAxisAlignment.center,
                              ),
                            );
                          }

                          if (true) {
                            context.read<JobSheetDetailsBloc>().add(
                                  DownloadInvoicePdf(
                                    id: state.currentInvoiceIdByJobSheet
                                        .toString(),
                                  ),
                                );
                          }
                        },
                        child: const Icon(
                          color: whiteColor,
                          Icons.download,
                          size: 25,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            body: (state.status == JobSheetDetailsStatus.initial ||
                    state.status == JobSheetDetailsStatus.invoiceLoadingJobcard)
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
                                                  return SafeArea(
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        height: 80,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            bottom: 30,
                                                            left: 20,
                                                            right: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child: Material(
                                                            color: Colors.white,
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
                                                                            return EditInvoiceCustomerByJobSheet(
                                                                              id: state.invoiceModel!.invoiceId,
                                                                              customerModel: CustomerModel(id: state.invoiceModel!.customerId, fullName: _fullNameController.text, address: _adressController.text, email: _emailController.text, mobileNumber: _phoneNumberController.text),
                                                                            );
                                                                          });
                                                                    });
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
                                                                        width:
                                                                            20,
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
                                          Container(
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
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: blackColor),
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
                                                  Container(
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
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: blackColor),
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
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: blackColor,
                                                        ),
                                                        // overflow: TextOverflow
                                                        //     .ellipsis,
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
                                            maxLines: 3,
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
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
                                                  fontSize: 10),
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
                                            icon: const Icon(addIcon,color: whiteColor),
                                            label: const Text(
                                              'Add',
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
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
                                                      whiteColor),
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
                                      left: 15, right: 10, top: 3, bottom: 6),
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
                                                          color: blackColorDark,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                        child: Text('Edit'),
                                                      ),
                                                      if (roleId != null &&
                                                          roleId != '4')
                                                        const PopupMenuItem(
                                                          value: 'delete',
                                                          child: Text('Delete'),
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
                                                                          'hsn_code'] ??
                                                                      '',
                                                                  spareParts[
                                                                          'showQuantity'] ??
                                                                      false,
                                                                  spareParts[
                                                                          'flag'] ??
                                                                      1,
                                                                  sparePartsList
                                                                      .indexOf(
                                                                          spareParts))
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

                                                          int newIndex = index;

                                                          state.invoiceModel!
                                                              .invoiceProducts!
                                                              .removeAt(
                                                                  newIndex);

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
                                                        color: blackColor,
                                                        size: 25),
                                                  )
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
                                                                hintTextColor,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                          "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: blackColor,
                                                          ),
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
                                                                  2)
                                                              .toString(),
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
                                                          "Taxable Value: ",
                                                          style: TextStyle(
                                                              color:
                                                                  hintTextColor,
                                                              fontSize: 11),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .currency_rupee_sharp,
                                                          size: 13,
                                                          color: blackColor,
                                                        ),
                                                        Text(
                                                          calculateSubProductTotal(
                                                                  spareParts)
                                                              .toStringAsFixed(
                                                                  2)
                                                              .toString(),
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
                                                                hintTextColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          spareParts[
                                                                  'hsn_code'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: blackColor,
                                                          ),
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
                                                          calculateTotalWithGstSparePartList(
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
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: blackColor,
                                                          ),
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
                                                                  2)
                                                              .toString(),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
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
                                                          color: blackColor,
                                                          fontWeight:
                                                              FontWeight.w400),
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
                                                        child: Text('Edit'),
                                                      ),
                                                      if (roleId != null &&
                                                          roleId != '4')
                                                        const PopupMenuItem(
                                                          value: 'delete',
                                                          child: Text('Delete'),
                                                        )
                                                      else if (roleId == '4' &&
                                                          spareParts
                                                              .containsKey(
                                                                  'is_delete'))
                                                        const PopupMenuItem(
                                                          value: 'delete',
                                                          child: Text('Delete'),
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
                                                                          'hsn_code'] ??
                                                                      '',
                                                                  spareParts[
                                                                      'showQuantity'],
                                                                  spareParts[
                                                                      'flag'],
                                                                  sparePartsListNew
                                                                      .indexOf(
                                                                          spareParts))
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
                                                                          spareParts));
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
                                                            productNameController
                                                                .clear();
                                                            quantityProductController
                                                                .clear();
                                                            rateProductController
                                                                .clear();
                                                            sparePartNameController
                                                                .clear();
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: const Icon(
                                                        Icons.more_vert,
                                                        color: blackColorDark,
                                                        size: 25),
                                                  )
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
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: blackColor,
                                                          ),
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
                                                                hintTextColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          spareParts[
                                                                  'hsn_code'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: blackColor,
                                                          ),
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
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Qty: ",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                hintTextColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${formatQty(spareParts['product_qty'], spareParts['flag'])} ${spareParts['product_unit']}",
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  blackColor),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text("Rate: ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    hintTextColor)),
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
                                                                    blackColor)),
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
                                  ),
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
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
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

    await showDialog(
      context: context,
      builder: (context) => InvoiceAddSparePartDialog(
        onSparePartAdded: (Map<String, dynamic> newSparePart) {
          setState(() {
            sparePartsListNew.add(newSparePart);
          });
        },
        gstBill: gstBill,
        igstBill: igstBill,
      ),
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
                        'Item Name:',
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
                          hintText: 'Enter Item Name',
                          filled: true,
                          fillColor: textfieldBg,
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
                                          fillColor: textfieldBg,
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
                                    fillColor: textfieldBg,
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
                          fillColor: textfieldBg,
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
                            style: TextStyle(fontSize: 15, color: whiteColor),
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
      context: context,
      builder: (_) => EditInvoiceNewGstSparePart(
        index: index,
        productName: productname,
        rate: rate,
        qty: qty,
        unit: unit,
        sparePartProductId: sparePartProductId,
        productGst: productGst,
        hsnCode: hsnCode,
        showQuantity: isHideButtonSelected,
        flag: flag,
        unitList: unitList,
        gstList: gstList,
        igstList: igstList,
        gstBill: gstBill,
        igstBill: igstBill,
        onUpdate:
            (i, name, price, qty, unit, gst, hsn, productId, showQty, flag) {
          setState(() {
            sparePartsListNew[i] = {
              "product_name": name,
              "product_price": double.parse(price),
              "product_qty": double.parse(qty),
              "product_unit": unit,
              "product_gst": gst,
              "hsn_code": hsn,
              "product_id": productId,
              "showQuantity": showQty,
              "flag": showQty ? 0 : 1,
              "is_delete": true
            };
          });
        },
      ),
    );
  }

  deleteProduct(dynamic spareParts) {
    setState(() {
      sparePartsList.removeAt(spareParts);
      if (spareParts == updateIndex) {
        showUpdateButton = false;
        updateIndex = -1;
        productNameController.clear();
        quantityProductController.clear();
        rateProductController.clear();
      }
    });
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

        ///
        if (!showQuantity && newQuantityController == "1") {
          sparePartsListNew[index]['showQuantity'] = false;
          sparePartsListNew[index]['flag'] = 1;
        } else {
          sparePartsListNew[index]['showQuantity'] = showQuantity;
          sparePartsListNew[index]['flag'] = showQuantity == false ? 1 : 0;
        }
        sparePartsListNew[index]['product_gst'] = newGstController;
        sparePartsListNew[index]['hsn_code'] = newHsnCodeController;
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

  double calculateSubProductTotalNewList(Map<String, dynamic> spareParts) {
    double productPrice =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double productQty =
        double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;

    return productPrice * productQty;
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

//Gst Sub Total calculation for sparePartList and sparePartListNew
  double calculateSubtotalGst() {
    double totalGstList = calculateSubTotalWithGst();
    double totalGstNewList = calculateSubTotalWithGstNew();
    return totalGstList + totalGstNewList;
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

// function to calculate SparePartSubtotal
  double calculateTotal() {
    double finalTotal = 0.0;
    if (calculateSparePartSubtotal() == 0) {
      finalTotal = 0;
    }
    if (calculateSparePartSubtotal() != 0) {
      finalTotal += calculateSparePartSubtotal();
    }

    if (calculateSparePartSubtotal() != 0) {
      finalTotal = calculateSparePartSubtotal();
    }
    subInvoiceTotal = gstBill == "1" ? calculateTaxableTotal() : finalTotal;
    discountAmountPrice = double.tryParse(discountController.text) ?? 0.0;
    finalAmountAfterDiscount = subInvoiceTotal - discountAmountPrice;
    return double.parse(finalTotal.toStringAsFixed(2));
  }

  // final sub total with gst
  double calculateTaxableTotal() {
    double finalTotal = 0;
    if (calculateSubtotalGst() == 0) {
      finalTotal = 0;
    }
    if (calculateSubtotalGst() != 0) {
      finalTotal += calculateSubtotalGst();
    }

    if (calculateSubtotalGst() != 0) {
      finalTotal = calculateSubtotalGst();
    }
    subInvoiceTotal = gstBill == "1" ? finalTotal : calculateTotal();
    discountAmountPrice = double.tryParse(discountController.text) ?? 0.0;
    finalAmountAfterDiscount = subInvoiceTotal - discountAmountPrice;
    return double.parse(finalTotal.toStringAsFixed(2));
  }

  updateSparePart() {
    if (productNameController.text.isNotEmpty &&
        productNameController.text.isNotEmpty) {
      sparePartsList[updateIndex] = productNameController.text;
      productNameController.clear();
    } else {}
    setState(() {
      showUpdateButton = false;
    });
  }

  // Function to calculate SparePartSubtotal
  double calculateSparePartSubtotal() {
    double subtotal = 0.0;
    if (calculateSparePartListTotal() != 0 ||
        calculateSparePartListNewTotal() != 0) {
      subtotal =
          calculateSparePartListTotal() + calculateSparePartListNewTotal();
    }
    return double.parse(subtotal.toStringAsFixed(2));
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

  ///////////discount
  void calculateFinalAmountWithDiscount() {
    double subTotal =
        gstBill == "1" ? calculateTaxableTotal() : calculateTotal();
    double discountAmount = double.tryParse(discountController.text) ?? 0.0;
    finalAmountAfterDiscount = subTotal - discountAmount;
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
      context: context,
      builder: (_) => EditInvoiceExistingSparePart(
        index: index,
        productName: productname,
        rate: rate,
        qty: qty,
        unit: unit,
        sparePartProductId: productId,
        showQuantity: isHideButtonSelected,
        flag: flag,
        onUpdate: (i, name, price, qty, unit, productId, showQty, flag) {
          setState(() {
            sparePartsList[i] = {
              "product_name": name,
              "product_price": double.parse(price),
              "product_qty": double.parse(qty),
              "product_unit": unit,
              "product_gst": "None",
              "hsn_code": "",
              "product_id": productId,
              "showQuantity": showQty,
              "flag": showQty ? 0 : 1,
              "is_delete": true
            };
          });
        },
      ),
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
      context: context,
      builder: (_) => EditInvoiceExistingGstSparePart(
        index: index,
        productName: productname,
        rate: rate,
        qty: qty,
        unit: unit,
        sparePartProductId: productId,
        productGst: productGst,
        hsnCode: hsnCode,
        showQuantity: isHideButtonSelected,
        flag: flag,
        unitList: unitList,
        gstList: gstList,
        igstList: igstList,
        gstBill: gstBill,
        igstBill: igstBill,
        onUpdate:
            (i, name, price, qty, unit, gst, hsn, productId, showQty, flag) {
          setState(() {
            sparePartsList[i] = {
              "product_name": name,
              "product_price": double.parse(price),
              "product_qty": double.parse(qty),
              "product_unit": unit,
              "product_gst": gst,
              "hsn_code": hsn,
              "product_id": productId,
              "showQuantity": showQty,
              "flag": showQty ? 0 : 1,
              "is_delete": true
            };
          });
        },
      ),
    );
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

  String formatQty(dynamic qty, dynamic flag) {
    if (flag == 0) return "-";

    final double value = double.tryParse(qty.toString()) ?? 0;
    if (value == value.toInt()) {
      return value.toInt().toString(); // 20.0 → 20
    } else {
      return value.toString(); // e.g. 20.5 → 20.5
    }
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

  double calculateIgstForList(List<Map<String, dynamic>> list) {
    double totalIgst = 0.0;

    for (var item in list) {
      double price = double.tryParse(item['product_price'].toString()) ?? 0.0;
      double qty = double.tryParse(item['product_qty'].toString()) ?? 0.0;
      String gstString = item['product_gst'];

      double baseValue = price * qty;
      double gstPercentage = getGstPercentage(gstString);

      double igstAmount = baseValue * (gstPercentage / 100);

      totalIgst += igstAmount;

      item['igst_amount'] = igstAmount; // store per product IGST
    }

    return double.parse(totalIgst.toStringAsFixed(2));
  }

  double calculateFinalIgstTotal() {
    double list1Igst = calculateIgstForList(
      sparePartsList.whereType<Map<String, dynamic>>().toList(),
    );

    double list2Igst = calculateIgstForList(
      sparePartsListNew.whereType<Map<String, dynamic>>().toList(),
    );

    double finalIgst = list1Igst + list2Igst;

    return double.parse(finalIgst.toStringAsFixed(2));
  }
}
