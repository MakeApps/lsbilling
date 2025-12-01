part of 'search_mechanic_bloc.dart';

class SearchMechanicEvent extends Equatable {
  const SearchMechanicEvent();

  @override
  List<Object> get props => [];
}

class SearchMechanic extends SearchMechanicEvent {
  final String? searchKeyword;
  const SearchMechanic({this.searchKeyword});
}
