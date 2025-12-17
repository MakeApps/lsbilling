import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/customer_model.dart';
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(const CustomerState()) {
    on<FetchCustomerList>(_onFetchCustomerList);
    on<CreateCustomerRecord>(_onCreateCustomerRecord);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();

  FutureOr<void> _onFetchCustomerList(
      FetchCustomerList event, Emitter<CustomerState> emit) async {
    if (state.hasReachedMax! && event.status == CustomerStatus.success) {
      return;
    }
    emit(
      state.copyWith(
        customerStatus: (event.status == CustomerStatus.success)
            ? CustomerStatus.success
            : CustomerStatus.loading,
      ),
    );

    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, String> jsonData = {
      'token': token.toString(),
      'direction': 'down',
      'timestamp': event.timestamp?.toString() ?? '',
      'search': event.searchKeyword ?? "",
    };
    final result = await jobSheetRepository.getCustomerList(jsonData);

    if (result != null && result.isNotEmpty) {
      List<CustomerModel> customerListing = result
          .map<CustomerModel>(
            (jsonData) => CustomerModel.fromJson(jsonData),
          )
          .toList();

      final bool hasReachedMax = customerListing.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        customerListing = List.from(state.customerInfoList)
          ..addAll(customerListing);
      }

      return emit(
        state.copyWith(
          customerStatus: CustomerStatus.success,
          customerInfoList: customerListing,
          hasReachedMax: hasReachedMax,
          lastTimestamp: customerListing.isNotEmpty
              ? customerListing.last.timestamp
              : null,
        ),
      );
    } else {
      if (event.searchKeyword.toString().isNotEmpty) {
        emit(
          state.copyWith(
            customerStatus: CustomerStatus.failure,
            customerInfoList: [],
            hasReachedMax: true,
          ),
        );
      }
    }
  }

  FutureOr<void> _onCreateCustomerRecord(
      CreateCustomerRecord event, Emitter<CustomerState> emit) async {
    emit(
      state.copyWith(customerStatus: CustomerStatus.adding),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };

    dynamic response = await jobSheetRepository.createCustomer(jsonData);
    if (response['status'] == "Success") {
      emit(
        state.copyWith(
          customerStatus: CustomerStatus.added,
        ),
      );
    } else {
      emit(
        state.copyWith(
          customerStatus: CustomerStatus.failure,
        ),
      );
    }
  }
}
