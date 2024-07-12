import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final String type;

  const Event(
      {required this.id,
      required this.title,
      required this.date,
      required this.type});

  @override
  List<Object?> get props => [id,title,date,type];
}
