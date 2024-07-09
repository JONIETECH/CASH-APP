import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/security/domain/usecases/authenticate.dart';
import 'package:finance_tracker/features/security/domain/usecases/get_biometric_status.dart';
import 'package:finance_tracker/features/security/domain/usecases/set_biometric_status.dart';

part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final GetBiometricStatus getBiometricStatus;
  final SetBiometricStatus setBiometricStatus;
  final Authenticate authenticate;

  BiometricBloc({
    required this.getBiometricStatus,
    required this.setBiometricStatus,
    required this.authenticate,
  }) : super(BiometricInitial()) {
    on<BiometricEvent>((event, emit) async {
      if (event is LoadBiometricStatus) {
        final result = await getBiometricStatus(NoParams());
        result.fold(
          (failure) => emit(BiometricError(message: _mapFailureToMessage(failure))),
          (status) => emit(BiometricLoaded(status: status.isEnabled)),
        );
      } else if (event is UpdateBiometricStatus) {
        final result = await setBiometricStatus(event.status);
        result.fold(
          (failure) => emit(BiometricError(message: _mapFailureToMessage(failure))),
          (_) => emit(BiometricUpdated(status: event.status)),
        );
      } else if (event is AuthenticateUser) {
        final result = await authenticate(NoParams());
        result.fold(
          (failure) => emit(BiometricError(message: _mapFailureToMessage(failure))),
          (authenticated) => emit(BiometricAuthenticated(authenticated: authenticated)),
        );
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
