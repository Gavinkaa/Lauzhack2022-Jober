import 'package:flutter/material.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/navigation/navigation_view.dart';
import 'package:more_widgets/more_widgets.dart';

class SignInViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository.getInstance();

  bool isConnected() {
    return _authRepository.user != null;
  }

  Future<void> signIn(String email, String password, BuildContext context) async {
    try {
      await _authRepository.signIn(email, password);
      Navigator.pushNamedAndRemoveUntil(context, NavigationView.routeName, (route) => false);
    } catch (e) {
      Dialogs.infoDialog(context: context, title: "Error", message: "An error occured while trying to sign in", buttonText: "OK");
    }

  }

  String? validateNotNull(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $field';
    }
    return null;
  }

  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}
