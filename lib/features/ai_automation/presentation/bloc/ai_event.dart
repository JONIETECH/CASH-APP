part of 'ai_bloc.dart';

abstract class AiEvent extends Equatable {
  const AiEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends AiEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object> get props => [message];
}

class SendBatchMessages extends AiEvent {
  final List<String> messages;

  const SendBatchMessages(this.messages);

  @override
  List<Object> get props => [messages];
}
