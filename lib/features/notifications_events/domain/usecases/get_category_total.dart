import '../repositories/financial_repository.dart';

class GetCategoryTotal {
  final FinancialRepository repository;

  GetCategoryTotal(this.repository);

  double execute(String category) {
    return repository.getTotalByCategory(category);
  }
}
