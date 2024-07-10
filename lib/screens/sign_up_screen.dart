import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc.dart';
import 'package:real_time_chat_app/widgets/auth/auth_form.dart';
import 'package:real_time_chat_app/widgets/auth/avatar_with_shadow.dart';
import 'package:real_time_chat_app/screens/chat_screen.dart';

/// The `SignUpScreen` class in Dart represents a screen for user sign up with username and password,
/// including form validation and authentication handling.
class SignUpScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => ChatScreen(routeFromSignup: true)),
            );
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.indigo],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AvatarWithShadow(icon: Icons.message),
                    Container(
                      constraints: BoxConstraints(maxWidth: 600),
                      padding: const EdgeInsets.all(20.0),
                      child: AuthForm(
                        formKey: _formKey,
                        usernameController: _usernameController,
                        passwordController: _passwordController,
                        buttonText: 'Sign Up',
                        formTitle: 'Sign Up with Username and Password',
                        onSubmit: (username, password) {
                          BlocProvider.of<AuthBloc>(context).add(
                            SignUp(username: username, password: password),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Go back to login screen
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
