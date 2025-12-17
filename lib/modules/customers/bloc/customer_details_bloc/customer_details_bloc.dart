import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/customer_details_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'customer_details_event.dart';
part 'customer_details_state.dart';

class CustomerDetailsBloc
    extends Bloc<CustomerDetailsEvent, CustomerDetailsState> {
  CustomerDetailsBloc() : super(const CustomerDetailsState()) {
    on<GetCustomerDetail>(_onGetCustomerDetail);
    on<UpdateCustomerInfo>(_onUpdateCustomerInfo);
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
}
