import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/features/settings/domain/repositories/app_repository.dart';
import 'package:finance_tracker/features/finance/data/datasources/finance_local_data_source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetAppRepositoryImpl implements ResetAppRepository {
  final SharedPreferences sharedPreferences;
  final FinanceLocalDataSource financeLocalDataSource;

  ResetAppRepositoryImpl(this.sharedPreferences, this.financeLocalDataSource);

  @override
  Future<Either<Failure, Unit>> resetAppData() async {
    try {
      // Clear specific transactions data
      await financeLocalDataSource.clearTransactions();

      // Clear all SharedPreferences data
      await sharedPreferences.clear();

      return Right(unit);
    } catch (e) {
      print('Error resetting app data: $e');
      return Left(Failure(e.toString()));
    }
  }
}
