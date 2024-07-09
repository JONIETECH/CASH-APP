import 'package:finance_tracker/core/common/entities/user.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpWithGoogle {
  final AuthRepository authRepository;

  SignUpWithGoogle(this.authRepository);

  Future<Either<Failure, User>> call() async {
    return await authRepository.signUpWithGoogle();
  }
}
