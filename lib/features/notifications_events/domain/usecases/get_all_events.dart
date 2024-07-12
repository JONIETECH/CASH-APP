import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/event.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/event_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllEvents implements UseCase<List<Event>, NoParams> {
  final EventRepository repository;
  GetAllEvents(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(NoParams params) async {
    return await repository.getAllEvents();
  }
}
