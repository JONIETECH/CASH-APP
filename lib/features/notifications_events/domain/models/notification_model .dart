class NotificationModel {
  final int id;
  final String title;
  final String body;
  final DateTime scheduledDate;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledDate,
  });
}
