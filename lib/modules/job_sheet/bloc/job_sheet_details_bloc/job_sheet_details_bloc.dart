import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:local_shout_billing/config/streamsControllers.dart';
import 'package:local_shout_billing/models/estimate_jobsheet_model.dart';
import 'package:local_shout_billing/models/invoice_payment_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:local_shout_billing/config.dart';
import 'package:local_shout_billing/models/customer_model.dart';
import 'package:local_shout_billing/models/estimate_model.dart';
import 'package:local_shout_billing/models/invoice_model.dart';
import 'package:local_shout_billing/models/job_card_detail_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/models/labour_model.dart';
import 'package:local_shout_billing/models/product_model.dart';
import 'package:local_shout_billing/models/slider_img_model.dart';
import 'package:local_shout_billing/models/spare_part_model.dart';
import 'package:local_shout_billing/modules/login/pages/login_page.dart';
import '../../../../models/vehical_model.dart';

part 'job_sheet_details_event.dart';
part 'job_sheet_details_state.dart';

class JobSheetDetailsBloc
    extends Bloc<JobSheetDetailsEvent, JobSheetDetailsState> {
  JobSheetDetailsBloc() : super(JobSheetDetailsState()) {
    //invoce event call
    on<GenerateInvoiceEvent>(_onGenerateInvoice);
    on<GetInvoiceByInvoice>(_onGetInvoiceByInvoice);
    on<GetInvoiceByJobSheet>(_onGetInvoiceByJobSheet);
    on<DownloadInvoicePdf>(_onDownloadInvoicebyInvoicePdf);

    on<GetInvoicePayment>(_onGetInvoicePayment);
    on<AddUpdatePayment>(_onAddUpdatePayment);

    //estimate event call
    on<GetEstimateDetailsByEstimate>(_onGetEstimateDetailsByEstimate);
    on<GetEstimate>(_onGetEstimate);
    on<EstimateAdd>(_onAddEstimateByJobSheet);
    on<GetEstimateDetailsByJobSheet>(_onGetEstimateDetailsByJobSheet);
    on<DownloadEstimatePdf>(_onDownloadEstimateByJobsheetPdf);

    //search event call
    on<UpdateCustomer>(_onUpdateCustomer);
    on<SearchLabour>(_onSearchLabour);
    on<SearchProduct>(_onSearchProduct);
    on<SearchSparePart>(_onSearchSparePart);
    on<UpdateVehicle>(_onUpdateVehicle);
    on<DeleteSparePart>(_onDeleteSparePart);

    //reset event call
    on<ResetLastEstimateId>(_onResetLastEstimateId);
    on<ResetLastInvoiceId>(_onResetLastInvoiceId);
    on<ClearData>(_onClearData);
    on<ClearInvoiceDetails>(_onClearInvoiceDetails);

    //gst update
    on<UpdateGstBillEvent>(_onUpdateGstBillEvent, transformer: restartable());
  }

  //--------------------------Estimate events-------------------------------
  Future<void> _onGetEstimateDetailsByEstimate(
      GetEstimateDetailsByEstimate event,
      Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(
          status:
              (event.status == JobSheetDetailsStatus.estimUpdateSuccessfully)
                  ? event.status
                  : JobSheetDetailsStatus.loading,
          estimateModel: EstimateModel.empty),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "id": event.id.toString(),
      "filter": 'Estimate',
    };

    final result =
        await app_instance.jobSheetRepository.getEstimateDetails(jsonData);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: JobSheetDetailsStatus.success,
          estimateModel: EstimateModel.fromJson(result),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.failed,
        ),
      );
    }
  }

  Future<void> _onGetEstimate(
      GetEstimate event, Emitter<JobSheetDetailsState> emit) async {
    try {
      emit(state.copyWith(
        status: JobSheetDetailsStatus.tabLoading,
      ));
      dynamic jwtToken = await app_instance.storage.read(key: "token");

      Map<String, Object> jsonData = {
        "token": jwtToken.toString(),
        "id": event.id.toString(),
      };

      final result =
          await app_instance.jobSheetRepository.getEstimateDetails(jsonData);

      if (result != null && result.isNotEmpty) {
        return emit(
          state.copyWith(
            status: JobSheetDetailsStatus.tabBarSuccess,
            jobcardEstimateModel: JobCardToEstimateModel.fromJson(result),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: JobSheetDetailsStatus.tabFailed,
          ),
        );
      }
    } catch (e, stack) {
      print("-fetch estimate-----$stack--$e");
    }
  }

  // Add Estimate by jobsheet
  Future<void> _onAddEstimateByJobSheet(
      EstimateAdd event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(status: JobSheetDetailsStatus.sending),
    );
    // create job sheet api call
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await jobSheetRepository.addEstimateByJobSheet(
        jsonData, event.id.toString());

    if (response.runtimeType == Null) {
      Fluttertoast.showToast(
          msg: "Something went wrong! Please check your internet connection");
    } else if (response.runtimeType != Null &&
        response['id'].runtimeType != Null) {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.estimateUpdated,
          currentEstimateIdByJobSheet: response['id'],
        ),
      );
    } else {
      emit(
        state.copyWith(status: JobSheetDetailsStatus.failed),
      );
    }
  }

  Future<void> _onGetEstimateDetailsByJobSheet(
      GetEstimateDetailsByJobSheet event,
      Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(
        status: JobSheetDetailsStatus.loading,
      ),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "id": event.id.toString(),
      "filter": 'jobsheet',
    };
    final result =
        await app_instance.jobSheetRepository.getEstimateDetails(jsonData);

    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: JobSheetDetailsStatus.success,
          jobcardEstimateModel: JobCardToEstimateModel.fromJson(result),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.failed,

          // estimateModel: EstimateModel.empty,
        ),
      );
    }
  }

  Future<void> _onDownloadEstimateByJobsheetPdf(
      DownloadEstimatePdf event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(status: JobSheetDetailsStatus.estimPdfLoading),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    try {
      final estimateUrl =
          await jobSheetRepository.getEstimatePdf(token, event.id);

      if (await canLaunch(estimateUrl)) {
        await launch(estimateUrl,
            forceSafariVC: false,
            forceWebView: false,
            enableJavaScript: false,
            enableDomStorage: true);
        emit(
          state.copyWith(status: JobSheetDetailsStatus.estimatePdfOpened),
        );
      } else {
        throw Exception('Could not launch URL');
      }
    } catch (e) {
      print('Error: $e');
      emit(
        state.copyWith(status: JobSheetDetailsStatus.estimatePdfFailed),
      );
    }
  }

  //--------------------------Search Api call event-------------------------------
  _onUpdateCustomer(
      UpdateCustomer event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(status: JobSheetDetailsStatus.updating),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "formData": jsonEncode(event.formData)
    };
    dynamic result = await app_instance.jobSheetRepository.updateCustomer(
      jsonData,
      event.id.toString(),
    );
    if (result['status'] == "Success") {
      emit(
        state.copyWith(status: JobSheetDetailsStatus.updated),
      );
      emit(
        state.copyWith(
            status: JobSheetDetailsStatus.customerUpdatedSyccessfully),
      );
    }
  }

  _onSearchLabour(
      SearchLabour event, Emitter<JobSheetDetailsState> emit) async {
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "search": event.searchKeyword.toString()
    };
    final result = await app_instance.jobSheetRepository.searchLabour(jsonData);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: JobSheetDetailsStatus.success,
          labourList: result
              .map<LabourModel>(
                (jsonData) => LabourModel.fromJson(jsonData),
              )
              .toList(),
        ),
      );
    }
  }

  _onSearchProduct(
      SearchProduct event, Emitter<JobSheetDetailsState> emit) async {
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "search": event.searchKeyword.toString()
    };
    final result =
        await app_instance.jobSheetRepository.searchProduct(jsonData);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: JobSheetDetailsStatus.success,
          productList: result
              .map<ProductModel>(
                (jsonData) => ProductModel.fromJson(jsonData),
              )
              .toList(),
        ),
      );
    }
  }

  FutureOr<void> _onSearchSparePart(
      SearchSparePart event, Emitter<JobSheetDetailsState> emit) async {
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      'token': token.toString(),
      'search': event.searchKeyword.toString(),
      'direction': 'down',
      'timestamp': event.timestamp.toString()
    };
    final result =
        await app_instance.jobSheetRepository.searchSparePart(jsonData);

    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: JobSheetDetailsStatus.success,
          sparePartList: result
              .map<SparePartModel>(
                (jsonData) => SparePartModel.fromJson(jsonData),
              )
              .toList(),
        ),
      );
    }
  }

  _onUpdateVehicle(
      UpdateVehicle event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(status: JobSheetDetailsStatus.updating),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "formData": jsonEncode(event.formData)
    };
    dynamic result = await app_instance.jobSheetRepository.updateVehicle(
      jsonData,
      event.id.toString(),
    );
    if (result['status'] == "Success") {
      emit(
        state.copyWith(status: JobSheetDetailsStatus.updated),
      );
      emit(
        state.copyWith(status: JobSheetDetailsStatus.success),
      );
    }
  }

  _onDeleteSparePart(
      DeleteSparePart event, Emitter<JobSheetDetailsState> emit) async {
    List<dynamic> estimate = state.estimateModel!.invoiceProducts!;
    emit(state.copyWith(status: JobSheetDetailsStatus.updating));
    estimate.removeWhere(
        (element) => element['product_id'].toString() == event.id.toString());

    emit(state.copyWith(
        status: JobSheetDetailsStatus.success,
        estimateModel:
            state.estimateModel!.copyWith(invoiceProducts: estimate)));
  }

  //--------------------------reset event -------------------------------
  _onResetLastEstimateId(
      ResetLastEstimateId event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(
        currentEstimateIdByJobSheet: 0,
      ),
    );
  }

  _onResetLastInvoiceId(
      ResetLastInvoiceId event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(
        currentInvoiceIdByJobSheet: 0,
        currentInvoiceId: 0,
      ),
    );
  }

  FutureOr<void> _onClearData(
      ClearData event, Emitter<JobSheetDetailsState> emit) {
    emit(
      state.copyWith(
          status: JobSheetDetailsStatus.initial,
          currentEstimateIdByJobSheet: 0,
          currentInvoiceId: 0,
          currentInvoiceIdByJobSheet: 0,
          customerList: CustomerModel.empty,
          estimateModel: EstimateModel.empty,
          invoiceModel: InvoiceModel.empty,
          jobSheetDetails: JobSheetDetailModel.empty,
          labourList: [],
          productList: [],
          vehicleList: VehicleModel.empty),
    );
  }

  _onClearInvoiceDetails(
      ClearInvoiceDetails event, Emitter<JobSheetDetailsState> emit) {
    emit(state.copyWith(
      status: JobSheetDetailsStatus.loading,
      invoiceModel: InvoiceModel.empty,
    ));
  }

  //--------------------------invoice-------------------------------

  //fetch invoice details by invocie id
  Future<void> _onGetInvoiceByInvoice(
      GetInvoiceByInvoice event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(
          status: (event.status == JobSheetDetailsStatus.updateSuccessfully)
              ? event.status
              : JobSheetDetailsStatus.loading,
          invoiceModel: InvoiceModel.empty),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "id": event.id.toString(),
      "filter": 'Invoice',
    };
    final result =
        await app_instance.jobSheetRepository.getInvoiceByInvoiceId(jsonData);
    if (result != null && result.isNotEmpty) {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.successInvoiceDetails,
          invoiceModel: InvoiceModel.fromJson(result),
        ),
      );
      if (event.executeStream == true) {
        StreamsBrodcasts.updateInvoiceDetailsStream.sink.add(
          event.id,
        );
      }
      return;
    } else {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.failed,
          invoiceModel: InvoiceModel.empty,
        ),
      );
    }
  }

  //create new invoice using jobsheet id
  Future<void> _onGetInvoiceByJobSheet(
      GetInvoiceByJobSheet event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(
        status: JobSheetDetailsStatus.invoiceLoadingJobcard,
      ),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "id": event.id.toString(),
      "filter": 'jobsheet',
    };

    final result =
        await app_instance.jobSheetRepository.getInvoiceByInvoiceId(jsonData);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: JobSheetDetailsStatus.invoiceSuccessJobcard,
          invoiceModel: InvoiceModel.fromJson(result),
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.invoicefailedJobcard,
        ),
      );
    }
  }

  // Update created invoice by invoice id
  Future<void> _onGenerateInvoice(
      GenerateInvoiceEvent event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(
        status: JobSheetDetailsStatus.sending,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await jobSheetRepository.generateInvoice(
      jsonData,
      event.id.toString(),
    );
    if (response.runtimeType == Null) {
      Fluttertoast.showToast(
          msg: "Something went wrong! Please check your internet connection");
    }
    if (response.runtimeType != Null && response['status'] == "Success") {
      await Future.delayed(const Duration(milliseconds: 300));
      add(
        GetInvoiceByInvoice(
          id: response['id'].toString(),
          status: JobSheetDetailsStatus.updateSuccessfully,
          executeStream: true,
        ),
      );
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.invoiceUpdated,
          currentInvoiceIdByJobSheet: response['id'],
          currentInvoiceId: response['id'],
          triggerDownloadAfterGenerate: event.triggerDownloadAfterGenerate,
        ),
      );
    } else {
      emit(
        state.copyWith(status: JobSheetDetailsStatus.failed),
      );
    }
  }

  //get invoice get payment
  FutureOr<void> _onGetInvoicePayment(
      GetInvoicePayment event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(
        status: JobSheetDetailsStatus.paymentLoading,
      ),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "id": event.id.toString()
    };
    final paymentResult =
        await app_instance.jobSheetRepository.getInvoicePayment(jsonData);
    if (paymentResult != null && paymentResult.isNotEmpty) {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.paymentSuccess,
          paymentModel: InvoicePaymentModel.fromJson(paymentResult),
        ),
      );
    } else {
      emit(
        state.copyWith(
            status: JobSheetDetailsStatus.paymentFailed,
            paymentModel: InvoicePaymentModel.empty),
      );
    }
  }

  //Update payment api call
  FutureOr<void> _onAddUpdatePayment(
      AddUpdatePayment event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(status: JobSheetDetailsStatus.loadingPaymentUpdating),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await jobSheetRepository.addPayment(jsonData);
    if (response['status'] == "Success") {
      emit(
        state.copyWith(status: JobSheetDetailsStatus.paymentUpdated),
      );
    } else {
      if (response['args'] != null &&
          response['args'] is List &&
          response['args'].isNotEmpty) {
        final args = response['args'][0];
        if (args is Map && args.containsKey('payable_amount')) {
          final errors = args['payable_amount'];
          if (errors is List && errors.isNotEmpty) {
            errors[0];
          }
        }
      }
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.paymentError,
          errorMessage: "Amount field is required",
        ),
      );
    }
  }

  //download invoice pdf
  Future<void> _onDownloadInvoicebyInvoicePdf(
      DownloadInvoicePdf event, Emitter<JobSheetDetailsState> emit) async {
    emit(
      state.copyWith(status: JobSheetDetailsStatus.invoicePdfLoading),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    try {
      final invoiceUrl =
          await jobSheetRepository.getInvoiceUrl(token, event.id);

      if (await canLaunch(invoiceUrl)) {
        await launch(invoiceUrl,
            forceSafariVC: false,
            forceWebView: false,
            enableJavaScript: false,
            enableDomStorage: true);
        emit(
          state.copyWith(status: JobSheetDetailsStatus.invoicePdfOpened),
        );
      } else {
        throw Exception('Could not launch URL');
      }
    } catch (e) {
      print('Error: $e');
      emit(
        state.copyWith(status: JobSheetDetailsStatus.invoicePdfFailed),
      );
    }
  }

  _onUpdateGstBillEvent(
      UpdateGstBillEvent event, Emitter<JobSheetDetailsState> emit) async {
    try {
      emit(
        state.copyWith(
          status: JobSheetDetailsStatus.updatingGst,
          source: event.source,
        ),
      );

      // Read token from secure storage
      dynamic jwtToken = await app_instance.storage.read(key: "token");

      Map<String, Object> jsonData = {
        "token": jwtToken.toString(),
        "formData": jsonEncode(event.formData),
      };
      dynamic result = await app_instance.jobSheetRepository.updateGstBill(
        jsonData,
        event.id.toString(),
      );

      if (result['status'] == "Success") {
        emit(
          state.copyWith(
            status: JobSheetDetailsStatus.updatedGst,
            source: event.source,
          ),
        );

        emit(
          state.copyWith(
            status: JobSheetDetailsStatus.gstSuccess,
            source: event.source,
          ),
        );
        if (event.source == GstActionSource.estimate) {
          add(
            GetEstimateDetailsByJobSheet(
              id: event.id.toString(),
            ),
          );
        } else if (event.source == GstActionSource.invoice) {
          add(
            GetInvoiceByJobSheet(
              id: event.id.toString(),
            ),
          );
        }
      }
    } catch (e) {
      // Handle any unexpected errors (e.g., network failure)
      emit(state.copyWith(
        status: JobSheetDetailsStatus.failed,
        source: event.source,
      ));
    }
  }
}
