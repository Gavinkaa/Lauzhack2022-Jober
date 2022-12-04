import 'package:flutter/material.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/navigation/navigation_view.dart';
import 'package:jober/src/ui/signup/signup_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      Dialogs.infoDialog(context: context, title: AppLocalizations.of(context)!.error,
          message: AppLocalizations.of(context)!.errorWhenSignIn,
          buttonText: AppLocalizations.of(context)!.ok.toUpperCase());
    }

  }

  String? validateNotNull(String? value, String field, BuildContext context) {
    if (value == null || value.isEmpty) {
      return '${AppLocalizations.of(context)!.pleaseEnterYour} $field';
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

  void navigateToSignUp(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignUpView.routeName);
  }
}
