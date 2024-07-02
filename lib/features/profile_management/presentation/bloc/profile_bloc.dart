import 'package:bloc/bloc.dart';
import 'package:finance_tracker/features/profile_management/domain/usecases/get_user_profile.dart';
import 'package:meta/meta.dart';
import 'package:finance_tracker/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile _getUserProfile;

  ProfileBloc({
    required GetUserProfile getUserProfile,
  }) : _getUserProfile = getUserProfile,
       super(ProfileInitial()) {
    on<GetUserProfileEvent>(_onGetUserProfileEvent);
  }

  Future<void> _onGetUserProfileEvent(
    GetUserProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await _getUserProfile();
    result.fold(
      (failure) => emit(ProfileError(failure)),
      (users) => emit(ProfileLoaded(users)),
    );
  }
}
