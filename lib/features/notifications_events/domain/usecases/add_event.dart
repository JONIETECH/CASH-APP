import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/event.dart';
import 'package:finance_tracker/features/notifications_events/domain/repositories/event_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddEvent implements UseCase<void, Event> {
  final EventRepository repository;

  AddEvent(this.repository);

  @override
  Future<Either<Failure, void>> call(Event event) async {
    return await repository.addEvent(event);
  }
}
