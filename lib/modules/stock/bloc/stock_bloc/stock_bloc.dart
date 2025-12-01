import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:local_shout_billing/models/stock_filter_model.dart';
import 'package:local_shout_billing/models/stock_list_model.dart';
import 'package:local_shout_billing/network/repositories/jobs_sheet_repository.dart';
import 'package:local_shout_billing/config.dart' as app_instance;
part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(const StockState()) {
    on<FetchStockList>(_onFetchStockList);
    on<FilterItems>(_onFilterItems);
    on<CreateAddNewStock>(_onCreateAddNewStock);
    on<DeleteStockRecord>(_onDeleteStockRecord);

    // Initialize with default filter (in_stock)
    add(const FetchStockList(
      filter: 'in_stock',
      status: StockStatus.initial,
    ));
  }
  final JobSheetRepository jobSheetRepository = JobSheetRepository();

  Future<void> _onFetchStockList(
      FetchStockList event, Emitter<StockState> emit) async {
    if (state.hasReachedMax! && event.status == StockStatus.success) {
      return;
    }
    emit(
      state.copyWith(
        stockStatus: event.status == StockStatus.success
            ? StockStatus.success
            : StockStatus.loading,
        filter: event.filter ?? state.filter,
        storageLocation: event.storageLocation ?? state.storageLocation,
      ),
    );

    try {
      dynamic token = await app_instance.storage.read(key: "token");

      Map<String, String> jsonData = {
        'token': token.toString(),
        'direction': 'down',
        'search': event.search ?? '',
        'timestamp': event.timestamp?.toString() ?? '',
        'filter': event.filter ?? state.filter ?? 'in_stock',
        'storage_location':
            event.storageLocation ?? state.storageLocation ?? '',
      };

      // Call API to fetch stock list
      final result = await jobSheetRepository.getStockList(jsonData);
      if (result != null && result['products'] != null) {
        final StockResponseModel newStockList =
            StockResponseModel.fromJson(result);

        final bool hasReachedMax = newStockList.products.length < 10;

        // List<ProductModel> updatedProducts =
        //     event.timestamp != null && state.stockItems!.products.isNotEmpty
        //         ? [...state.stockItems!.products, ...newStockList.products]
        //         : newStockList.products;
        List<ProductModel> updatedProducts;

        if (event.timestamp != null && state.stockItems!.products.isNotEmpty) {
          // merge existing + new
          updatedProducts = [
            ...state.stockItems!.products,
            ...newStockList.products,
          ];

          // remove duplicates using productId (or timestamp if productId नाही)
          final seenIds = <int>{};
          updatedProducts = updatedProducts.where((p) {
            if (seenIds.contains(p.id)) {
              return false;
            } else {
              seenIds.add(p.id);
              return true;
            }
          }).toList();
        } else {
          updatedProducts = newStockList.products;
        }

        // Update stockItems with new data
        final updatedStockItems = state.stockItems!.copyWith(
          allStock: newStockList.allStock,
          products: updatedProducts,
          stockLocation: newStockList.stockLocation,
          totalInStock: newStockList.totalInStock,
          totalMaxSellCount: newStockList.totalMaxSellCount,
          totalOutOfStock: newStockList.totalOutOfStock,
        );

        final int? lastTimestamp =
            updatedProducts.isNotEmpty ? updatedProducts.last.timestamp : null;

        emit(state.copyWith(
          stockStatus: StockStatus.success,
          stockItems: updatedStockItems,
          hasReachedMax: hasReachedMax,
          lastTimestamp: lastTimestamp,
          filter: event.filter ?? state.filter,
          storageLocation: event.storageLocation ?? state.storageLocation,
        ));
      } else {
        emit(state.copyWith(
          stockStatus: StockStatus.failure,
          hasReachedMax: true,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
          stockStatus: StockStatus.failure,
        ),
      );
    }
  }

//parameters bloc
  Future<void> _onFilterItems(
      FilterItems event, Emitter<StockState> emit) async {
    emit(
      state.copyWith(
        stockStatus: StockStatus.searching,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, String> jsonData = {
      'token': token.toString(),
    };
    if (event.filters.search.isNotEmpty) {
      jsonData["search"] = event.filters.search.toString();
    }

    // Add price filter if available
    if (event.filters.filter.isNotEmpty) {
      jsonData["filter"] = event.filters.filter;
    }

    // Add year filter if available
    if (event.filters.storageLocation != null) {
      jsonData["storage_location"] = event.filters.storageLocation!;
    }

    if (event.filters.direction.isNotEmpty) {
      jsonData["direction"] = event.filters.direction;
    }

    // reginal specs.
    if (event.filters.timestamp != null) {
      dynamic data = event.filters.timestamp!;
      jsonData["timestamp"] = data;
    }

    // Call Api.
    dynamic getResult =
        await app_instance.jobSheetRepository.getStockList(jsonData);

    final StockResponseModel stockList = StockResponseModel.fromJson(getResult);

    // Preserve pagination state when switching tabs
    // Reset pagination state for new filter/tab
    final bool hasReachedMax = stockList.products.length < 10;
    final int? lastTimestamp = stockList.products.isNotEmpty
        ? stockList.products.last.timestamp
        : null;

    emit(
      state.copyWith(
        stockStatus: StockStatus.success,
        stockItems: stockList,
        stockParams: event.filters,
        // Reset pagination state for new filter
        hasReachedMax: hasReachedMax,
        lastTimestamp: lastTimestamp,
        // Update filter and storage location
        filter: event.filters.filter,
        storageLocation: event.filters.storageLocation,
      ),
    );
  }

  FutureOr<void> _onCreateAddNewStock(
      CreateAddNewStock event, Emitter<StockState> emit) async {
    emit(
      state.copyWith(
        stockStatus: StockStatus.createLoading,
      ),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, dynamic> jsonData = {
      "token": token.toString(),
      "formData": jsonEncode(event.formData),
    };
    dynamic createStockResponse =
        await app_instance.jobSheetRepository.createNewStock(jsonData);

    if (createStockResponse['status'] == "Success") {
      emit(
        state.copyWith(
          stockStatus: StockStatus.createSuccess,
        ),
      );
    } else {
      emit(
        state.copyWith(
          stockStatus: StockStatus.createFailure,
        ),
      );
    }
  }

  FutureOr<void> _onDeleteStockRecord(
      DeleteStockRecord event, Emitter<StockState> emit) async {
    emit(
      state.copyWith(stockStatus: StockStatus.deleteLoading),
    );
    dynamic token = await app_instance.storage.read(key: "token");
    Map<String, Object> jsonData = {
      "token": token.toString(),
      "id": event.id.toString(),
    };

    final result = await app_instance.jobSheetRepository.deleteStock(jsonData);
    if (result['status'] == "Success") {
      emit(
        state.copyWith(
            stockStatus: StockStatus.deleteSuccess,
            stockItems: state.stockItems),
      );
    } else {
      emit(
        state.copyWith(
            stockStatus: StockStatus.failure, stockItems: state.stockItems),
      );
    }
  }
}
