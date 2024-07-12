import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/core/utils/notification_helper.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/event.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/add_event.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_all_events.dart';
import 'package:flutter/material.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetAllEvents getAllEvents;
  final AddEvent addEvent;

  EventBloc({
    required this.getAllEvents,
    required this.addEvent,
  }) : super(EventInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<AddNewEvent>(_onCreateEvent);
  }

  void _onLoadEvents(LoadEvents event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final failureOrEvents = await getAllEvents(NoParams());
    emit(failureOrEvents.fold(
      (failure) => EventError(message: _mapFailureToMessage(failure)),
      (events) => EventLoaded(events: events),
    ));
  }

  void _onCreateEvent(AddNewEvent event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final failureOrSuccess = await addEvent(event.event);
    if (failureOrSuccess.isRight()) {
      final eventDate = event.event.date;
      final notificationId = UniqueKey().hashCode;

      // Schedule notification one day before the event
      await NotificationHelper.scheduleNotification(
        id: notificationId,
        title: 'Upcoming Event',
        body: 'Your event "${event.event.title}" is coming up tomorrow!',
        scheduledDate: eventDate.subtract(const Duration(days: 1)),
      );

      // Schedule notification on the event date
      await NotificationHelper.scheduleNotification(
        id: notificationId + 1,
        title: 'Event Today',
        body: 'Your event "${event.event.title}" is happening today!',
        scheduledDate: eventDate,
      );
    }
    emit(failureOrSuccess.fold(
      (failure) => EventError(message: _mapFailureToMessage(failure)),
      (_) => EventCreated(),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
