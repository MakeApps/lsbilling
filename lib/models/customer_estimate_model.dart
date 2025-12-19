import 'package:equatable/equatable.dart';

class EstimateCustModel extends Equatable {
  final int? id;
  final String? fullName;
  final String? email;
  final String? mobileNumber;
  final int? estimateNumber;
  final String? estimateTotal;
  final String? tempDate;

  const EstimateCustModel({
    this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.estimateNumber,
    this.estimateTotal,
    this.tempDate,
  });
  @override
  List<Object?> get props => [
        id!,
        fullName!,
        email!,
        mobileNumber!,
        estimateNumber!,
        estimateTotal!,
        tempDate!,
      ];

  /// ---------- copyWith ----------
  EstimateCustModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? mobileNumber,
    int? estimateNumber,
    String? estimateTotal,
    String? tempDate,
  }) {
    EstimateCustModel estimateCustModel = EstimateCustModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      estimateNumber: estimateNumber ?? this.estimateNumber,
      estimateTotal: estimateTotal ?? this.estimateTotal,
      tempDate: tempDate ?? this.tempDate,
    );
    return estimateCustModel;
  }

  /// ---------- From JSON ----------
  factory EstimateCustModel.fromJson(Map<String, dynamic> json) {
    return EstimateCustModel(
      id: json['id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      estimateNumber: json['estimate_number'],
      estimateTotal: json['estimateTotal']?.toString(),
      tempDate: json['temp_date'] ?? '',
    );
  }

  /// ---------- Empty ----------
  static const empty = EstimateCustModel(
    id: 0,
    fullName: '',
    email: '',
    mobileNumber: '',
    estimateNumber: 0,
    estimateTotal: '0',
    tempDate: '',
  );

  @override
  String toString() =>
      '{id: $id,fullName: $fullName,email: $email,mobileNumber: $mobileNumber,estimateNumber: $estimateNumber,estimateTotal: $estimateTotal,tempDate: $tempDate}';
}
