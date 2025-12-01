import 'package:equatable/equatable.dart';

class SparePartModel extends Equatable {
  final String? createdAt;
  final String? deletedAt;
  final int? productId;
  final String? productName;
  final String? productPrice;
  final String? productQuantity;
  final String? productUnit;
  final String? productGst;
  final String? updatedAt;
  final String? hsnCode;
  final int? timestamp;
  const SparePartModel(
      {this.createdAt,
      this.deletedAt,
      this.productId,
      this.productName,
      this.productPrice,
      this.productQuantity,
      this.productGst,
      this.productUnit,
      this.updatedAt,
      this.hsnCode,
      this.timestamp});

  @override
  List<Object?> get props => [
        createdAt!,
        deletedAt!,
        productId!,
        productName!,
        productPrice!,
        productQuantity!,
        productGst!,
        productUnit!,
        updatedAt!,
        hsnCode!,
        timestamp!
      ];
  SparePartModel copyWith({
    String? createdAt,
    String? deletedAt,
    int? productId,
    String? productName,
    String? productPrice,
    String? productQuantity,
    String? productGst,
    String? productUnit,
    String? updatedAt,
    String? hsnCode,
    int? timestamp,
  }) {
    SparePartModel sparePartModel = SparePartModel(
        createdAt: createdAt ?? this.createdAt,
        deletedAt: deletedAt ?? this.deletedAt,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productPrice: productPrice ?? this.productPrice,
        productQuantity: productQuantity ?? this.productQuantity,
        productGst: productGst ?? this.productGst,
        productUnit: productUnit ?? this.productUnit,
        updatedAt: updatedAt ?? this.updatedAt,
        hsnCode: hsnCode ?? this.hsnCode,
        timestamp: timestamp ?? this.timestamp);
    return sparePartModel;
  }

  factory SparePartModel.fromJson(Map<String, dynamic> json) {
    return SparePartModel(
        createdAt: json['created_at'] ?? "",
        deletedAt: json['deleted_at'] ?? "",
        productId: json['product_id'] ?? 0,
        productName: json['product_name'] ?? "",
        productPrice: json['product_price'] ?? "",
        productQuantity: json['product_qty'] ?? "",
        productGst: json['product_gst'] ?? "",
        productUnit: json['product_unit'] ?? "",
        updatedAt: json['updated_at'] ?? "",
        hsnCode: json['hsn_code'] ?? "",
        timestamp: json['timestamp'] ?? "");
  }
  @override
  String toString() =>
      '{ createdAt:$createdAt,timestamp:$timestamp,deletedAt:$deletedAt,productId:$productId, productName:$productName,productPrice:$productPrice,productQuantity:$productQuantity,productUnit:$productUnit, updatedAt:$updatedAt,hsnCode:$hsnCode,productGst:$productGst}';
}
