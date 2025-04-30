import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}


class AuthInputChanged extends AuthState {}

class AuthRememberMeChanged extends AuthState {
  final bool isRemembered;
  const AuthRememberMeChanged(this.isRemembered);

  @override
  List<Object> get props => [isRemembered];
}

class AuthAuthenticated extends AuthState {
  final String userId;
  const AuthAuthenticated(this.userId);

  @override
  List<Object> get props => [userId];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
