import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/notifications_events/data/datasources/event_local_data_source.dart';
import 'package:finance_tracker/features/notifications_events/data/models/event_model.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/event.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/event_repository.dart';
import 'package:fpdart/fpdart.dart';

class EventRepositoryImpl implements EventRepository {
  final EventLocalDataSource localDataSource;
  EventRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addEvent(Event event) async {
    try {
      final eventModel = EventModel(
          id: event.id, title: event.title, date: event.date, type: event.type);
      await localDataSource.addEvent(eventModel);
      return const Right(null);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    try {
      final events = await localDataSource.getAllEvents();
      return Right(events);
    } on CacheFailure {
      return left(CacheFailure());
    }
  }
}
