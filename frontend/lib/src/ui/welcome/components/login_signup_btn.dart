import 'package:flutter/material.dart';
import 'package:jober/src/ui/theme/app_colors.dart';
import 'package:jober/src/ui/welcome/welcome_view_model.dart';

class LoginAndSignupBtn extends StatelessWidget {
  final WelcomeViewModel viewModel;
  const LoginAndSignupBtn({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          transitionOnUserGestures: true,
          child: ElevatedButton(
            onPressed: () {
              viewModel.goToLoginView(context);
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Hero(
          tag: "signup_btn",
          transitionOnUserGestures: true,
          child: ElevatedButton(
            onPressed: () {
              viewModel.goToSignupView(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).extension<AppColors>()!.primaryLightColor, elevation: 0),
            child: Text(
              "Sign Up".toUpperCase(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
