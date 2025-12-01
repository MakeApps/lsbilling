import 'package:equatable/equatable.dart';

class StockCatergoryModel extends Equatable {
  final String? categoryName;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final int? id;
  final String? updatedAt;

  const StockCatergoryModel({
    this.categoryName,
    this.createdAtDate,
    this.createdAtTime,
    this.deletedAt,
    this.id,
    this.updatedAt,
  });
  @override
  List<Object?> get props => [
        categoryName!,
        createdAtDate!,
        createdAtTime!,
        deletedAt!,
        id!,
        updatedAt!,
      ];

  /// CopyWith method
  StockCatergoryModel copyWith({
    String? categoryName,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    int? id,
    String? updatedAt,
  }) {
    StockCatergoryModel stockDetailsModel = StockCatergoryModel(
      categoryName: categoryName ?? this.categoryName,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return stockDetailsModel;
  }

  /// Factory method (from JSON)
  factory StockCatergoryModel.fromJson(Map<String, dynamic> json) {
    return StockCatergoryModel(
      categoryName: json['category_name'] ?? "",
      createdAtDate: json['created_at_date'] ?? '',
      createdAtTime: json['created_at_time'] ?? '',
      deletedAt: json['deleted_at'],
      id: json['id'] ?? 0,
      updatedAt: json['updated_at'] ?? '',
    );
  }

  static const empty = StockCatergoryModel(
    categoryName: "",
    createdAtDate: '',
    createdAtTime: '',
    deletedAt: null,
    id: 0,
    updatedAt: '',
  );

  @override
  String toString() =>
      '{ categoryName: $categoryName, createdAtDate: $createdAtDate, createdAtTime: $createdAtTime, '
      'deletedAt: $deletedAt, id: $id,updatedAt: $updatedAt}';
}
