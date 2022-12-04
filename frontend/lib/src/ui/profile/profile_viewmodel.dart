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

  // NEW VERSION

  bool _editMode = false;

  String get userFirstName => _userProfile!.firstName;

  String get userLastName => _userProfile!.lastName;

  bool get editMode => _editMode;

  void getUser() {
    final userProfile = _authRepository.getUser();

    if (_userProfile != userProfile) {
      _userProfile = userProfile;
      notifyListeners();
    }
  }

  set userFirstName(String firstName) {
    _userProfile!.firstName = firstName;
    //TODO: update database
    notifyListeners();
  }

  set userLastName(String lastName) {
    _userProfile!.lastName = lastName;
    //TODO: update database
    notifyListeners();
  }

  void toggleEditMode() {
    _editMode = !_editMode;
    notifyListeners();
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  void validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      toggleEditMode();
    }
  }
}
