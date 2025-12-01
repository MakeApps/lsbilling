import 'dart:convert';
import 'package:equatable/equatable.dart';

class StockResponseModel extends Equatable {
  final int allStock;
  final List<ProductModel> products;
  final List<String> stockLocation;
  final int totalInStock;
  final int totalMaxSellCount;
  final int totalOutOfStock;

  const StockResponseModel({
    required this.allStock,
    required this.products,
    required this.stockLocation,
    required this.totalInStock,
    required this.totalMaxSellCount,
    required this.totalOutOfStock,
  });

  static const empty = StockResponseModel(
    allStock: 0,
    products: [],
    stockLocation: [],
    totalInStock: 0,
    totalMaxSellCount: 0,
    totalOutOfStock: 0,
  );
  factory StockResponseModel.fromJson(Map<String, dynamic> json) {
    List<ProductModel> parsedProducts = [];

    if (json['products'] is List) {
      parsedProducts = (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } else {
      parsedProducts = [];
    }

    return StockResponseModel(
      allStock: json['all_stock'] ?? 0,
      products: parsedProducts,
      stockLocation: (json['stock_location'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      totalInStock: json['total_in_stock'] ?? 0,
      totalMaxSellCount: json['total_max_sell_count'] ?? 0,
      totalOutOfStock: json['total_out_of_stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "all_stock": allStock,
        "products": products.map((e) => e.toJson()).toList(),
        "stock_location": stockLocation,
        "total_in_stock": totalInStock,
        "total_max_sell_count": totalMaxSellCount,
        "total_out_of_stock": totalOutOfStock,
      };
  // New copyWith method
  StockResponseModel copyWith({
    int? allStock,
    List<ProductModel>? products,
    List<String>? stockLocation,
    int? totalInStock,
    int? totalMaxSellCount,
    int? totalOutOfStock,
  }) {
    return StockResponseModel(
      allStock: allStock ?? this.allStock,
      products: products ?? this.products,
      stockLocation: stockLocation ?? this.stockLocation,
      totalInStock: totalInStock ?? this.totalInStock,
      totalMaxSellCount: totalMaxSellCount ?? this.totalMaxSellCount,
      totalOutOfStock: totalOutOfStock ?? this.totalOutOfStock,
    );
  }

  @override
  List<Object?> get props => [
        allStock,
        products,
        stockLocation,
        totalInStock,
        totalMaxSellCount,
        totalOutOfStock
      ];
}

class ProductModel extends Equatable {
  final String createdAtDate;
  final String createdAtTime;
  final String? deletedAt;
  final String description;
  final String hsnCode;
  final int id;
  final String manufactured;
  final int maxSellCount;
  final String productGst;
  final double purchasePrice;
  final double salesPrice;
  final String sparePartCat;
  final String sparePartCode;
  final String sparePartName;
  final double stockQuantity;
  final String storageLocation;
  final int storageLocationId;
  final List<String> tags;
  final int timestamp;
  final String unitType;
  final String updatedAt;

  const ProductModel({
    required this.createdAtDate,
    required this.createdAtTime,
    this.deletedAt,
    required this.description,
    required this.hsnCode,
    required this.id,
    required this.manufactured,
    required this.maxSellCount,
    required this.productGst,
    required this.purchasePrice,
    required this.salesPrice,
    required this.sparePartCat,
    required this.sparePartCode,
    required this.sparePartName,
    required this.stockQuantity,
    required this.storageLocation,
    required this.storageLocationId,
    required this.tags,
    required this.timestamp,
    required this.unitType,
    required this.updatedAt,
  });
  static const empty = ProductModel(
    createdAtDate: "",
    createdAtTime: "",
    deletedAt: null,
    description: "",
    hsnCode: "",
    id: 0,
    manufactured: "",
    maxSellCount: 0,
    productGst: "",
    purchasePrice: 0.0,
    salesPrice: 0.0,
    sparePartCat: "",
    sparePartCode: "",
    sparePartName: "",
    stockQuantity: 0.0,
    storageLocation: "",
    storageLocationId: 0,
    tags: [],
    timestamp: 0,
    unitType: "",
    updatedAt: "",
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      deletedAt: json['deleted_at'],
      description: json['description'] ?? "",
      hsnCode: json['hsn_code'] ?? "",
      id: json['id'] ?? 0,
      manufactured: json['manufactured'] ?? "",
      maxSellCount: json['max_sell_count'] ?? 0,
      productGst: json['product_gst'] ?? "",
      purchasePrice: (json['purchase_price'] as num?)?.toDouble() ?? 0.0,
      salesPrice: (json['sales_price'] as num?)?.toDouble() ?? 0.0,
      sparePartCat: json['spare_part_cat'] ?? "",
      sparePartCode: json['spare_part_code'] ?? "",
      sparePartName: json['spare_part_name'] ?? "",
      stockQuantity: (json['stock_quantity'] as num?)?.toDouble() ?? 0.0,
      storageLocation: json['storage_location'] ?? "",
      storageLocationId: json['storage_location_id'] ?? 0,
      tags: (json['tag'] != null)
          ? List<Map<String, dynamic>>.from(jsonDecode(json['tag']))
              .map((e) => e['tag'].toString())
              .toList()
          : [],
      timestamp: json['timestamp'] ?? 0,
      unitType: json['unit_type'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "created_at_date": createdAtDate,
        "created_at_time": createdAtTime,
        "deleted_at": deletedAt,
        "description": description,
        "hsn_code": hsnCode,
        "id": id,
        "manufactured": manufactured,
        "max_sell_count": maxSellCount,
        "product_gst": productGst,
        "purchase_price": purchasePrice,
        "sales_price": salesPrice,
        "spare_part_cat": sparePartCat,
        "spare_part_code": sparePartCode,
        "spare_part_name": sparePartName,
        "stock_quantity": stockQuantity,
        "storage_location": storageLocation,
        "storage_location_id": storageLocationId,
        "tag": tags.map((e) => {"tag": e}).toList(),
        "timestamp": timestamp,
        "unit_type": unitType,
        "updated_at": updatedAt,
      };

  @override
  List<Object?> get props => [
        createdAtDate,
        createdAtTime,
        deletedAt,
        description,
        hsnCode,
        id,
        manufactured,
        maxSellCount,
        productGst,
        purchasePrice,
        salesPrice,
        sparePartCat,
        sparePartCode,
        sparePartName,
        stockQuantity,
        storageLocation,
        storageLocationId,
        tags,
        timestamp,
        unitType,
        updatedAt,
      ];
}
