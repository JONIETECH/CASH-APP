import 'package:finance_tracker/features/auth/domain/entities/user.dart';
import 'package:finance_tracker/features/profile_management/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUserProfile {
  final ProfileRepository profileRepository;

  GetUserProfile(this.profileRepository);

  Future<Either<String, List<User>>> call() async {
    return profileRepository.getUserProfile();
  }
}
