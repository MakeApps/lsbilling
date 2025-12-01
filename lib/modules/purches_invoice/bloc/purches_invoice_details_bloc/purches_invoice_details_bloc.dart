import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:local_shout_billing/config.dart' as app_instance;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_shout_billing/models/purches_details_model_class.dart';
import 'package:local_shout_billing/models/storage_location.dart';
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
part 'purches_invoice_details_event.dart';
part 'purches_invoice_details_state.dart';

class PurchesInvoiceDetailsBloc
    extends Bloc<PurchesInvoiceDetailsEvent, PurchesInvoiceDetailsState> {
  PurchesInvoiceDetailsBloc() : super(const PurchesInvoiceDetailsState()) {
    on<GetPurchaseDetailsByID>(_onGetPurchaseDetailsByID);
    on<GeneratePurchaseInvoiceEvent>(_onGeneratePurchaseInvoiceEvent);
    on<ResetUpdateStatusEvent>(_onResetUpdateStatusEvent);
    on<FetchLocationList>(_onFetchLocationList);
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();

  FutureOr<void> _onGetPurchaseDetailsByID(GetPurchaseDetailsByID event,
      Emitter<PurchesInvoiceDetailsState> emit) async {
    emit(
      state.copyWith(getDetailsStatus: PurchesInvoiceDetailsStatus.loading),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");

    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "id": event.id.toString(),
      "filter": 'jobsheet',
    };
    final result = await jobSheetRepository.getPurchesDetailsByLastId(jsonData);
    if (result != null && result.isNotEmpty) {
      try {
        final model = PurchaseInvoiceDetailsModel.fromJson(result);
        emit(
          state.copyWith(
            getDetailsStatus: PurchesInvoiceDetailsStatus.getchSuccessfully,
            purchesDetailsModel: model,
          ),
        );
      } catch (e, stackTrace) {
        log("Error creating model: $e");
        log("Stack trace: $stackTrace");
        emit(
          state.copyWith(
            getDetailsStatus: PurchesInvoiceDetailsStatus.failure,
            purchesDetailsModel: PurchaseInvoiceDetailsModel.empty,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          getDetailsStatus: PurchesInvoiceDetailsStatus.failure,
          purchesDetailsModel: PurchaseInvoiceDetailsModel.empty,
        ),
      );
    }
  }

  FutureOr<void> _onGeneratePurchaseInvoiceEvent(
      GeneratePurchaseInvoiceEvent event,
      Emitter<PurchesInvoiceDetailsState> emit) async {
    emit(
      state.copyWith(updatePurchesStatus: UpdatePurchesStatus.updating),
    );
    dynamic token = await app_instance.storage.read(key: "token");

    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData)
    };

    dynamic response = await jobSheetRepository.updatePurchesInvoice(
      jsonData,
      event.id.toString(),
    );
    if (response.runtimeType != Null && response['status'] == "Success") {
      await Future.delayed(
        const Duration(milliseconds: 300),
      );
      add(GetPurchaseDetailsByID(id: event.id));
      emit(
        state.copyWith(
          updatePurchesStatus: UpdatePurchesStatus.updateSuccessfully,
          currentPurchesInvoiceId: response['id'],
        ),
      );
    } else {
      emit(
        state.copyWith(
          updatePurchesStatus: UpdatePurchesStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onResetUpdateStatusEvent(
      ResetUpdateStatusEvent event, Emitter<PurchesInvoiceDetailsState> emit) {
    emit(
      state.copyWith(updatePurchesStatus: UpdatePurchesStatus.initial),
    );
  }

  FutureOr<void> _onFetchLocationList(
      FetchLocationList event, Emitter<PurchesInvoiceDetailsState> emit) async {
    final token = await app_instance.storage.read(key: "token");
    Map<String, String> jsonData = {
      "token": token.toString(),
      "search": event.searchKeyword.toString(),
    };
    final result =
        await app_instance.jobSheetRepository.getStorageLocation(jsonData);
    if (result != null && result.isNotEmpty) {
      List<StorageLocationModel> locationListing = result
          .map<StorageLocationModel>(
            (jsonData) => StorageLocationModel.fromJson(jsonData),
          )
          .toList();
      emit(state.copyWith(
          getDetailsStatus: PurchesInvoiceDetailsStatus.searchSuccessfully,
          storageListing: locationListing));
    } else {
      emit(
        state.copyWith(
          getDetailsStatus: PurchesInvoiceDetailsStatus.failure,
        ),
      );
    }
  }
}
