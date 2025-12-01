import 'package:equatable/equatable.dart';

class LabourModel extends Equatable {
  final int? id;
  final String? createdAt;
  final String? deletedAt;
  final String? labourName;
  final String? labourGst;
  final String? labourHsnCode;
  final double? labourRate; // Change to double
  final String? taskDescription;
  final String? updatedAt;

  const LabourModel({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.labourName,
    this.labourGst,
    this.labourHsnCode,
    this.labourRate, // Now accepts double
    this.taskDescription,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id!,
        createdAt!,
        deletedAt!,
        labourName!,
        labourGst!,
        labourHsnCode!,
        labourRate!, // Make sure labourRate is nullable double
        taskDescription!,
        updatedAt!,
      ];

  LabourModel copyWith({
    int? id,
    String? createdAt,
    String? deletedAt,
    String? labourName,
    String? labourGst,
    String? labourHsnCode,
    double? labourRate, // Update to double
    String? taskDescription,
    String? updatedAt,
  }) {
    return LabourModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      labourName: labourName ?? this.labourName,
      labourGst: labourGst ?? this.labourGst,
      labourHsnCode: labourHsnCode ?? this.labourHsnCode,
      labourRate: labourRate ?? this.labourRate, // Update to double
      taskDescription: taskDescription ?? this.taskDescription,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory LabourModel.fromJson(Map<String, dynamic> json) {
    return LabourModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? "",
      deletedAt: json['deleted_at'] ?? "",
      labourName: json['labour_name'] ?? "",
      labourGst: json['labour_gst'] ?? "",
      labourHsnCode: json['hsn_code'] ?? "",
      labourRate: _parseLabourRate(json['labour_rate']), // Handle parsing here
      taskDescription: json['task_description'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  // Helper method to parse labourRate to a double
  static double? _parseLabourRate(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      return value.toDouble(); // Convert int to double
    } else if (value is double) {
      return value; // Already a double, return as is
    } else {
      return null; // If the value is neither int nor double, return null
    }
  }

  @override
  String toString() =>
      '{id: $id, createdAt: $createdAt, deletedAt: $deletedAt, labourName: $labourName, labourRate: $labourRate, taskDescription: $taskDescription, updatedAt: $updatedAt,labourHsnCode:$labourHsnCode, labourGst: $labourGst}';
}
