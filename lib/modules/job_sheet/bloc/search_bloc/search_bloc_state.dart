part of 'search_bloc_bloc.dart';

enum SearchStatus { initial, loading, success, updating, failure }

enum VendorSearchStatus { initial, loading, success, updating, failure }

// ignore: must_be_immutable
class SearchBlocState extends Equatable {
  SearchStatus? status;
  VendorSearchStatus? vendorStatus;
  List<StockVendorModel>? vendorList;
  List<VehicleModel>? vehicleDetails;
  List<CustomerModel>? customerList;
  List<CustomerComplaintModel>? customerComplaintList;
  List<EstimateListingModel>? estimateList;
  SearchBlocState(
      {this.status = SearchStatus.initial,
      this.vendorStatus = VendorSearchStatus.initial,
      this.vehicleDetails = const [],
      this.customerList = const [],
      this.customerComplaintList = const [],
      this.estimateList = const [],
      this.vendorList = const [],
  });

  @override
  List<Object> get props => [
        status!,
        vendorStatus!,
        vehicleDetails!,
        customerList!,
        customerComplaintList!,
        estimateList!,
        vendorList!,
      ];

  SearchBlocState copyWith(
      {SearchStatus? status,
      VendorSearchStatus? vendorStatus,
      List<VehicleModel>? vehicleDetails,
      List<CustomerModel>? customerList,
      List<CustomerComplaintModel>? customerComplaintList,
      List<EstimateListingModel>? estimateList,
        List<StockVendorModel>? vendorList}) {
    return SearchBlocState(
        status: status ?? this.status,
        vendorStatus: vendorStatus ?? this.vendorStatus,
        vehicleDetails: vehicleDetails ?? this.vehicleDetails,
        customerList: customerList ?? this.customerList,
        customerComplaintList:
            customerComplaintList ?? this.customerComplaintList,
        estimateList: estimateList ?? this.estimateList,
        vendorList: vendorList??this.vendorList
        );
  }
}
