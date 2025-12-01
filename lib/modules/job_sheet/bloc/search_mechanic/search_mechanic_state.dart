part of 'search_mechanic_bloc.dart';

enum MechanicStatus { initial,loading, success, failure }

// ignore: must_be_immutable
class SearchMechanicState extends Equatable {
  MechanicStatus? status;
  List<MechanicModel>? mechanicList;

  SearchMechanicState(
      {this.status = MechanicStatus.initial, this.mechanicList = const []});

  @override
  List<Object> get props => [status!, mechanicList!];

  SearchMechanicState copyWith({
    MechanicStatus? status,
    List<MechanicModel>? mechanicList,
  }) {
    return SearchMechanicState(
      status: status ?? this.status,
      mechanicList: mechanicList ?? this.mechanicList,
    );
  }
}
