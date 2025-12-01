import 'package:equatable/equatable.dart';

class ProductResponse extends Equatable {
  final int allStock;
  final List<ProductModel> products;
  final int totalInStock;
  final int totalMaxSellCount;
  final int totalOutOfStock;

  const ProductResponse({
    required this.allStock,
    required this.products,
    required this.totalInStock,
    required this.totalMaxSellCount,
    required this.totalOutOfStock,
  });
  @override
  List<Object?> get props => [
        allStock,
        products,
        totalInStock,
        totalMaxSellCount,
        totalOutOfStock,
      ];
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      allStock: json["all_stock"] ?? 0,
      products: (json["products"] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
          [],
      totalInStock: json["total_in_stock"] ?? 0,
      totalMaxSellCount: json["total_max_sell_count"] ?? 0,
      totalOutOfStock: json["total_out_of_stock"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "all_stock": allStock,
      "products": products.map((e) => e.toJson()).toList(),
      "total_in_stock": totalInStock,
      "total_max_sell_count": totalMaxSellCount,
      "total_out_of_stock": totalOutOfStock,
    };
  }
}

class ProductModel extends Equatable {
  final int? id;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final String? description;
  final String? hsnCode;
  final String? manufactured;
  final double? purchasePrice;
  final double? salesPrice;
  final String? sparetPartCat;
  final String? sparePartCode;
  final String? sparePartName;
  final String? sparePartGst;
  final double? stockQuantity;
  final String? tax;
  final String? unitType;
  final String? updatedAt;
  final String? tag;
  final double? maxSellCount;
  final int? timestamp;
  final String? sparePartCodeDescription;

  const ProductModel({
    this.id,
    this.createdAtDate,
    this.createdAtTime,
    this.deletedAt,
    this.description,
    this.hsnCode,
    this.manufactured,
    this.purchasePrice,
    this.salesPrice,
    this.sparetPartCat,
    this.sparePartCode,
    this.sparePartName,
    this.sparePartGst,
    this.stockQuantity,
    this.tax,
    this.unitType,
    this.updatedAt,
    this.tag,
    this.maxSellCount,
    this.timestamp,
    this.sparePartCodeDescription,
  });

  @override
  List<Object?> get props => [
        id!,
        createdAtDate!,
        createdAtTime!,
        deletedAt!,
        description!,
        hsnCode!,
        manufactured!,
        purchasePrice!,
        salesPrice!,
        sparetPartCat!,
        sparePartCode!,
        sparePartGst!,
        sparePartName!,
        stockQuantity!,
        tax!,
        unitType!,
        updatedAt!,
        tag!,
        maxSellCount,
        timestamp!,
        sparePartCodeDescription!,
      ];
  ProductModel copyWith({
    int? id,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    String? description,
    String? hsnCode,
    String? manufactured,
    double? purchasePrice,
    double? salesPrice,
    String? sparetPartCat,
    String? sparePartCode,
    String? sparePartName,
    double? stockQuantity,
    String? sparePartGst,
    String? tax,
    String? unitType,
    String? updatedAt,
    String? tag,
    double? maxSellCount,
    int? timestamp,
    String? sparePartCodeDescription,
  }) {
    ProductModel productModel = ProductModel(
      id: id ?? this.id,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      deletedAt: deletedAt ?? this.deletedAt,
      description: description ?? this.description,
      hsnCode: hsnCode ?? this.hsnCode,
      manufactured: manufactured ?? this.manufactured,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salesPrice: salesPrice ?? this.salesPrice,
      sparetPartCat: sparetPartCat ?? this.sparetPartCat,
      sparePartGst: sparePartGst ?? this.sparePartGst,
      sparePartCode: sparePartCode ?? this.sparePartCode,
      sparePartName: sparePartName ?? this.sparePartName,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      tax: tax ?? this.tax,
      unitType: unitType ?? this.unitType,
      updatedAt: updatedAt ?? this.updatedAt,
      tag: tag ?? this.tag,
      maxSellCount: maxSellCount ?? this.maxSellCount,
      timestamp: timestamp ?? this.timestamp,
      sparePartCodeDescription:
          sparePartCodeDescription ?? this.sparePartCodeDescription,
    );
    return productModel;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? "",
      createdAtTime: json['created_at_time'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      description: json['description'] ?? "",
      hsnCode: json['hsn_code'] ?? "",
      manufactured: json['manufactured'] ?? "",
      purchasePrice: json['purchase_price'] ?? 0.0,
      salesPrice: json['sales_price'] ?? 0.0,
      sparetPartCat: json['spare_part_cat'] ?? "",
      sparePartGst: json['product_gst'] ?? "",
      sparePartCode: json['spare_part_code'] ?? "",
      sparePartName: json['spare_part_name'] ?? "",
      stockQuantity: json['stock_quantity'] ?? 0.0,
      tax: json['tax'] ?? '',
      unitType: json['unit_type'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      tag: json['tag'] ?? "[]",
      maxSellCount: json['max_sell_count']?.toDouble(),
      timestamp: json['timestamp'] ?? 0,
      sparePartCodeDescription: json['spare_part_code_description'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "created_at_date": createdAtDate,
      "created_at_time": createdAtTime,
      "deleted_at": deletedAt,
      "description": description,
      "hsn_code": hsnCode,
      "id": id,
      "manufactured": manufactured,
      "purchase_price": purchasePrice,
      "sales_price": salesPrice,
      "spare_part_cat": sparetPartCat,
      "spare_part_code": sparePartCode,
      "product_gst": sparePartGst,
      "spare_part_name": sparePartName,
      "stock_quantity": stockQuantity,
      "tax": tax,
      "unit_type": unitType,
      "tag": tag,
      "max_sell_count": maxSellCount,
      "timestamp": timestamp,
      "updated_at": updatedAt,
    };
  }
}
