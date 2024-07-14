part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {}
  


class AddNewEvent extends EventEvent {
  final Event event;
  const AddNewEvent({required this.event});

  @override
  List<Object> get props => [event];


}
