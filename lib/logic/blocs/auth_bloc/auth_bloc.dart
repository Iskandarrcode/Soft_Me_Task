import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:soft_me/data/repository/user_repository.dart';
part "auth_event.dart";
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository usersRepository})
      : _userRepository = usersRepository,
        super(InitialAuthState()) {
    on<RegisterEvent>(_registerEvent);
    on<LoginEvent>(_loginEvent);
    on<LogOutEvent>(_logOutEvent);
  }

  void _registerEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      final bool isLogged = await _userRepository.registerUser(
        event.name,
        event.surname,
        event.username,
        event.password,
      );

      emit(LoadedAuthState(isLogged: isLogged));
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }

  void _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      final bool isLogged =
          await _userRepository.loginUser(event.username, event.password);
      emit(LoadedAuthState(isLogged: isLogged));
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }

  void _logOutEvent(LogOutEvent event, Emitter emit) async {
    emit(LoadingAuthState());
    try {
      final bool isLogged = await _userRepository.logOut(event.context);
      emit(LoadedAuthState(isLogged: isLogged));
    } catch (e) {
      print("LogOut qilishda Error: $e");
      emit(ErrorAuthState(message: e.toString()));
    }
  }
}
