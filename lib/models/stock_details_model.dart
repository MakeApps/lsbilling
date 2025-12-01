import 'dart:convert';

import 'package:equatable/equatable.dart';

class StockDetailsModel extends Equatable {
  final int? categoryId;
  final String? createdAtDate;
  final String? createdAtTime;
  final String? deletedAt;
  final String? description;
  final String? hsnCode;
  final int? id;
  final int? locationId;
  final String? manufactured;
  final double? purchasePrice;
  final double? salesPrice;
  final String? sparePartCat;
  final String? sparePartCode;
  final String? sparePartName;
  final double? stockQuantity;
  final String? storageLocation;
  final List<String>? tag;
  final String? tax;
  final List<Timeline>? timelines;
  final String? unitType;
  final String? updatedAt;

  const StockDetailsModel({
    this.categoryId,
    this.createdAtDate,
    this.createdAtTime,
    this.deletedAt,
    this.description,
    this.hsnCode,
    this.id,
    this.locationId,
    this.manufactured,
    this.purchasePrice,
    this.salesPrice,
    this.sparePartCat,
    this.sparePartCode,
    this.sparePartName,
    this.stockQuantity,
    this.storageLocation,
    this.tag,
    this.tax,
    this.timelines,
    this.unitType,
    this.updatedAt,
  });
  @override
  List<Object?> get props => [
        categoryId!,
        createdAtDate!,
        createdAtTime!,
        deletedAt!,
        description!,
        hsnCode!,
        id!,
        locationId!,
        manufactured!,
        purchasePrice!,
        salesPrice!,
        sparePartCat!,
        sparePartCode!,
        sparePartName!,
        stockQuantity!,
        storageLocation!,
        tag!,
        tax!,
        timelines!,
        unitType!,
        updatedAt!,
      ];

  /// CopyWith method
  StockDetailsModel copyWith({
    int? categoryId,
    String? createdAtDate,
    String? createdAtTime,
    String? deletedAt,
    String? description,
    String? hsnCode,
    int? id,
    int? locationId,
    String? manufactured,
    double? purchasePrice,
    double? salesPrice,
    String? sparePartCat,
    String? sparePartCode,
    String? sparePartName,
    double? stockQuantity,
    String? storageLocation,
    List<String>? tag,
    String? tax,
    List<Timeline>? timelines,
    String? unitType,
    String? updatedAt,
  }) {
    StockDetailsModel stockDetailsModel = StockDetailsModel(
      categoryId: categoryId ?? this.categoryId,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      deletedAt: deletedAt ?? this.deletedAt,
      description: description ?? this.description,
      hsnCode: hsnCode ?? this.hsnCode,
      id: id ?? this.id,
      locationId: locationId ?? this.locationId,
      manufactured: manufactured ?? this.manufactured,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salesPrice: salesPrice ?? this.salesPrice,
      sparePartCat: sparePartCat ?? this.sparePartCat,
      sparePartCode: sparePartCode ?? this.sparePartCode,
      sparePartName: sparePartName ?? this.sparePartName,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      storageLocation: storageLocation ?? this.storageLocation,
      tag: tag ?? this.tag,
      tax: tax ?? this.tax,
      timelines: timelines ?? this.timelines,
      unitType: unitType ?? this.unitType,
      updatedAt: updatedAt ?? this.updatedAt,
    );
    return stockDetailsModel;
  }

  /// Factory method (from JSON)
  factory StockDetailsModel.fromJson(Map<String, dynamic> json) {
    return StockDetailsModel(
      categoryId: json['category_id'] ?? 0,
      createdAtDate: json['created_at_date'] ?? '',
      createdAtTime: json['created_at_time'] ?? '',
      deletedAt: json['deleted_at'],
      description: json['description'] ?? '',
      hsnCode: json['hsn_code'] ?? '',
      id: json['id'] ?? 0,
      locationId: json['location_id'],
      manufactured: json['manufactured'] ?? '',
      purchasePrice: (json['purchase_price'] ?? 0).toDouble(),
      salesPrice: (json['sales_price'] ?? 0).toDouble(),
      sparePartCat: json['spare_part_cat'] ?? '',
      sparePartCode: json['spare_part_code'] ?? '',
      sparePartName: json['spare_part_name'] ?? '',
      stockQuantity: (json['stock_quantity'] ?? 0).toDouble(),
      storageLocation: json['storage_location'],
      tag: (json['tag'] != null)
          ? List<Map<String, dynamic>>.from(jsonDecode(json['tag']))
              .map((e) => e['tag'].toString())
              .toList()
          : [],
      tax: json['tax'] ?? '',
      timelines: (json['timelines'] as List<dynamic>? ?? [])
          .map((e) => Timeline.fromJson(e))
          .toList(),
      unitType: json['unit_type'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  static const empty = StockDetailsModel(
    categoryId: 0,
    createdAtDate: '',
    createdAtTime: '',
    deletedAt: null,
    description: '',
    hsnCode: '',
    id: 0,
    locationId: null,
    manufactured: '',
    purchasePrice: 0.0,
    salesPrice: 0.0,
    sparePartCat: '',
    sparePartCode: '',
    sparePartName: '',
    stockQuantity: 0.0,
    storageLocation: null,
    tag: [],
    tax: '',
    timelines: [],
    unitType: '',
    updatedAt: '',
  );

  @override
  String toString() =>
      '{ categoryId: $categoryId, createdAtDate: $createdAtDate, createdAtTime: $createdAtTime, '
      'deletedAt: $deletedAt, description: $description, hsnCode: $hsnCode, id: $id, '
      'locationId: $locationId, manufactured: $manufactured, purchasePrice: $purchasePrice, '
      'salesPrice: $salesPrice, sparePartCat: $sparePartCat, sparePartCode: $sparePartCode, '
      'sparePartName: $sparePartName, stockQuantity: $stockQuantity, storageLocation: $storageLocation, '
      'tag: $tag, tax: $tax, timelines: $timelines, unitType: $unitType, updatedAt: $updatedAt}';
}

class Timeline extends Equatable {
  final String createdAt;
  final String? deletedAt;
  final int productId;
  final int productQty;
  final String? remark;
  final String stockStatus;
  final int? timelineId;
  final String updatedAt;

  const Timeline({
    required this.createdAt,
    this.deletedAt,
    required this.productId,
    required this.productQty,
    this.remark,
    required this.stockStatus,
    this.timelineId,
    required this.updatedAt,
  });

  Timeline copyWith({
    String? createdAt,
    String? deletedAt,
    int? productId,
    int? productQty,
    String? remark,
    String? stockStatus,
    int? timelineId,
    String? updatedAt,
  }) {
    return Timeline(
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      productId: productId ?? this.productId,
      productQty: productQty ?? this.productQty,
      remark: remark ?? this.remark,
      stockStatus: stockStatus ?? this.stockStatus,
      timelineId: timelineId ?? this.timelineId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      createdAt: json['created_at'] ?? '',
      deletedAt: json['deleted_at'],
      productId: json['product_id'] ?? 0,
      productQty: json['product_qty'] ?? 0,
      remark: json['remark'],
      stockStatus: json['stock_status'] ?? '',
      timelineId: json['timeline_id'] ?? 0,
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'deleted_at': deletedAt,
      'product_id': productId,
      'product_qty': productQty,
      'remark': remark,
      'stock_status': stockStatus,
      'timeline_id': timelineId,
      'updated_at': updatedAt,
    };
  }

  static const empty = Timeline(
    createdAt: '',
    deletedAt: null,
    productId: 0,
    productQty: 0,
    remark: '',
    stockStatus: '',
    timelineId: 0,
    updatedAt: '',
  );

  @override
  List<Object?> get props => [
        createdAt,
        deletedAt,
        productId,
        productQty,
        remark,
        stockStatus,
        timelineId,
        updatedAt,
      ];
  @override
  String toString() =>
      '{ createdAt: $createdAt, deletedAt: $deletedAt, productId: $productId,productQty: $productQty, remark: $remark, stockStatus: $stockStatus,timelineId:$timelineId , updatedAt: $updatedAt}';
}
