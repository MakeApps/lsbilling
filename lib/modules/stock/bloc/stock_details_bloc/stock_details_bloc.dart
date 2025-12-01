import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/stock_details_model.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'stock_details_event.dart';
part 'stock_details_state.dart';

class StockDetailsBloc extends Bloc<StockDetailsEvent, StockDetailsState> {
  StockDetailsBloc() : super(const StockDetailsState()) {
    // Define event handlers here if needed
    on<GetStockDetails>(_onGetStockDetails);
    on<UpdateManageStock>(_onUpdateManageStock);
    on<UpdateEditStock>(_onUpdateEditStock);
  }

  FutureOr<void> _onGetStockDetails(
      GetStockDetails event, Emitter<StockDetailsState> emit) async {
    emit(
      state.copyWith(
        stockDetailsStatus: StockDetailsStatus.detailsLoading,
        stockDetails: StockDetailsModel.empty,
      ),
    );
    dynamic jwtToken = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": jwtToken.toString(),
      "id": event.id.toString()
    };
    final stockDetails =
        await app_instance.jobSheetRepository.getStockDetails(jsonData);
    if (stockDetails != null && stockDetails.isNotEmpty) {
      emit(
        state.copyWith(
          stockDetailsStatus: StockDetailsStatus.success,
          stockDetails: StockDetailsModel.fromJson(stockDetails),
        ),
      );
    } else {
      emit(
        state.copyWith(
          stockDetailsStatus: StockDetailsStatus.failure,
          stockDetails: StockDetailsModel.empty,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateManageStock(
      UpdateManageStock event, Emitter<StockDetailsState> emit) async {
    emit(
      state.copyWith(
        stockDetailsStatus: StockDetailsStatus.updatingStock,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await app_instance.jobSheetRepository.updateManagerStock(
      jsonData,
      event.id.toString(),
    );
    if (response != null && response['status'] == "Success") {
      emit(
        state.copyWith(
          stockDetailsStatus: StockDetailsStatus.updatedStock,
        ),
      );
      await Future.delayed(
        const Duration(seconds: 1),
      );
      emit(
        state.copyWith(
          stockDetailsStatus: StockDetailsStatus.stockManageSuccessfully,
        ),
      );
    } else {
      emit(
        state.copyWith(
          stockDetailsStatus: StockDetailsStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateEditStock(
      UpdateEditStock event, Emitter<StockDetailsState> emit) async {
    emit(
      state.copyWith(
        stockDetailsStatus: StockDetailsStatus.updatingStockDetails,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic response = await app_instance.jobSheetRepository.updateEditStock(
      jsonData,
      event.id.toString(),
    );
    if (response != null && response['status'] == "Success") {
      emit(
        state.copyWith(
          stockDetailsStatus: StockDetailsStatus.stockDetailsUpdateSuccessfully,
        ),
      );
    } else {
      emit(
        state.copyWith(
          stockDetailsStatus: StockDetailsStatus.stockDetailsUpdateFailed,
        ),
      );
    }
  }
}
