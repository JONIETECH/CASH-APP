part of 'currency_bloc.dart';

sealed class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}
class FetchCurrencyRates extends CurrencyEvent {
  final String baseCurrency;

  const FetchCurrencyRates(this.baseCurrency);

  @override
  List<Object> get props => [baseCurrency];
}