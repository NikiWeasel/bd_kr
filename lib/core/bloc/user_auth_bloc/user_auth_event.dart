part of 'user_auth_bloc.dart';

@immutable
sealed class UserAuthEvent {}

class AuthUser extends UserAuthEvent {
  final User inputUser;

  AuthUser({required this.inputUser});
}

class RegisterUser extends UserAuthEvent {
  final User inputUser;

  RegisterUser({required this.inputUser});
}
