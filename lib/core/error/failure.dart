class Failure {
  final String message;
  Failure([this.message = 'An unexpected error occured']);

}
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}