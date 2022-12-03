import 'package:flutter/material.dart';
import 'package:jober/src/models/data/user_profile.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  UserProfile? _userProfile;

  final _authRepository = AuthRepository.getInstance();

  bool isConnected() {
    // not connected if authRepository user is null
    if (_authRepository.user == null) {
      return false;
    } else {
      if (_userProfile == null) {
        getUser();
      }
      return true;
    }
  }

  Future<void> signUp(String email, String password) async {
    await _authRepository.signUp(email, password);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await _authRepository.signIn(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _userProfile = null;
    notifyListeners();
  }

  Future<void> getUser() async {
    _userProfile = await _authRepository.getUser();
    notifyListeners();
  }

  void getUserAs() {
    _authRepository.getUserAs();
  }
}
