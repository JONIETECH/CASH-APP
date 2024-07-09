part of 'biometric_bloc.dart';

abstract class BiometricEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBiometricStatus extends BiometricEvent {}

class UpdateBiometricStatus extends BiometricEvent {
  final bool status;

  UpdateBiometricStatus({required this.status});

  @override
  List<Object> get props => [status];
}

class AuthenticateUser extends BiometricEvent {}
