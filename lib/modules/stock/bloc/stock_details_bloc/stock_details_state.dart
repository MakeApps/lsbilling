part of 'stock_details_bloc.dart';

enum StockDetailsStatus {
  initial,
  loading,
  detailsLoading,
  success,
  searching,
  failure,
  updatingStock,
  updatedStock,
  stockUpdateSuccessfully,
  stockManageSuccessfully,
  stockUpdateFailed,
  stockCreateSuccessfully,
  //update stock
  updatingStockDetails,
  updatedStockDetails,
  stockDetailsUpdateSuccessfully,
  stockDetailsUpdateFailed,
}

class StockDetailsState extends Equatable {
  final StockDetailsStatus? stockDetailsStatus;
  final StockDetailsModel? stockDetails;
  final String? errorMessage;
  const StockDetailsState({
    this.stockDetailsStatus = StockDetailsStatus.initial,
    this.stockDetails = StockDetailsModel.empty,
    this.errorMessage = "",
  });

  @override
  List<Object> get props => [
        stockDetailsStatus!,
        stockDetails!,
        errorMessage ?? "",
      ];
  StockDetailsState copyWith({
    StockDetailsStatus? stockDetailsStatus,
    StockDetailsModel? stockDetails,
    String? errorMessage,
  }) {
    return StockDetailsState(
      stockDetailsStatus: stockDetailsStatus ?? this.stockDetailsStatus,
      stockDetails: stockDetails ?? this.stockDetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
