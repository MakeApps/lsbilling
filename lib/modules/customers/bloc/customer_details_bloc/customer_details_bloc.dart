import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/customer_details_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/models/customer_estimate_model.dart';
import 'package:local_shout_billing/models/customer_invoice_model.dart';
part 'customer_details_event.dart';
part 'customer_details_state.dart';

class CustomerDetailsBloc
    extends Bloc<CustomerDetailsEvent, CustomerDetailsState> {
  CustomerDetailsBloc() : super(const CustomerDetailsState()) {
    on<GetCustomerDetail>(_onGetCustomerDetail);
    on<UpdateCustomerInfo>(_onUpdateCustomerInfo);
    on<FetchEstimateInvoice>(_onFetchEstimateInvoice);
  }

  FutureOr<void> _onGetCustomerDetail(
      GetCustomerDetail event, Emitter<CustomerDetailsState> emit) async {
    emit(
      state.copyWith(
        customerDetailsStatus: GetCustomerStatusDetails.loading,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString()
    };

    final result =
        await app_instance.jobSheetRepository.getCustomerInfo(jsonData);

    if (result != null && result.isNotEmpty) {
      emit(
        state.copyWith(
          customerDetailsStatus: GetCustomerStatusDetails.success,
          customerDetailsList: CustomerDetailsModel.fromJson(result),
        ),
      );
    } else {
      emit(
        state.copyWith(
            customerDetailsStatus: GetCustomerStatusDetails.failure,
            customerDetailsList: CustomerDetailsModel.empty),
      );
    }
  }

  FutureOr<void> _onUpdateCustomerInfo(
      UpdateCustomerInfo event, Emitter<CustomerDetailsState> emit) async {
    emit(
      state.copyWith(
        customerDetailsStatus: GetCustomerStatusDetails.updating,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await app_instance.jobSheetRepository.updateCustomerInfo(
      jsonData,
      event.id.toString(),
    );
    if (response != null && response['status'] == "Success") {
      emit(
        state.copyWith(
          customerDetailsStatus: GetCustomerStatusDetails.updated,
        ),
      );
    } else {
      emit(
        state.copyWith(
          customerDetailsStatus: GetCustomerStatusDetails.failure,
        ),
      );
    }
  }

  FutureOr<void> _onFetchEstimateInvoice(
      FetchEstimateInvoice event, Emitter<CustomerDetailsState> emit) async {
    emit(
      state.copyWith(
        estimateInvoiceStatus: EstimateInvoiceStatus.loading,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, String> jsonData = {
      "token": token.toString(),
      "filter": event.filter,
      "vehicle_id": event.vehicleId.toString(),
    };
    final result = await app_instance.jobSheetRepository
        .getCustomersEstimateInvoice(event.customerId, jsonData);

    if (result != null && result.isNotEmpty) {
      List<InvoiceCustModel> invoiceCust = result
          .map<InvoiceCustModel>(
            (jsonData) => InvoiceCustModel.fromJson(jsonData),
          )
          .toList();
      List<EstimateCustModel> estimList = result
          .map<EstimateCustModel>(
            (jsonData) => EstimateCustModel.fromJson(jsonData),
          )
          .toList();

      if (event.filter == "Estimate") {
        emit(
          state.copyWith(
            estimateInvoiceStatus: EstimateInvoiceStatus.success,
            estimateCustList: estimList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            estimateInvoiceStatus: EstimateInvoiceStatus.success,
            invoiceCustList: invoiceCust,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          estimateInvoiceStatus: EstimateInvoiceStatus.failure,
        ),
      );
    }
  }
}
