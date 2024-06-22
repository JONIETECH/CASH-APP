import 'package:fpdart/fpdart.dart';
import 'package:new_blogger/core/error/failure.dart';
import 'package:new_blogger/core/usecase/usecase.dart';
import 'package:new_blogger/core/common/entities/user.dart';
import 'package:new_blogger/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
