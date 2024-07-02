import 'package:finance_tracker/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProfileRepository {
  Future<Either<String,List< User>>> getUserProfile();
}
