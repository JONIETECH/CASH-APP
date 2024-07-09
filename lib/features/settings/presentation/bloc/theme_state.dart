part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {
  final ThemeMode themeMode;
  const ThemeInitial(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}
