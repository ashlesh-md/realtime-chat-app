import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc.dart';
import 'package:real_time_chat_app/screens/chat_screen.dart';
import 'package:real_time_chat_app/screens/login_screen.dart';

/// The `AuthScreen` class in Dart uses `BlocBuilder` to conditionally display either the `ChatScreen`
/// or `LoginScreen` based on the `AuthState`.
class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return ChatScreen();
        } else if (state is AuthUnauthenticated) {
          return LoginScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
