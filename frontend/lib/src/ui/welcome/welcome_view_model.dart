import 'package:flutter/cupertino.dart';
import 'package:jober/src/ui/signin/signin_view.dart';
import 'package:jober/src/ui/signup/signup_view.dart';

class WelcomeViewModel {

  void goToLoginView(BuildContext context) {
    Navigator.pushNamed(context, SignInView.routeName);
  }

  void goToSignupView(BuildContext context) {
    Navigator.pushNamed(context, SignupView.routeName);
  }
}
