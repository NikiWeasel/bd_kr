part of 'user_auth_bloc.dart';

@immutable
sealed class UserAuthState {}

final class UserAuthInitial extends UserAuthState {}

class UserAuthLoading extends UserAuthState {}

class UserAuthLoaded extends UserAuthState {
  final User user;

  UserAuthLoaded({required this.user});
}

class UserAuthError extends UserAuthState {
  final String errorMessage;

  UserAuthError({required this.errorMessage});
}