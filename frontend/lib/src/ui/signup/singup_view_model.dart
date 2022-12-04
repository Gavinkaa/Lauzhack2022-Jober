import 'package:flutter/cupertino.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/signin/signin_view.dart';
import 'package:more_widgets/more_widgets.dart';

class SignupViewModel {
  late AuthRepository _authRepository;

  SignupViewModel() {
    _authRepository = AuthRepository.getInstance();
  }

  Future<void> signup({required String email, required String password, required BuildContext context}) async {
    await _authRepository.signUp(email, password);
    Dialogs.infoDialog(context: context, title: "Verify your email", message: "You need to verify your email before you can login",
        buttonText: "OK", onPressed: () {
          Navigator.pushReplacementNamed(context, SignInView.routeName);
        });

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
