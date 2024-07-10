part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

/// The class `AppStarted` is an event in an authentication system.
class AppStarted extends AuthEvent {}

/// The `Login` class represents an authentication event with username and password fields in Dart.
class Login extends AuthEvent {
  final String username;
  final String password;

  Login({required this.username, required this.password});
}

/// The class LoggedOut is an AuthEvent in Dart.
class LoggedOut extends AuthEvent {}

/// The `SignUp` class represents an authentication event for signing up with a username and password in
/// Dart.
class SignUp extends AuthEvent {
  final String username;
  final String password;

  SignUp({required this.username, required this.password});
}
