import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc.dart';
import 'package:real_time_chat_app/screens/sign_up_screen.dart';
import 'package:real_time_chat_app/widgets/auth/auth_form.dart';
import 'package:real_time_chat_app/widgets/auth/avatar_with_shadow.dart';

/// The `LoginScreen` class in Dart represents a screen for user login with username and password,
/// utilizing a gradient background, authentication form, and navigation to sign up screen.
class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthAuthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logged In Successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }, builder: (context, state) {
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
                      buttonText: 'Login',
                      formTitle: 'Login with Username and Password',
                      onSubmit: (username, password) {
                        BlocProvider.of<AuthBloc>(context).add(
                          Login(username: username, password: password),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                    },
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
