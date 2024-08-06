part of "auth_bloc.dart";

sealed class AuthState {}

final class InitialAuthState extends AuthState {}

final class LoadingAuthState extends AuthState {}

final class LoadedAuthState extends AuthState {
  final bool isLogged;

  LoadedAuthState({required this.isLogged});
}

final class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState({required this.message});
}
