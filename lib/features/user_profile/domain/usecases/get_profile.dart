import 'package:finance_tracker/features/auth/domain/entities/user.dart';
import 'package:finance_tracker/features/user_profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Exception, User>> call() async {
    return await repository.getProfile();
  }
}
