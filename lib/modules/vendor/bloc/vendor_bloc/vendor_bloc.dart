import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/stock_vendor_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';

part 'vendor_event.dart';
part 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  VendorBloc() : super(const VendorState()) {
    on<FetchVendorList>(_onFetchVendorList);
    on<DeleteVendorRecord>(_onDeleteVendorRecord);
    on<AddVendor>(_onAddVendor);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();
  FutureOr<void> _onFetchVendorList(
      FetchVendorList event, Emitter<VendorState> emit) async {
    if (state.hasReachedMax! && event.status == VendorStatus.success) {
      return;
    }
    emit(
      state.copyWith(
        vendorStatus: (event.status == VendorStatus.success)
            ? VendorStatus.success
            : VendorStatus.loading,
      ),
    );

    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, String> jsonData = {
      'token': token.toString(),
      'direction': 'down',
      'timestamp': event.timestamp.toString(),
      'search': event.searchKeyword ?? "",
    };
    final result = await jobSheetRepository.getVendorList(jsonData);

    if (result != null && result.isNotEmpty) {
      List<StockVendorModel> vendorListing = result
          .map<StockVendorModel>(
            (jsonData) => StockVendorModel.fromJson(jsonData),
          )
          .toList();

      final bool hasReachedMax = vendorListing.length < 10;

      if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
        vendorListing = List.from(state.vendorList)..addAll(vendorListing);
      }

      return emit(
        state.copyWith(
          vendorStatus: VendorStatus.success,
          vendorList: vendorListing,
          hasReachedMax: hasReachedMax,
          lastTimestamp:
              vendorListing.isNotEmpty ? vendorListing.last.timestamp : null,
        ),
      );
    } else {
      if (event.searchKeyword.toString().isNotEmpty) {
        emit(
          state.copyWith(
            vendorStatus: VendorStatus.failure,
            vendorList: [],
            hasReachedMax: true,
          ),
        );
      }
    }
  }

  FutureOr<void> _onDeleteVendorRecord(
      DeleteVendorRecord event, Emitter<VendorState> emit) async {
    emit(
      state.copyWith(vendorStatus: VendorStatus.deleting),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };
    final result = await app_instance.jobSheetRepository.deleteVendor(jsonData);
    if (result['status'] == "Success") {
      emit(
        state.copyWith(
          vendorStatus: VendorStatus.deleted,
          vendorList: state.vendorList,
        ),
      );
    }
  }

  FutureOr<void> _onAddVendor(
      AddVendor event, Emitter<VendorState> emit) async {
    emit(
      state.copyWith(vendorStatus: VendorStatus.adding),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await jobSheetRepository.addVendor(jsonData);

    if (response['status'] == "Success") {
      emit(
        state.copyWith(
          vendorStatus: VendorStatus.added,
        ),
      );
    } else {
      String? errorMessage;
      String? phoneError;

      if (response['args'] != null &&
          response['args'] is List &&
          response['args'].isNotEmpty) {
        var firstArg = response['args'][0];

        if (firstArg is Map) {
          if (firstArg.containsKey('vendor_name') &&
              firstArg['vendor_name'] is List &&
              firstArg['vendor_name'].isNotEmpty) {
            errorMessage = firstArg['vendor_name'][0];
          } else if (firstArg.containsKey('_schema') &&
              firstArg['_schema'] is List &&
              firstArg['_schema'].isNotEmpty) {
            errorMessage = firstArg['_schema'][0];
          }
        }
        // Phone Number error
        if (firstArg.containsKey('phone_number') &&
            firstArg['phone_number'] is List &&
            firstArg['phone_number'].isNotEmpty) {
          phoneError = firstArg['phone_number'][0];
        }
      }

      errorMessage ??= response['message'];

      emit(
        state.copyWith(
          vendorStatus: VendorStatus.failure,
          errorMessage: errorMessage,
          phoneError: phoneError,
        ),
      );
    }
  }
}
