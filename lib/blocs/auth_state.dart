part of 'auth_bloc.dart';

@immutable

/// The above Dart code defines an abstract class named AuthState.
abstract class AuthState {}

/// The class AuthInitial is a subclass of AuthState in Dart.
class AuthInitial extends AuthState {}

/// The class AuthAuthenticated is a subclass of AuthState in Dart.
class AuthAuthenticated extends AuthState {}

/// The class `AuthUnauthenticated` is a subclass of `AuthState` in Dart.
class AuthUnauthenticated extends AuthState {}

/// This Dart class named AuthError likely represents a specific state related to authentication errors.
class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
