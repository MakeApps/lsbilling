part of 'stock_bloc.dart';

enum StockStatus {
  initial,
  loading,
  listSuccess,
  success,
  searching,
  createLoading,
  createSuccess,
  createFailure,
  failure,
  deleteLoading,
  deleteSuccess,
  stockCreateSuccessfully,
}

// enum CreateStockStatus {
//   initial,
//   loading,
// createLoading,
// createSuccess,
// createFailure,
//   success,
//   searching,
//   failure,
//   stockCreateSuccessfully,
// }

// ignore: must_be_immutable
class StockState extends Equatable {
  final StockStatus? stockStatus;
  final StockResponseModel? stockItems;
  final StockParams? stockParams;
  final int? lastTimestamp;
  final bool? hasReachedMax;
  final String? filter;
  final String? storageLocation;
  // final CreateStockStatus? createStockStatus;

  const StockState({
    this.stockStatus = StockStatus.initial,
    this.stockItems = StockResponseModel.empty,
    this.stockParams = const StockParams(),
    this.lastTimestamp,
    this.hasReachedMax = false,
    this.filter,
    this.storageLocation,
    // this.createStockStatus = CreateStockStatus.initial,
  });

  @override
  List<Object> get props => [
        stockStatus!,
        stockItems!,
        stockParams!,
        hasReachedMax!,
        lastTimestamp ?? 0,
        storageLocation ?? '',
        filter ?? '', // Add filter to props for proper state comparison
        // createStockStatus!,
      ];

  StockState copyWith({
    StockStatus? stockStatus,
    StockResponseModel? stockItems,
    StockParams? stockParams,
    int? lastTimestamp,
    bool? hasReachedMax,
    String? filter,
    String? storageLocation,
    // CreateStockStatus? createStockStatus,
  }) {
    return StockState(
      stockStatus: stockStatus ?? this.stockStatus,
      stockItems: stockItems ?? this.stockItems,
      stockParams: stockParams ?? this.stockParams,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      filter: filter ?? this.filter,
      storageLocation: storageLocation ?? this.storageLocation,
      // createStockStatus: createStockStatus ?? this.createStockStatus,
    );
  }
}
