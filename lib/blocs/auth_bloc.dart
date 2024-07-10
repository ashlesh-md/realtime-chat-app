import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromLength(32)));

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final loggedIn = prefs.getBool('loggedIn') ?? false;
      if (loggedIn) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    // Handling LoggedOut event
    on<LoggedOut>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', false);
      emit(AuthUnauthenticated());
    });

    // Handling SignUp event
    on<SignUp>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final usersString = prefs.getStringList('users') ?? [];
      final users = usersString.map((user) => jsonDecode(user)).toList();

      if (users.any((user) => user['username'] == event.username)) {
        emit(AuthError(message: 'Username already exists'));
      } else {
        users.add({
          'username': event.username,
          'password': _encryptPassword(event.password),
        });
        await prefs.setStringList(
          'users',
          users.map((user) => jsonEncode(user)).toList(),
        );
        await prefs.setBool('loggedIn', true);
        emit(AuthAuthenticated());
      }
    });

    // Handling Login event
    on<Login>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final usersString = prefs.getStringList('users') ?? [];
        final users = usersString.map((user) => jsonDecode(user)).toList();

        log(users.toString());

        final user = users.firstWhere(
          (user) => user['username'] == event.username,
          orElse: () => null,
        );

        if (user != null
            // && _decryptPassword(encrypt.Encrypted.fromBase64(user['password'])) == event.password
            ) {
          await prefs.setBool('loggedIn', true);
          emit(AuthAuthenticated());
        } else {
          emit(AuthError(message: 'Invalid Username or Password'));
          emit(AuthUnauthenticated());
        }
      } catch (e, stackTrace) {
        log('Error during login: $e', stackTrace: stackTrace);
        emit(AuthError(message: 'An unexpected error occurred'));
        emit(AuthUnauthenticated());
      }
    });
  }

  // Encrypt password
  String _encryptPassword(String password) {
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  // Decrypt password
  String _decryptPassword(encrypt.Encrypted encryptedPassword) {
    final decrypted = encrypter.decrypt(encryptedPassword, iv: iv);
    return decrypted;
  }
}
