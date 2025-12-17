import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/vendor_details_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'vendor_details_event.dart';
part 'vendor_details_state.dart';

class VendorDetailsBloc extends Bloc<VendorDetailsEvent, VendorDetailsState> {
  VendorDetailsBloc() : super(const VendorDetailsState()) {
    on<GetVendorsData>(_onGetVendorsData);
    on<UpdateEditVendor>(_onUpdateEditVendor);
  }

  FutureOr<void> _onGetVendorsData(
      GetVendorsData event, Emitter<VendorDetailsState> emit) async {
    emit(
      state.copyWith(
        vendorDetailsStatus: GetVendorsDetailsStatus.loading,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString()
    };

    final result =
        await app_instance.jobSheetRepository.getVendorsDetails(jsonData);

    if (result != null && result.isNotEmpty) {
      emit(
        state.copyWith(
          vendorDetailsStatus: GetVendorsDetailsStatus.success,
          vendorDetailsList: VendorsDetailsModel.fromJson(result),
        ),
      );
    } else {
      emit(
        state.copyWith(
            vendorDetailsStatus: GetVendorsDetailsStatus.failure,
            vendorDetailsList: VendorsDetailsModel.empty),
      );
    }
  }

  FutureOr<void> _onUpdateEditVendor(
      UpdateEditVendor event, Emitter<VendorDetailsState> emit) async {
    emit(
      state.copyWith(
        vendorDetailsStatus: GetVendorsDetailsStatus.updating,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await app_instance.jobSheetRepository.updateVendor(
      jsonData,
      event.id.toString(),
    );
    if (response != null && response['status'] == "Success") {
      emit(
        state.copyWith(
          vendorDetailsStatus: GetVendorsDetailsStatus.updated,
        ),
      );
    } else {
      emit(
        state.copyWith(
          vendorDetailsStatus: GetVendorsDetailsStatus.failure,
        ),
      );
    }
  }
}
