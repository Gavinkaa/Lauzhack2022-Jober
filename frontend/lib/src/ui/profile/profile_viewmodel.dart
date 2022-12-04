import 'package:flutter/material.dart';
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
  String get userLocationCountry =>
      _authRepository.userProfile!.location['country'];
  int get userLocationPostalCode =>
      _authRepository.userProfile!.location['postalcode'];
  String get userLevel => _authRepository.userProfile!.level;
  List<String> get possibleSkillsList => _authRepository.userPossibleSkills!;
  List<String> get possibleUserLevelList => _authRepository.userPossibleLevels!;

  bool get editMode => _editMode;

  List<String> _skillsLocal = [];
  String _levelLocal = '';

  Future<void> ensureUserProfileDefined() async {
    if (_authRepository.userProfile == null) {
      await _authRepository.fetchUser();
      await _authRepository.getPossibleSkills();
      await _authRepository.getPossibleLevels();
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

  set userLocationCountry(String country) {
    _authRepository.userProfile!.location['country'] = country;
    notifyListeners();
  }

  set userLocationPostalCode(int postalCode) {
    _authRepository.userProfile!.location['postalcode'] = postalCode;
    notifyListeners();
  }

  // Because of the multi form
  set userSkills(List<String> skills) {
    _skillsLocal = skills;
  }

  void _userSetSkills(List<String> skills) {
    _authRepository.userProfile!.skills = skills;
    notifyListeners();
  }

  // Because of the multi form
  set userLevel(String level) {
    _levelLocal = level;
  }

  void _userSetLevel(String level) {
    _authRepository.userProfile!.level = level;
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

  String? validateLocationCountry(String? value) {
    if (value == null || value.isEmpty || value.length != 2) {
      return 'Please enter your country';
    }
    return null;
  }

  String? validateLocationPostalCode(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.length != 4 ||
        int.tryParse(value) == null) {
      return 'Please enter your postal code';
    }
    return null;
  }

  String? validateSkills(dynamic? value) {
    if (value == null || value?.isEmpty) {
      return 'Please enter your skills';
    }
    return null;
  }

  String? validateLevel(dynamic? value) {
    if (value == null || value?.isEmpty || value?.length != 1) {
      return 'Please enter your (ONE) level';
    }
    return null;
  }

  void validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      _userSetSkills(_skillsLocal);
      _userSetLevel(_levelLocal);

      _authRepository.pushChanges();

      toggleEditMode();
    }
  }
}
