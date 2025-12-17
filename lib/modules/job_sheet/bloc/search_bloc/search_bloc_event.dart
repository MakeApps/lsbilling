part of 'search_bloc_bloc.dart';

class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();

  @override
  List<Object> get props => [];
}

class SearchCustomerComplent extends SearchBlocEvent {
  final String searchKeyword;
  const SearchCustomerComplent({required this.searchKeyword});
}

class SearchCustomerDetails extends SearchBlocEvent {
  final String searchKeyword;
  const SearchCustomerDetails({required this.searchKeyword});
}

class SearchVendor extends SearchBlocEvent {
  final String? searchKeyword;
  final VendorSearchStatus? status;
  const SearchVendor({this.searchKeyword, this.status});
}