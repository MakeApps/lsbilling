import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_shout_billing/components/center_loader.dart';
import 'package:local_shout_billing/components/drawer.dart';
import 'package:local_shout_billing/components/no_leading_space_formatter.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:local_shout_billing/config/data.dart';
import 'package:local_shout_billing/main_layout.dart';
import 'package:local_shout_billing/modules/Estimate/edit_customer_jobsheet.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_bloc/job_sheet_bloc.dart';
import 'package:local_shout_billing/modules/job_sheet/bloc/job_sheet_details_bloc/job_sheet_details_bloc.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import '../invoice/invoice_details_page.dart';
import 'component/add_spare_part.dart';

class EstimatePage extends StatefulWidget {
  const EstimatePage({
    super.key,
  });
  @override
  State<EstimatePage> createState() => _EstimatePageState();
}

class _EstimatePageState extends State<EstimatePage> {
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  String? productId;
  List<dynamic> sparePartsList = [];
  List<dynamic> sparePartsListNew = [];
  List<dynamic> sparePart = [];
  int updateIndex = 0;
  final FocusNode nameFocusNode = FocusNode();
  bool? showUpdateButton = false;
  bool addNewMode = false;
  int productTotalValue = 0;
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
  TextEditingController _estimateDateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? estimateTotalValue;
  double sgst = 0.0;
  double cgst = 0.0;
  String? gstFlag;
  String? gstBill;
  String? igstBill;
  String? roleId;
  bool isQuantityHidden = false;
  bool? isGenerate = false;
  bool isSaved = false;
  bool isModified = false;
  bool isFromOutside = false;
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFromOutside = true;
  }

  assignValues(JobSheetDetailsState state) {
    _fullNameController.text = state.estimateModel!.fullName.toString();
    _adressController.text = state.estimateModel!.address.toString();
    _emailController.text = state.estimateModel!.email.toString();
    _phoneNumberController.text = state.estimateModel!.mobileNumber.toString();
    _estimateDateController.text = state.estimateModel!.tempDate.toString();
    sparePartsList = state.estimateModel!.invoiceProducts!.toList();
    estimateTotalValue = state.estimateModel!.estimateTotal.toString();
    gstFlag = state.estimateModel!.gstFlag.toString();
    gstBill = state.estimateModel!.gstBill.toString();
    igstBill = state.estimateModel!.igstBill.toString();
  }

  Future<void> _loadRoleId() async {
    final id = await app_instance.appConfig.secureStorage.read(key: 'roleId');
    setState(() {
      roleId = id;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    productNameController.dispose();
    quantityProductController.dispose();
    rateProductController.dispose();
    _estimateDateController.dispose();
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
        _estimateDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobSheetDetailsBloc, JobSheetDetailsState>(
      listener: (context, state) async {
        if (state.status == JobSheetDetailsStatus.success) {
          CenterLoader.hide();
          assignValues(state);
          _loadRoleId();
          if (isFromOutside &&
              (calculateSubtotalGst() > 0 ||
                  calculateSparePartSubtotal() > 0)) {
            setState(() {
              isSaved = true;
            });
          }
          context.read<JobSheetBloc>().add(
                const FetchEstimateList(status: JobSheetStatus.success),
              );
        }
        if (state.status == JobSheetDetailsStatus.estimPdfLoading) {
          CenterLoader.show(context);
        }

        if (state.status == JobSheetDetailsStatus.estimatePdfOpened ||
            state.status == JobSheetDetailsStatus.estimatePdfFailed) {
          CenterLoader.hide();
        }
        if (state.status == JobSheetDetailsStatus.failure) {
          CenterLoader.hide();
          context.read<JobSheetDetailsBloc>().add(
                GetEstimateDetailsByEstimate(
                  id: state.estimateModel!.estimateId.toString(),
                ),
              );
        }
        if (state.status == JobSheetDetailsStatus.invoiceUpdated) {
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
                  ResetLastEstimateId(),
                );
            context.read<JobSheetBloc>().add(
                  const FetchEstimateList(status: JobSheetStatus.success),
                );
            Navigator.pushReplacementNamed(context, '/estimate_listing');

            return true;
          },
          child: MainLayout(
            title: const Text(
              "Edit Estimate",
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
                      ResetLastEstimateId(),
                    );
                context.read<JobSheetBloc>().add(
                      const FetchEstimateList(status: JobSheetStatus.success),
                    );
                Navigator.pushNamed(context, '/estimate_listing');
              },
              icon: const Icon(backarrow, color: whiteColor),
            ),
            bottomNavigationBar: BottomAppBar(
              color: whiteColor,
              child: SizedBox(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                                color: hintTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.currency_rupee_sharp,
                                size: 16,
                                color: blackColor,
                              ),
                              Text(
                                gstBill == "1"
                                    ? calculateSubtotalGst()
                                        .toStringAsFixed(2)
                                        .toString()
                                    : calculateSparePartSubtotal().toString(),
                                style: const TextStyle(
                                    color: blackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                            const Size(70, 40),
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 15),
                          ),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              (calculateSubtotalGst() > 0 ||
                                  calculateSparePartSubtotal() > 0)) {
                            Map<String, dynamic> formData = {
                              "address":
                                  state.estimateModel!.address.toString(),
                              "company_id": state.estimateModel!.companyId,
                              "created_at_date":
                                  state.estimateModel!.createdAtDate.toString(),
                              "created_at_time":
                                  state.estimateModel!.createdAtTime.toString(),
                              "customer_id": state.estimateModel!.customerId,
                              "deleted_at":
                                  state.estimateModel!.deletedAt.toString(),
                              "email": state.estimateModel!.email.toString(),
                              "estimateTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "estimate_id": state.estimateModel!.estimateId,
                              "estimate_number": state
                                  .estimateModel!.estimateNumber
                                  .toString(),
                              "gst_flag": gstFlag.toString(),
                              "gst_bill": gstBill.toString(),
                              "igst": igstBill.toString(),
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
                              "full_name":
                                  state.estimateModel!.fullName.toString(),
                              "invoice_labours": "",
                              "invoice_products": mergeSparePart().isEmpty
                                  ? ''
                                  : jsonEncode(mergeSparePart()),
                              "labourTotal": 0,
                              "last_estimate_id":
                                  state.estimateModel!.lastEstimateId,
                              "mobile_number":
                                  state.estimateModel!.mobileNumber.toString(),
                              "productTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "temp_date": _estimateDateController.text,
                              "updated_at":
                                  state.estimateModel!.updatedAt.toString(),
                            };
                            context.read<JobSheetDetailsBloc>().add(
                                  EstimateAdd(
                                      id: state.estimateModel!.estimateId
                                          .toString(),
                                      formData: formData),
                                );

                            Fluttertoast.showToast(
                              toastLength: Toast.LENGTH_SHORT,
                              msg: "Estimate updated successfully",
                              backgroundColor: successDarkColor,
                            );

                            isGenerate = true;
                            isSaved = true;
                            isModified = false;
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
                        child: Text(
                          isSaved ? 'Update' : 'Save',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                      ),
                    ),
                    if (((isSaved && !isModified) &&
                            (calculateSubtotalGst() > 0 ||
                                calculateSparePartSubtotal() > 0)) ||
                        isGenerate == true)
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
                          if (_formKey.currentState!.validate() &&
                              (calculateSubtotalGst() > 0 ||
                                  calculateSparePartSubtotal() > 0)) {
                            Map<String, dynamic> formData = {
                              "address":
                                  state.estimateModel!.address.toString(),
                              "company_id": state.estimateModel!.companyId,
                              "created_at_date":
                                  state.estimateModel!.createdAtDate.toString(),
                              "created_at_time":
                                  state.estimateModel!.createdAtTime.toString(),
                              "customer_id": state.estimateModel!.customerId,
                              "deleted_at":
                                  state.estimateModel!.deletedAt.toString(),
                              "email": state.estimateModel!.email.toString(),
                              "estimateTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "estimate_id": state.estimateModel!.estimateId,
                              "estimate_number": state
                                  .estimateModel!.estimateNumber
                                  .toString(),
                              "gst_flag": gstFlag.toString(),
                              "igst": igstBill.toString(),
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
                              "full_name":
                                  state.estimateModel!.fullName.toString(),
                              "invoice_labours": "",
                              "invoice_products": mergeSparePart().isEmpty
                                  ? ''
                                  : jsonEncode(mergeSparePart()),
                              "labourTotal": 0,
                              "last_estimate_id":
                                  state.estimateModel!.lastEstimateId,
                              "mobile_number":
                                  state.estimateModel!.mobileNumber.toString(),
                              "productTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "temp_date": _estimateDateController.text,
                              "updated_at":
                                  state.estimateModel!.updatedAt.toString(),
                            };
                            context.read<JobSheetDetailsBloc>().add(
                                  EstimateAdd(
                                      id: state.estimateModel!.estimateId
                                          .toString(),
                                      formData: formData),
                                );

                            await Future.delayed(
                              const Duration(milliseconds: 300),
                            );
                            context.read<JobSheetDetailsBloc>().add(
                                  DownloadEstimatePdf(
                                    id: state.estimateModel!.estimateId
                                        .toString(),
                                  ),
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
                        },
                        child: const Icon(
                          Icons.download,
                          size: 20,
                        ),
                      ),
                    if (((isSaved && !isModified) &&
                            (calculateSubtotalGst() > 0 ||
                                calculateSparePartSubtotal() > 0)) ||
                        isGenerate == true)
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
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              (calculateSubtotalGst() > 0 ||
                                  calculateSparePartSubtotal() > 0)) {
                            Map<String, dynamic> formData = {
                              "address":
                                  state.estimateModel!.address.toString(),
                              "comments": "",
                              "company_id": state.estimateModel!.companyId,
                              "created_at_date":
                                  state.estimateModel!.createdAtDate.toString(),
                              "created_at_time":
                                  state.estimateModel!.createdAtTime.toString(),
                              "customer_id": state.estimateModel!.customerId,
                              "deleted_at":
                                  state.estimateModel!.deletedAt.toString(),
                              "email": state.estimateModel!.email.toString(),
                              "estimateTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "gst_flag": gstFlag.toString(),
                              "igst": igstBill.toString(),
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
                              "estimate_id": state.estimateModel!.estimateId,
                              "estimate_number": state
                                  .estimateModel!.estimateNumber
                                  .toString(),
                              "full_name":
                                  state.estimateModel!.fullName.toString(),
                              "invoice_labours": "",
                              "invoice_products": mergeSparePart().isEmpty
                                  ? ''
                                  : jsonEncode(mergeSparePart()),
                              "labourTotal": 0,
                              "last_estimate_id":
                                  state.estimateModel!.lastEstimateId,
                              "mobile_number":
                                  state.estimateModel!.mobileNumber.toString(),
                              "productTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                              "temp_date": _estimateDateController.text,
                              "updated_at":
                                  state.estimateModel!.updatedAt.toString(),
                              "invoiceTotal": gstBill == "1"
                                  ? calculateSubtotalGst()
                                  : calculateSparePartSubtotal(),
                            };
                            context.read<JobSheetDetailsBloc>().add(
                                  GenerateInvoiceEvent(
                                      id: state.estimateModel!.estimateId
                                          .toString(),
                                      formData: formData),
                                );

                            Fluttertoast.showToast(
                                msg: "Invoice Updated Successfully",
                                backgroundColor: successDarkColor,
                                textColor: whiteColor);
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
                          'Invoice',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                      )
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
                                            state.estimateModel!.fullName
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
                                                                onTap:
                                                                    () async {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return EditCustomerByEstimate(
                                                                        id: state
                                                                            .estimateModel!
                                                                            .estimateId,
                                                                        fullname: state
                                                                            .estimateModel!
                                                                            .fullName
                                                                            .toString(),
                                                                        address: state
                                                                            .estimateModel!
                                                                            .address
                                                                            .toString(),
                                                                        email: state
                                                                            .estimateModel!
                                                                            .email
                                                                            .toString(),
                                                                        phoneno: state
                                                                            .estimateModel!
                                                                            .mobileNumber
                                                                            .toString(),
                                                                      );
                                                                    },
                                                                  );
                                                                  if (!mounted)
                                                                    return;
                                                                  // Safe setState after async gap
                                                                  setState(() {
                                                                    sparePartsList
                                                                        .clear();
                                                                    sparePartsListNew
                                                                        .clear();
                                                                  });

                                                                  if (!mounted)
                                                                    return;
                                                                  context
                                                                      .read<
                                                                          JobSheetDetailsBloc>()
                                                                      .add(
                                                                        GetEstimateDetailsByEstimate(
                                                                          id: state
                                                                              .estimateModel!
                                                                              .estimateId
                                                                              .toString(),
                                                                        ),
                                                                      );
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    const Text(
                                                                      'Edit Customer',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500),
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
                                                            begin: const Offset(
                                                                0, 1),
                                                            end: const Offset(
                                                                0, 0))
                                                        .animate(anim1),
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
                                          Image.asset(
                                            "assets/icons/email.png",
                                            height: 15,
                                            width: 15,
                                            color: blackColorLight,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            state.estimateModel!.email
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
                                                  Image.asset(
                                                    "assets/icons/phone.png",
                                                    height: 15,
                                                    width: 15,
                                                    color: blackColorLight,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    state.estimateModel!
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
                                                        state.estimateModel!
                                                            .address
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: blackColor,
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
                                            'Estimate Date:',
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
                                    style: const TextStyle(
                                        fontSize: 13, color: blackColor),
                                    controller: _estimateDateController,
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
                                            icon: const Icon(addIcon,
                                                color: whiteColor, size: 18),
                                            label: const Text(
                                              'Add',
                                              style: TextStyle(
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
                                                      } else if (value ==
                                                          'delete') {
                                                        int index =
                                                            sparePartsList
                                                                .indexOf(
                                                                    spareParts);
                                                        setState(() {
                                                          sparePartsList
                                                              .removeAt(index);

                                                          int newIndex = index;

                                                          state.estimateModel!
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
                                                          "Qty:",
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
                                                                  hintTextColor),
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
                                                          size: 13,
                                                          color: blackColor,
                                                        ),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Qty:",
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
                                                            "${double.parse(spareParts['product_price'].toString()).toStringAsFixed(2)}"
                                                                .toString(),
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
                                                            size: 13,
                                                            color: blackColor,
                                                          ),
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
                                                          fontSize: 15,
                                                          color: blackColor,
                                                          fontWeight:
                                                              FontWeight.w400),
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
                                                        )
                                                    ],
                                                    onSelected: (value) {
                                                      if (value == 'edit') {
                                                        gstBill == "1"
                                                            ? showEditAddSparePartNewListWithGst(
                                                                context,
                                                                spareParts['product_name']
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
                                                                        spareParts),
                                                              );
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
                                                        color: blackColorDark,
                                                        size: 25),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 8),

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
                                                          "Qty:",
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
                                                        Text(
                                                          calculateSubProductTotalNewList(
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
                                                          size: 13,
                                                          color: blackColor,
                                                        ),
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
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Qty:",
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
                                                          size: 13,
                                                          color: blackColor,
                                                        ),
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
                                        )),
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
                                                "SubTotal:",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
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
                                                                  2)
                                                          : calculateSparePartSubtotal()
                                                              .toStringAsFixed(
                                                                  2)
                                                              .toString(),
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

  String formatQty(dynamic qty, dynamic flag) {
    if (flag == 0) return "-";

    final double value = double.tryParse(qty.toString()) ?? 0;
    if (value == value.toInt()) {
      return value.toInt().toString(); // 20.0 → 20
    } else {
      return value.toString(); // e.g. 20.5 → 20.5
    }
  }

  Future<void> showEditCustomer(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Edit Customer Details'),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(cancelIcon),
              )
            ],
          ),
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 13),
              child: Text('Full name:'),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 13, right: 10, bottom: 5, top: 3),
              child: TextFormField(
                keyboardType: TextInputType.text,
                inputFormatters: [
                  NoLeadingSpaceFormatter(),
                ],
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                      color: hintTextColor, fontFamily: 'Mulish', fontSize: 14),
                  contentPadding: const EdgeInsets.only(
                    left: 15,
                    right: 20.0,
                  ),
                  filled: true,
                  fillColor: lightGreyColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showAddSpareParts(BuildContext context) async {
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AddSparePartsDialog(
        onSparePartAdded: (Map<String, dynamic> newSparePart) {
          setState(() {
            sparePartsListNew.add(newSparePart);
            isModified = true;
          });
        },
        gstBill: gstBill,
        igstBill: igstBill,
      ),
    );
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
                          icon: const Icon(clearIcon),
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
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        controller: productNameController,
                        textAlign: TextAlign.start,
                        cursorColor: blackColor,
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
                                            color: hintTextColor,
                                            fontFamily: 'Mulish',
                                            fontSize: 13,
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              left: 15, right: 20),
                                          hintText: '0',
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
                                    setState(
                                      () {
                                        unitProductControlller =
                                            value!.toString();
                                      },
                                    );
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
                        style: const TextStyle(color: blackColor, fontSize: 14),
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
                          hintText: '00',
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
                            addEditSparePart(
                                index, productId!, isHideButtonSelected, flag);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 14, color: whiteColor),
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

  List<String> get currentGstList {
    if (gstBill == "1" && igstBill == "1") {
      return igstList; // IGST list
    } else if (gstBill == "1" && igstBill == "0") {
      return gstList; // SGST/CGST list
    }
    return []; // default empty
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
    hsnCodeProductController = TextEditingController(text: hsnCode);
    productId = sparePartproductId;
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
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 9),
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
                          icon: const Icon(clearIcon),
                        )
                      ],
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Spare Part Name:',
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        style: const TextStyle(color: blackColor, fontSize: 13),
                        controller: productNameController,
                        textAlign: TextAlign.start,
                        cursorColor: blackColor,
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
                                            color: blackColor, fontSize: 13),
                                        inputFormatters: [
                                          NoLeadingSpaceFormatter()
                                        ],
                                        textAlign: TextAlign.start,
                                        cursorColor: blackColor,
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
                                  style: const TextStyle(
                                      color: blackColor, fontSize: 13),
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
                                          fontSize: 16,
                                          wordSpacing: 3,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        unitProductControlller =
                                            value!.toString();
                                      },
                                    );
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
                        style: const TextStyle(fontSize: 13, color: blackColor),
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
                    const SizedBox(
                      height: 5,
                    ),
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
                        style: const TextStyle(fontSize: 13, color: blackColor),
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
                        items: currentGstList
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: blackColor,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
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
                    const SizedBox(
                      height: 5,
                    ),
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
                        style: const TextStyle(color: blackColor, fontSize: 14),
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
                            addEditSparePartWithGst(
                                index, productId!, isHideButtonSelected, flag);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 16, color: whiteColor),
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
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: hintTextColor,
                            fontFamily: 'Mulish',
                            fontSize: 14,
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
                                  child: Text('Quantity:'),
                                ),
                              ),
                              (isHideButtonSelected == false)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        controller: quantityProductController,
                                        keyboardType: TextInputType.number,
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
                                        fontSize: 16, color: blackColor),
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
                                          fontSize: 16,
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
                        style: TextStyle(fontSize: 16, color: blackColor),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 18),
                      child: TextFormField(
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
                        width: MediaQuery.of(context).size.width *
                            0.8, // Same width as TextField (80% of screen width)
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
                            style: TextStyle(fontSize: 16, color: whiteColor),
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
    hsnCodeProductController = TextEditingController(text: hsnCode);
    productId = sparePartProductId;
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
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 9),
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
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Spare Part Name:',
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: TextFormField(
                        controller: productNameController,
                        style: const TextStyle(fontSize: 13, color: blackColor),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                            color: hintTextColor,
                            fontFamily: 'Mulish',
                            fontSize: 14,
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
                                  child: Text('Quantity:'),
                                ),
                              ),
                              (isHideButtonSelected == false)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: TextFormField(
                                        controller: quantityProductController,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            fontSize: 13, color: blackColor),
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
                                        fontSize: 16, color: blackColor),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 18),
                                child: DropdownButtonFormField(
                                  menuMaxHeight: 450,
                                  style: const TextStyle(
                                      fontSize: 13, color: blackColor),
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
                                          fontSize: 16,
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
                    const SizedBox(
                      height: 5,
                    ),
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
                        menuMaxHeight: 450,
                        isExpanded: true,
                        style: const TextStyle(fontSize: 13, color: blackColor),
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
                        items: currentGstList
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: blackColor,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
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
                    const SizedBox(
                      height: 5,
                    ),
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
                        style: const TextStyle(fontSize: 13, color: blackColor),
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width *
                            0.8, // Same width as TextField (80% of screen width)
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
                            style: TextStyle(fontSize: 16, color: whiteColor),
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

  List mergeSparePart() {
    List<Map<String, dynamic>> updatedSparePartsList =
        sparePartsListNew.map((sparePart) {
      final updatedSparePart = Map<String, dynamic>.from(sparePart);
      updatedSparePart.remove('is_delete');
      return updatedSparePart;
    }).toList();
    setState(() {
      sparePartsListNew = updatedSparePartsList;
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
      isModified = true;
    });
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
        sparePartsList[index]['product_id'] =
            productId.toString().isNotEmpty ? int.parse(productId) : "";
        sparePartsList[index]['product_qty'] = double.parse(newQuantity);
        sparePartsList[index]['product_unit'] = newUnit;

        ///
        if (!showQuantity && newQuantity == "1") {
          sparePartsList[index]['showQuantity'] = false;
          sparePartsList[index]['flag'] = 1;
        } else {
          sparePartsList[index]['showQuantity'] = showQuantity;
          sparePartsList[index]['flag'] = showQuantity == false ? 1 : 0;
        }
        sparePartsList[index]['product_gst'] = "";
      }
      isModified = true;
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
        sparePartsList[index]['product_id'] =
            productId.toString().isNotEmpty ? int.parse(productId) : "";
        sparePartsList[index]['product_qty'] = double.parse(newQuantity);
        sparePartsList[index]['product_unit'] = newUnit;
        if (!showQuantity && newQuantity == "1") {
          sparePartsList[index]['showQuantity'] = false;
          sparePartsList[index]['flag'] = 1;
        } else {
          sparePartsList[index]['showQuantity'] = showQuantity;
          sparePartsList[index]['flag'] = showQuantity == false ? 1 : 0;
        }
        sparePartsList[index]['product_gst'] = newGst;
        sparePartsList[index]['hsn_code'] = newHsnCodeController;
      }
      isModified = true;
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

        ///
        if (!showQuantity && newQuantityController == "1") {
          sparePartsListNew[index]['showQuantity'] = false;
          sparePartsListNew[index]['flag'] = 1;
        } else {
          sparePartsListNew[index]['showQuantity'] = showQuantity;
          sparePartsListNew[index]['flag'] = showQuantity == false ? 1 : 0;
        }
        sparePartsListNew[index]['product_unit'] = newUnitListController;
        isModified = true;
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
        isModified = true;
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
    return double.parse(subtotal.toStringAsFixed(2));
  }

  //calculation of total new spare part amount applying gst
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

  double calculateSubProductTotal(Map<String, dynamic> spareParts) {
    double productPrice =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double productQty =
        double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;

    return productPrice * productQty;
  }

  double calculateSubProductTotalNewList(Map<String, dynamic> spareParts) {
    double productPrice =
        double.tryParse(spareParts['product_price'].toString()) ?? 0.0;
    double productQty =
        double.tryParse(spareParts['product_qty'].toString()) ?? 0.0;

    return productPrice * productQty;
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

  //Gst Sub Total calculation for sparePartList and sparePartListNew
  double calculateSubtotalGst() {
    double totalGstList = calculateSubTotalWithGst();
    double totalGstNewList = calculateSubTotalWithGstNew();
    return totalGstList + totalGstNewList;
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

//   ///IGST total calculation
//   double calculateTotalIgst(List<Map<String, dynamic>> products) {
//   double totalIgst = 0.0;

//   for (var newProduct in sparePartsListNew) {
//     double price = newProduct["product_price"] * newProduct["product_qty"];
//     String gst = newProduct["product_gst"];

//     double igst = calculateIgst(price, gst);
//     totalIgst += igst;

//     newProduct["igst_amount"] = igst; // store per product IGST
//   }

//   return double.parse(totalIgst.toStringAsFixed(2));
// }

  double calculateSubTotalWithIGst() {
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
