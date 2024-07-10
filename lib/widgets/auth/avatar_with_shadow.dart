import 'package:flutter/material.dart';

/// The `AvatarWithShadow` class creates a circular avatar with a shadow effect and an icon inside it.
class AvatarWithShadow extends StatelessWidget {
  final IconData icon;

  const AvatarWithShadow({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.indigo,
        child: Icon(icon, color: Colors.white, size: 40),
      ),
    );
  }
}
