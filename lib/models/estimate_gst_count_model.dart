import 'package:equatable/equatable.dart';
import 'package:local_shout_billing/models/estimate_listing_model.dart';

class EstimateGstCountModel extends Equatable {
  final int allEstimateCount;
  final List<EstimateListingModel> estimateList;
  final int gstEstimateCount;
  final int nonGstEstimateCount;

  const EstimateGstCountModel({
    required this.allEstimateCount,
    required this.estimateList,
    required this.gstEstimateCount,
    required this.nonGstEstimateCount,
  });

  static const empty = EstimateGstCountModel(
    allEstimateCount: 0,
    estimateList: [],
    gstEstimateCount: 0,
    nonGstEstimateCount: 0,
  );
  factory EstimateGstCountModel.fromJson(Map<String, dynamic> json) {
    final estimatedList =  !json.containsKey('Estimates') ? <EstimateListingModel>[] :
    (json['Estimates'] as List<dynamic>)
        .map((e) => EstimateListingModel.fromJson(e))
        .toList();
    return EstimateGstCountModel(
      allEstimateCount: json['all_estimate_count'],
      estimateList: estimatedList,
      gstEstimateCount: json['gst_estimate_count'],
      nonGstEstimateCount: json['non_gst_estimate_count'],
    );
  }
  // New copyWith method
  EstimateGstCountModel copyWith({
    int? allEstimateCount,
    List<EstimateListingModel>? estimateList,
    int? gstEstimateCount,
    int? nonGstEstimateCount,
  }) {
    return EstimateGstCountModel(
      allEstimateCount: allEstimateCount ?? this.allEstimateCount,
      estimateList: estimateList ?? this.estimateList,
      gstEstimateCount: gstEstimateCount ?? this.gstEstimateCount,
      nonGstEstimateCount: nonGstEstimateCount ?? this.nonGstEstimateCount,
    );
  }

  @override
  List<Object?> get props => [
        allEstimateCount,
        estimateList,
        gstEstimateCount,
        nonGstEstimateCount,
      ];
}
