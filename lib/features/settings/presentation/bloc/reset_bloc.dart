// reset_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_tracker/features/settings/domain/usecases/reset_app_data_usecase.dart';

part 'reset_event.dart';
part 'reset_state.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {
  final ResetAppDataUsecase _resetAppDataUsecase;

  ResetBloc({required ResetAppDataUsecase resetAppDataUsecase})
      : _resetAppDataUsecase = resetAppDataUsecase,
        super(ResetInitial()) {
    on<ResetAppData>(_onResetAppData);
  }

  Future<void> _onResetAppData(
    ResetAppData event,
    Emitter<ResetState> emit,
  ) async {
    emit(ResetAppLoading());
    final result = await _resetAppDataUsecase();
    result.fold(
      (failure) => emit(ResetAppError(failure.message)),
      (_) => emit(ResetAppSuccess()),
    );
  }
}
