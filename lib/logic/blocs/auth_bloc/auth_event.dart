part of "auth_bloc.dart";

sealed class AuthEvents {}

final class RegisterEvent extends AuthEvents {
  final String name;
  final String surname;
  final String username;
  final String password;

  RegisterEvent({
    required this.name,
    required this.surname,
    required this.username,
    required this.password,
  });
}

final class LoginEvent extends AuthEvents {
  final String username;
  final String password;

  LoginEvent({
    required this.username,
    required this.password,
  });
}

final class LogOutEvent extends AuthEvents {
  final BuildContext context;
  LogOutEvent({required this.context});
}
