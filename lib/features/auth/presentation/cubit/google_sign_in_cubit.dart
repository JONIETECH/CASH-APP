import 'package:bloc/bloc.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleSignInCubit extends Cubit<AuthResponse?> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  GoogleSignInCubit(this._signInWithGoogleUseCase) : super(null);

  Future<void> signInWithGoogle() async {
    try {
      final authResponse = await _signInWithGoogleUseCase.call();
      emit(authResponse);
    } catch (e) {
      emit(null); // Handle the error appropriately
    }
  }
}