import 'package:equatable/equatable.dart';

class StockParams extends Equatable {
  final String direction;
  final String search;
  final String filter;
  final int? timestamp;
  final String? storageLocation;

  const StockParams({
    this.direction = "down",
    this.search = "",
    this.filter = "in_stock",
    this.timestamp,
    this.storageLocation,
  });

  factory StockParams.empty() {
    return const StockParams();
  }

  StockParams copyWith({
    String? direction,
    String? search,
    String? filter,
    int? timestamp,
    String? storageLocation,
  }) {
    return StockParams(
      direction: direction ?? this.direction,
      search: search ?? this.search,
      filter: filter ?? this.filter,
      timestamp: timestamp ?? this.timestamp,
      storageLocation: storageLocation ?? this.storageLocation,
    );
  }

  Map<String, dynamic> toQueryParams() {
    return {
      "direction": direction,
      "search": search,
      "filter": filter,
      if (timestamp != null) "timestamp": timestamp,
      if (storageLocation != null) "storage_location": storageLocation,
    };
  }

  @override
  List<Object?> get props =>
      [direction, search, filter, timestamp, storageLocation];

  @override
  String toString() {
    return "StockParams(direction: $direction, search: $search, filter: $filter,timestamp:$timestamp, storageLocation: $storageLocation)";
  }
}
