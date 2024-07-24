import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_tracker/features/currency_conversion/domain/usecases/get_currency_rates.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final GetCurrencyRates getCurrencyRates;

  CurrencyBloc(this.getCurrencyRates) : super(CurrencyInitial()) {
    on<FetchCurrencyRates>((event, emit) async {
      emit(CurrencyLoading());
      try {
        final rates = await getCurrencyRates.execute(event.baseCurrency);
        emit(CurrencyLoaded(rates));
      } catch (e) {
        emit(CurrencyError(e.toString()));
      }
    });
  }
}
