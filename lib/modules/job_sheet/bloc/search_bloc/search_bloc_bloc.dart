import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/customer_complaint.dart';
import 'package:local_shout_billing/models/customer_model.dart';
import 'package:local_shout_billing/models/estimate_listing_model.dart';
import 'package:local_shout_billing/models/stock_vendor_model.dart';
import 'package:local_shout_billing/models/vehical_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBloc() : super(SearchBlocState()) {
    on<SearchVehicleDetails>(_onSearchVehicleDetails);
    on<SearchCustomerDetails>(_onSearchCustomerDetails);
    on<SearchCustomerComplent>(_onSearchCustomerComplent);
    on<SearchVendor>(_onSearchVendor);
  }

  _onSearchVehicleDetails(
      SearchVehicleDetails event, Emitter<SearchBlocState> emit) async {
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "search": event.searchKeyword.toString()
    };
    final result =
        await app_instance.jobSheetRepository.searchVehicleDetails(jsonData);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: SearchStatus.success,
          vehicleDetails: result
              .map<VehicleModel>((jsonData) => VehicleModel.fromJson(jsonData))
              .toList(),
        ),
      );
    }
  }

  _onSearchCustomerComplent(
      SearchCustomerComplent event, Emitter<SearchBlocState> emit) async {
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "search": event.searchKeyword.toString()
    };
    final result =
        await app_instance.jobSheetRepository.searchCustomerComplaints(jsonData);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: SearchStatus.success,
          customerComplaintList: result
              .map<CustomerComplaintModel>(
                  (jsonData) => CustomerComplaintModel.fromJson(jsonData))
              .toList(),
        ),
      );
    }
  }

  _onSearchCustomerDetails(
      SearchCustomerDetails event, Emitter<SearchBlocState> emit) async {
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "search": event.searchKeyword.toString()
    };
    final result =
        await app_instance.jobSheetRepository.searchCustomerDetails(jsonData);
    if (result != null && result.isNotEmpty) {
      return emit(
        state.copyWith(
          status: SearchStatus.success,
          customerList: result
              .map<CustomerModel>(
                  (jsonData) => CustomerModel.fromJson(jsonData))
              .toList(),
        ),
      );
    }
  }

  FutureOr<void> _onSearchVendor(
      SearchVendor event, Emitter<SearchBlocState> emit) async {
    final token = await app_instance.storage.read(key: "token");

    Map<String, String> jsonData = {
      "token": token.toString(),
      "search": event.searchKeyword.toString(),
    };

    final result = await app_instance.jobSheetRepository.getVendorList(jsonData);
   

    if (result != null && result.isNotEmpty) {
      List<StockVendorModel> vendorList = result
          .map<StockVendorModel>(
            (jsonData) => StockVendorModel.fromJson(jsonData),
          )
          .toList();

      emit(state.copyWith(
        vendorStatus: VendorSearchStatus.success,
        vendorList: vendorList,
      ));
    } else {
      emit(
        state.copyWith(
          vendorStatus: VendorSearchStatus.failure,
        ),
      );
    }
  }
}
