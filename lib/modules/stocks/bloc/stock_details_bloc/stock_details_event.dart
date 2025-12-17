part of 'stock_details_bloc.dart';

class StockDetailsEvent extends Equatable {
  const StockDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetStockDetails extends StockDetailsEvent {
  final String id;
  const GetStockDetails({required this.id});
}

class UpdateManageStock extends StockDetailsEvent {
  final Map<String, dynamic>? formData;
  final String? id;
  const UpdateManageStock({this.formData, this.id});
}

class UpdateEditStock extends StockDetailsEvent {
  final Map<String, dynamic>? formData;
  final String? id;
  const UpdateEditStock({this.formData, required this.id});
}
