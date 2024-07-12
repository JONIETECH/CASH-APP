import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_tracker/core/error/failure.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/features/notifications_events/domain/entities/balance.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/get_balance.dart';
import 'package:finance_tracker/features/notifications_events/domain/usecases/update_balance.dart';
import 'package:finance_tracker/core/utils/notification_helper.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final GetBalance getBalance;
  final UpdateBalance updateBalance;

  BalanceBloc({
    required this.getBalance,
    required this.updateBalance,
  }) : super(BalanceInitial()) {
    on<LoadBalance>(_onLoadBalance);
    on<ModifyBalance>(_onModifyBalance);
    on<CheckBalanceEvent>(_onCheckBalanceEvent);
  }

  void _onLoadBalance(LoadBalance event, Emitter<BalanceState> emit) async {
    emit(BalanceLoading());
    final failureOrBalance = await getBalance(NoParams());
    emit(failureOrBalance.fold(
      (failure) => BalanceError(message: _mapFailureToMessage(failure)),
      (balance) => BalanceLoaded(balance: balance),
    ));
  }

  void _onModifyBalance(ModifyBalance event, Emitter<BalanceState> emit) async {
    emit(BalanceLoading());
    final failureOrSuccess = await updateBalance(event.balance);
    emit(failureOrSuccess.fold(
      (failure) => BalanceError(message: _mapFailureToMessage(failure)),
      (_) => BalanceUpdated(),
    ));
  }

 void _onCheckBalanceEvent(CheckBalanceEvent event, Emitter<BalanceState> emit) async {
  emit(BalanceLoading());
  final failureOrBalance = await getBalance(NoParams());
  failureOrBalance.fold(
    (failure) => emit(BalanceError(message: _mapFailureToMessage(failure))),
    (balance) async {
      if (balance.amount <= event.threshold) {
        await NotificationHelper.scheduleNotification(
          id: DateTime.now().millisecondsSinceEpoch,
          title: 'Balance Alert',
          body: 'Your balance has fallen below \$${event.threshold}',
          scheduledDate: DateTime.now(),
        );
      }
      emit(BalanceLoaded(balance: balance));
    },
  );
}


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
