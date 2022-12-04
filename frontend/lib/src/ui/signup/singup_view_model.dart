import 'package:flutter/cupertino.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/signin/signin_view.dart';
import 'package:more_widgets/more_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpViewModel {
  late AuthRepository _authRepository;

  SignUpViewModel() {
    _authRepository = AuthRepository.getInstance();
  }

  Future<void> signup({required String email, required String password, required BuildContext context}) async {
    await _authRepository.signUp(email, password);
    Dialogs.infoDialog(context: context, title: AppLocalizations.of(context)!.verifyYourEmail,
        message: AppLocalizations.of(context)!.verifyYourEmailText,
        buttonText: AppLocalizations.of(context)!.ok.toUpperCase(), onPressed: () {
          Navigator.pushReplacementNamed(context, SignInView.routeName);
        });

  }

  String? validateNotNull(String? value, String field, BuildContext context) {
    if (value == null || value.isEmpty) {
      return '${AppLocalizations.of(context)!.pleaseEnterYour} $field';
    }
    return null;
  }

  void navigateToSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, SignInView.routeName);
  }

  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}
