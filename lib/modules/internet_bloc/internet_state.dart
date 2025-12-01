part of 'internet_bloc.dart';

enum InternetStatus {
  internetInitial,
  internetLoading,
  internetConnected,
  internetDisconnected,
}

class InternetState extends Equatable {
  final InternetStatus status;
  final String? message;

  const InternetState({
    this.status = InternetStatus.internetInitial,
    this.message,
  });

  InternetState copyWith({
    InternetStatus? status,
    String? message,
  }) {
    return InternetState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
