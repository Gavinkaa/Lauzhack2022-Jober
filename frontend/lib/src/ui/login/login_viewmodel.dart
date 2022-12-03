import 'package:flutter/material.dart';
import 'package:jober/src/models/data/user_profile.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository.getInstance();

  bool isConnected() {
    return _authRepository.user != null;
  }

  Future<void> signUp(String email, String password) async {
    await _authRepository.signUp(email, password);
  }

  Future<void> signIn(String email, String password) async {
    await _authRepository.signIn(email, password);
  }
}
