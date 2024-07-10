import 'package:flutter/material.dart';

/// The `AuthForm` class in Dart represents a customizable authentication form widget with username and
/// password fields.
typedef FormSubmitCallback = void Function(String username, String password);

class AuthForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final String buttonText;
  final String formTitle;
  final FormSubmitCallback onSubmit;

  const AuthForm({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
    required this.buttonText,
    required this.formTitle,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: usernameController,
            hintText: 'Enter your username',
            validator: (value) {
              if (value!.isEmpty) return 'Username cannot be empty';
              return null;
            },
          ),
          SizedBox(height: 10),
          _buildTextField(
            controller: passwordController,
            hintText: 'Enter your password',
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) return 'Password cannot be empty';
              if (value.length < 6)
                return 'Password must be at least 6 characters long';
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final username = usernameController.text;
                final password = passwordController.text;
                onSubmit(username, password);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.black.withOpacity(0.3),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
