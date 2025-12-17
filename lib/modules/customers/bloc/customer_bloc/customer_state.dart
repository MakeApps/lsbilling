part of 'customer_bloc.dart';

enum CustomerStatus {
  initial,
  loading,
  deleting,
  deleted,
  adding,
  added,
  success,
  failure,
}

class CustomerState extends Equatable {
  final CustomerStatus? customerStatus;
  final List<CustomerModel> customerInfoList;
  final int? lastTimestamp;
  final bool? hasReachedMax;
  final String? errorMessage;

  const CustomerState({
    this.customerStatus = CustomerStatus.initial,
    this.customerInfoList = const [],
    this.lastTimestamp,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        customerStatus!,
        customerInfoList,
        hasReachedMax!,
        errorMessage ?? '',
      ];
  CustomerState copyWith({
    CustomerStatus? customerStatus,
    List<CustomerModel>? customerInfoList,
    int? lastTimestamp,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return CustomerState(
      customerStatus: customerStatus ?? this.customerStatus,
      customerInfoList: customerInfoList ?? this.customerInfoList,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
