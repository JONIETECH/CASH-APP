import 'dart:convert';

import 'package:finance_tracker/features/notifications_events/data/datasources/event_local_data_source.dart';
import 'package:finance_tracker/features/notifications_events/data/models/event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventLocalDataSourceImpl implements EventLocalDataSource {
  final SharedPreferences sharedPreferences;

  EventLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> addEvent(EventModel event) async {
    final currentEvents = await getAllEvents();
    currentEvents.add(event);
    final jsonString =
        json.encode(currentEvents.map((event) => event.toJson()).toList());
    await sharedPreferences.setString('EVENTS', jsonString);
  }

  @override
  Future<List<EventModel>> getAllEvents() async {
    final jsonString = sharedPreferences.getString('EVENTS');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((jsonItem) => EventModel.fromJson(jsonItem)).toList();
    } else {
      return [];
    }
  }
}
