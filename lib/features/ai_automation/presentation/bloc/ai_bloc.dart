import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_tracker/features/ai_automation/data/api_service.dart';

part 'ai_event.dart';
part 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  final ApiService apiService;

  AiBloc({required this.apiService}) : super(AiInitial()) {
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<AiState> emit) async {
    emit(AiLoading());
    try {
      final response = await apiService.sendMessage(event.message);
      emit(AiSuccess(response));
    } catch (e) {
      emit(AiFailure(e.toString()));
    }
  }

  Future<void> _onSendBatchMessages(List<String> messages, Emitter<AiState> emit) async {
    emit(AiLoading());
    try {
      final responses = await apiService.sendBatchMessages(messages);
      emit(AiBatchSuccess(responses));
    } catch (e) {
      emit(AiFailure(e.toString()));
    }
  }
}
