import 'package:finance_tracker/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/sign_up_with_google.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance_tracker/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:finance_tracker/core/usecase/usecase.dart';
import 'package:finance_tracker/core/common/entities/user.dart';
import 'package:finance_tracker/features/auth/domain/usecases/current_user.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_login.dart';
import 'package:finance_tracker/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserSignOut _userSignOut;
  final SignInWithGoogle _signInWithGoogle;
  final SignUpWithGoogle _signUpWithGoogle;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserSignOut userSignOut,
    required SignInWithGoogle signInWithGoogle,
    required SignUpWithGoogle signUpWithGoogle,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _userSignOut = userSignOut,
        _signInWithGoogle = signInWithGoogle,
        _signUpWithGoogle = signUpWithGoogle,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthSignOut>(_onAuthSignOut);
    on<AuthSignInWithGoogle>(_onAuthSignInWithGoogle);
    on<AuthSignUpWithGoogle>(_onAuthSignUpWithGoogle);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(
        AuthFailure(l.message),
      ),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignUpWithGoogle(
    AuthSignUpWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _signInWithGoogle();
    res.fold(
      (failure) =>emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user,emit),
    );
  }
  void _onAuthSignInWithGoogle(
    AuthSignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _signInWithGoogle();
    res.fold(
      (failure) =>emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user,emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(
      AuthSuccess(user),
    );
  }

  void _onAuthSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    final res = await _userSignOut(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (_) => emit(AuthInitial()),
    );
  }
}
