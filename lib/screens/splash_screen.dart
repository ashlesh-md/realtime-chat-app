import 'package:flutter/material.dart';
import 'package:real_time_chat_app/screens/auth_screen.dart';
import 'package:real_time_chat_app/widgets/auth/avatar_with_shadow.dart';

/// The `SplashScreen` class in Dart represents a screen with a gradient background and an avatar icon
/// that navigates to the authentication screen after a delay.
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthScreen();
  }

  _navigateToAuthScreen() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.indigo,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: AvatarWithShadow(
            icon: Icons.message,
          ),
        ),
      ),
    );
  }
}
