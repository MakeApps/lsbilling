part of 'vendor_bloc.dart';

enum VendorStatus {
  initial,
  loading,
  deleting,
  deleted,
  adding,
  added,
  success,
  failure,
}

class VendorState extends Equatable {
  final VendorStatus? vendorStatus;
  final List<StockVendorModel> vendorList;
  final int? lastTimestamp;
  final bool? hasReachedMax;
  final String? errorMessage;
  final String? phoneError;

  const VendorState({
    this.vendorStatus = VendorStatus.initial,
    this.vendorList = const [],
    this.lastTimestamp,
    this.hasReachedMax = false,
    this.errorMessage,
    this.phoneError,
  });

  @override
  List<Object> get props => [
        vendorStatus!,
        vendorList,
        hasReachedMax!,
        errorMessage ?? '',
        phoneError ?? ''
      ];
  VendorState copyWith({
    VendorStatus? vendorStatus,
    List<StockVendorModel>? vendorList,
    int? lastTimestamp,
    bool? hasReachedMax,
    String? errorMessage,
    String? phoneError,
  }) {
    return VendorState(
      vendorStatus: vendorStatus ?? this.vendorStatus,
      vendorList: vendorList ?? this.vendorList,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      phoneError: phoneError ?? this.phoneError,
    );
  }
}
