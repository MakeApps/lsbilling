import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:equatable/equatable.dart';
part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  InternetBloc() : super(const InternetState()) {
    on<CheckInternetConnectionEvent>(_onCheckInternetConnection);
    on<InternetGainedEvent>(_onInternetGained);
    on<InternetLostEvent>(_onInternetLost);

    // Monitor connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        add(InternetLostEvent());
      } else {
        add(InternetGainedEvent());
      }
    });
  }

  Future<void> _onCheckInternetConnection(
    CheckInternetConnectionEvent event,
    Emitter<InternetState> emit,
  ) async {
    emit(state.copyWith(status: InternetStatus.internetLoading));

    try {
      final result = await _connectivity.checkConnectivity();

      if (result == ConnectivityResult.none) {
        emit(state.copyWith(
          status: InternetStatus.internetDisconnected,
          message: "No internet connection",
        ));
      } else {
        emit(state.copyWith(
          status: InternetStatus.internetConnected,
          message: "Internet is connected",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: InternetStatus.internetDisconnected,
        message: "Error checking internet: $e",
      ));
    }
  }

  void _onInternetGained(
    InternetGainedEvent event,
    Emitter<InternetState> emit,
  ) {
    emit(state.copyWith(
      status: InternetStatus.internetConnected,
      message: "Internet connection restored",
    ));
  
  }

  void _onInternetLost(
    InternetLostEvent event,
    Emitter<InternetState> emit,
  ) {
    emit(state.copyWith(
      status: InternetStatus.internetDisconnected,
      message: "No internet connection",
    ));
    Fluttertoast.showToast(
      msg: "No internet connection",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
