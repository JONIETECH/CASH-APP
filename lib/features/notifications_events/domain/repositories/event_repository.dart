import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/event.dart';
import 'package:fpdart/fpdart.dart';

abstract class EventRepository {
  Future<Either<Failure,List<Event>>> getAllEvents();
  Future<Either<Failure, void>> addEvent (Event event);
}