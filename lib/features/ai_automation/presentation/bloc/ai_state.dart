part of 'ai_bloc.dart';

abstract class AiState extends Equatable {
  const AiState();

  @override
  List<Object> get props => [];
}

class AiInitial extends AiState {}

class AiLoading extends AiState {}

class AiSuccess extends AiState {
  final String response;
  const AiSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class AiBatchSuccess extends AiState {
  final List<String> responses;
  const AiBatchSuccess(this.responses);

  @override
  List<Object> get props => [responses];
}

class AiFailure extends AiState {
  final String error;
  const AiFailure(this.error);

  @override
  List<Object> get props => [error];
}
