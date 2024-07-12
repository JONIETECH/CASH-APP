import 'package:finance_tracker/features/notifications_events/data/models/event_model.dart';

abstract class EventLocalDataSource {
  Future<List<EventModel>> getAllEvents();
  Future<void> addEvent(EventModel event);
}

