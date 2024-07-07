import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences sharedPreferences;
  ThemeBloc({required this.sharedPreferences})
      : super(const ThemeInitial(ThemeMode.system)) {
    on<ToggleTheme>(_onToggleTheme);
    on<LoadThemeStatus>(_onLoadThemeStatus);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    final currentTheme = (state as ThemeInitial).themeMode;
    final newTheme =
        currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    // Save the new theme mode to SharedPreferences
    await sharedPreferences.setBool('isDarkMode', newTheme == ThemeMode.dark);
    emit(ThemeInitial(newTheme));
  }

  void _onLoadThemeStatus(LoadThemeStatus event, Emitter<ThemeState> emit) {
    final isDarkMode = sharedPreferences.getBool('isDarkMode') ?? false;
    emit(ThemeInitial(isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }
}
