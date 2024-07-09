part of 'biometric_bloc.dart';

abstract class BiometricState extends Equatable {
  @override
  List<Object> get props => [];
}

class BiometricInitial extends BiometricState {}

class BiometricLoaded extends BiometricState {
  final bool status;

  BiometricLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

class BiometricUpdated extends BiometricState {
  final bool status;

  BiometricUpdated({required this.status});

  @override
  List<Object> get props => [status];
}

class BiometricAuthenticated extends BiometricState {
  final bool authenticated;

  BiometricAuthenticated({required this.authenticated});

  @override
  List<Object> get props => [authenticated];
}

class BiometricError extends BiometricState {
  final String message;

  BiometricError({required this.message});

  @override
  List<Object> get props => [message];
}
