part of 'stock_bloc.dart';

sealed class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class FetchStockList extends StockEvent {
  final int? timestamp;
  final String? search;
  final String? filter;
  final String? storageLocation;
  final StockStatus? status;

  const FetchStockList({
    this.timestamp,
    this.search,
    this.filter = 'in_stock', // Default filter
    this.storageLocation,
    this.status,
  });
}

class FilterItems extends StockEvent {
  final StockParams filters;
  const FilterItems(this.filters);
}

class CreateAddNewStock extends StockEvent {
  final Map<String, dynamic>? formData;
  const CreateAddNewStock({this.formData});
}

class DeleteStockRecord extends StockEvent {
  final String id;
  const DeleteStockRecord({required this.id});
}
