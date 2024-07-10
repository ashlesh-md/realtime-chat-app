import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/screens/splash_screen.dart';
import 'blocs/auth_bloc.dart';

/// The above function initializes a Flutter application with a BlocProvider for managing authentication
/// state and displays a MaterialApp with a SplashScreen as the initial screen.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AppStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat Application',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
