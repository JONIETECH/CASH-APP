part of 'currency_bloc.dart';

sealed class CurrencyState extends Equatable {
  const CurrencyState();
  
  @override
  List<Object> get props => [];
}

final class CurrencyInitial extends CurrencyState {}



class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final Map<String, double> rates;

  const CurrencyLoaded(this.rates);

  @override
  List<Object> get props => [rates];
}

class CurrencyError extends CurrencyState {
  final String message;

  const CurrencyError(this.message);

  @override
  List<Object> get props => [message];
}
