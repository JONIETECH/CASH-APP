part of 'event_bloc.dart';

sealed class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

final class EventLoading extends EventState {}

final class EventLoaded extends EventState {
  final List<Event> events;

  const EventLoaded({required this.events});
}

final class EventCreated extends EventState {}

final class EventError extends EventState {
  final String message;

  const EventError({required this.message});
   @override
   List<Object> get props => [message];
}
