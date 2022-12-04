import 'package:flutter/material.dart';
import 'package:jober/src/models/data/user_profile.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/welcome/welcome_view.dart';

class ProfileViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository.getInstance();

  Future<void> signUp(String email, String password) async {
    await _authRepository.signUp(email, password);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await _authRepository.signIn(email, password);
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeView.routeName, (route) => false);
    await _authRepository.signOut();
    notifyListeners();
  }

  // NEW VERSION

  bool _editMode = false;

  String get userFirstName => _authRepository.userProfile!.firstName;

  String get userLastName => _authRepository.userProfile!.lastName;

  bool get editMode => _editMode;

  // void getUser() {
  //   final userProfile = _authRepository.getUser();

  //   if (_userProfile != userProfile) {
  //     _userProfile = userProfile;
  //     notifyListeners();
  //   }
  // }

  set userFirstName(String firstName) {
    _authRepository.userProfile!.firstName = firstName;
    //TODO: update database
    notifyListeners();
  }

  set userLastName(String lastName) {
    _authRepository.userProfile!.lastName = lastName;
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

      _authRepository.pushChanges();

      toggleEditMode();
    }
  }

  void dougyStyle() async {
    await _authRepository.dougyStyle();
  }
}
