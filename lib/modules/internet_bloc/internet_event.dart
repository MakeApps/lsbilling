part of 'internet_bloc.dart';

class InternetLostEvent extends InternetEvent {}

class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class CheckInternetConnectionEvent extends InternetEvent {}

class InternetGainedEvent extends InternetEvent {}
