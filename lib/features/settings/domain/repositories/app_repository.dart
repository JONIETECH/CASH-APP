import 'package:finance_tracker/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class ResetAppRepository {
  Future<Either<Failure, Unit>> resetAppData();
}
