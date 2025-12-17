part of 'vendor_details_bloc.dart';

enum GetVendorsDetailsStatus {
  initial,
  loading,
  updating,
  updated,
  adding,
  added,
  success,
  failure,
}

class VendorDetailsState extends Equatable {
  final GetVendorsDetailsStatus? vendorDetailsStatus;
  final VendorsDetailsModel? vendorDetailsList;

  const VendorDetailsState({
    this.vendorDetailsStatus = GetVendorsDetailsStatus.initial,
    this.vendorDetailsList = VendorsDetailsModel.empty,
  });

  @override
  List<Object> get props => [
        vendorDetailsStatus!,
        vendorDetailsList!,
      ];
  VendorDetailsState copyWith({
    GetVendorsDetailsStatus? vendorDetailsStatus,
    VendorsDetailsModel? vendorDetailsList,
  }) {
    return VendorDetailsState(
      vendorDetailsStatus: vendorDetailsStatus ?? this.vendorDetailsStatus,
      vendorDetailsList: vendorDetailsList ?? this.vendorDetailsList,
    );
  }
}
