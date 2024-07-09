part of 'reset_bloc.dart';

sealed class ResetState extends Equatable {
  const ResetState();

  @override
  List<Object> get props => [];
}

final class ResetInitial extends ResetState {}

final class ResetAppLoading extends ResetState {}

final class ResetAppSuccess extends ResetState {}

class ResetAppError extends ResetState {
  final String message;
  const ResetAppError(this.message);

  @override
  List<Object> get props => [message];
}
