import 'package:finance_tracker/core/common/entities/user.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignInWithGoogle {
  final AuthRepository authRepository;

  SignInWithGoogle(this.authRepository);

  Future<Either<Failure, User>> call() async {
    return await authRepository.signInWithGoogle();
  }
}
