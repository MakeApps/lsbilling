import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/purchase_list_model.dart';
import 'package:local_shout_billing/models/purches_invoice_list_model.dart';
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'purchase_invoice_event.dart';
part 'purchase_invoice_state.dart';

class PurchesInvoiceBloc
    extends Bloc<PurchesInvoiceEvent, PurchesInvoiceState> {
  PurchesInvoiceBloc() : super(PurchesInvoiceState()) {
    on<FetchPurchesInvoiceList>(_onFetchPurchesInvoiceList);
    on<CreatePurchesInvoice>(_onCreatePurchesInvoice);
    on<DeletePurchaseInvoice>(_onDeletePurchaseInvoice);
    on<ResetLasteId>(_onResetLastId);
    on<ResetAndFetchPurchesInvoice>(_onResetAndFetchPurchesInvoice);
  }

  final JobSheetRepository jobSheetRepository = JobSheetRepository();

  FutureOr<void> _onFetchPurchesInvoiceList(
    FetchPurchesInvoiceList event,
    Emitter<PurchesInvoiceState> emit,
  ) async {
    if (state.hasReachedMax! && event.timestamp != null) {
      return;
    }

    emit(
      state.copyWith(
          purchesStatus:
              (event.status == PurchesInvoiceStatus.fetchSuccessfully)
                  ? PurchesInvoiceStatus.fetchSuccessfully
                  : PurchesInvoiceStatus.loading,
          selectedGstFilter: event.gstBill),
    );

    try {
      final token = await app_instance.storage.read(key: "token");

      final Map<String, String> jsonData = {
        'token': token.toString(),
        'direction': event.direction ?? 'down',
        'timestamp': event.timestamp?.toString() ?? "",
        'search': event.searchKeyword ?? "",
        'fromDate': event.fromDate ?? "",
        'toDate': event.toDate ?? "",
        'gst_bill': event.gstBill ?? "",
        'paymentStatus': event.paymentStatus ?? "",
      };

      final result = await jobSheetRepository.getPurchesInvoiceList(jsonData);

      if (result != null && result.isNotEmpty) {
        PurchaseInvoiceModelList purchaseInvoiceCountList =
            PurchaseInvoiceModelList.fromJson(result);

        List<PurchaseInvoiceModel> purchaseList =
            purchaseInvoiceCountList.purchaseInvoiceeList;

        final bool hasReachedMax = purchaseList.length < 10;

        if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
          final existingList =
              List<PurchaseInvoiceModel>.from(state.purchesModel);
          purchaseList.removeWhere(
            (newItem) =>
                existingList.any((oldItem) => oldItem.id == newItem.id),
          );

          purchaseList = existingList..addAll(purchaseList);
        }
        emit(
          state.copyWith(
            purchesStatus: PurchesInvoiceStatus.fetchSuccessfully,
            purchesModel: purchaseList,
            hasReachedMax: hasReachedMax,
            lastTimestamp: purchaseList.isNotEmpty
                ? purchaseList.last.timestamp
                : state.lastTimestamp,
            selectedGstFilter: event.gstBill,
            //  Update counts
            allPurchaseCount: purchaseInvoiceCountList.allPurchaseCount,
            gstPurchaseInvoiceCount:
                purchaseInvoiceCountList.gstPurchaseInvoiceCount,
            nonGstPurchaseInvoiceCount:
                purchaseInvoiceCountList.nonGstPurchaseInvoiceCount,
          ),
        );
      } else {
        if (event.timestamp != null && event.timestamp.toString().isNotEmpty) {
          emit(
            state.copyWith(
              purchesStatus: PurchesInvoiceStatus.fetchSuccessfully,
              selectedGstFilter: event.gstBill,
              hasReachedMax: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              purchesStatus: PurchesInvoiceStatus.failure,
              purchesModel: [],
              selectedGstFilter: event.gstBill,
              hasReachedMax: true,
            ),
          );
        }
      }
    } catch (e, s) {
      log('Failed to fetch Purchase invoice list: $e', stackTrace: s);
      emit(
        state.copyWith(
          purchesStatus: PurchesInvoiceStatus.failure,
          selectedGstFilter: event.gstBill,
          purchesModel: [],
        ),
      );
    }
  }

  FutureOr<void> _onCreatePurchesInvoice(
    CreatePurchesInvoice event,
    Emitter<PurchesInvoiceState> emit,
  ) async {
    try {
      emit(
        state.copyWith(createPurchesStatus: CreatePurchesStatus.sending),
      );

      dynamic token = await app_instance.storage.read(key: "token");

      Map<String, dynamic> jsonData = {
        "token": token.toString(),
        "formData": jsonEncode(event.formData),
      };

      dynamic response =
          await jobSheetRepository.createPurchesInvoice(jsonData);

      if (response['last_id'] != null && response['status'] == "Success") {
        emit(
          state.copyWith(
            createPurchesStatus: CreatePurchesStatus.createSuccess,
            purchesLastId: response['last_id'],
          ),
        );
      } else {
        emit(
          state.copyWith(
            createPurchesStatus: CreatePurchesStatus.failure,
            purchesLastId: null,
          ),
        );
      }
    } catch (e, stackTrace) {
      log("CreatePurchesInvoice error: $e");
      log("Stacktrace: $stackTrace");
      emit(
        state.copyWith(
          createPurchesStatus: CreatePurchesStatus.failure,
          purchesLastId: null,
        ),
      );
    }
  }

  Future<void> _onDeletePurchaseInvoice(
      DeletePurchaseInvoice event, Emitter<PurchesInvoiceState> emit) async {
    emit(
      state.copyWith(purchesStatus: PurchesInvoiceStatus.updating),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString()
    };
    final result =
        await app_instance.jobSheetRepository.deletePurchaseInvoice(jsonData);
    if (result['status'] == "success") {
      emit(
        state.copyWith(
            purchesStatus: PurchesInvoiceStatus.deleteSuccess,
            purchesModel: state.purchesModel),
      );
    }
  }

  FutureOr<void> _onResetLastId(
      ResetLasteId event, Emitter<PurchesInvoiceState> emit) async {
    emit(
      state.copyWith(
        purchesLastId: 0,
      ),
    );
  }

  FutureOr<void> _onResetAndFetchPurchesInvoice(
    ResetAndFetchPurchesInvoice event,
    Emitter<PurchesInvoiceState> emit,
  ) async {
    emit(
      state.copyWith(purchesStatus: PurchesInvoiceStatus.initial),
    );
    add(const FetchPurchesInvoiceList(
      status: PurchesInvoiceStatus.fetchSuccessfully,
    ));
  }
}
