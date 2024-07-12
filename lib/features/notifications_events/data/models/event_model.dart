import 'package:finance_tracker/features/notifications_events/domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required String id,
    required String title,
    required DateTime date,
    required String type,
  }) : super(id: id, title: title, date: date, type: type);
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      type: json['type'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'type': type,
    };
  }
}
