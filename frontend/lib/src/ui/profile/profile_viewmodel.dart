import 'package:flutter/material.dart';
import 'package:jober/src/models/data/user_profile.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/welcome/welcome_view.dart';

class ProfileViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository.getInstance();

  Future<void> signOut(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeView.routeName, (route) => false);
    await _authRepository.signOut();
    notifyListeners();
  }

  bool _editMode = false;

  String get userFirstName => _authRepository.userProfile!.firstName;
  String get userLastName => _authRepository.userProfile!.lastName;
  int get userAge => _authRepository.userProfile!.age;
  String get userEmail => _authRepository.userProfile!.email;
  int get userSalary => _authRepository.userProfile!.salary;
  List<String> get userSkills => _authRepository.userProfile!.skills;
  Map<String, dynamic> get userLocation =>
      _authRepository.userProfile!.location;
  String get userLevel => _authRepository.userProfile!.level;

  bool get editMode => _editMode;

  Future<void> ensureUserProfileDefined() async {
    if (_authRepository.userProfile == null) {
      await _authRepository.fetchUser();
    }
  }

  set userFirstName(String firstName) {
    _authRepository.userProfile!.firstName = firstName;
    notifyListeners();
  }

  set userLastName(String lastName) {
    _authRepository.userProfile!.lastName = lastName;
    notifyListeners();
  }

  set userAge(int age) {
    _authRepository.userProfile!.age = age;
    notifyListeners();
  }

  set userSalary(int salary) {
    _authRepository.userProfile!.salary = salary;
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

  String? validateAge(String? value) {
    if (value == null || value.isEmpty || int.tryParse(value) == null) {
      return 'Please enter your age';
    }
    return null;
  }

  String? validateSalary(String? value) {
    if (value == null || value.isEmpty || int.tryParse(value) == null) {
      return 'Please enter your salary';
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
}
