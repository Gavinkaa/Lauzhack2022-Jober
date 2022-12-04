import 'package:flutter/material.dart';
import 'package:jober/src/ui/signup/components/sign_up_top_image.dart';
import 'package:jober/src/ui/signup/components/signup_form.dart';
import 'package:jober/src/ui/widgets/background.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);
  static const routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    return Background(child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SignUpViewTopImage(),
          Row(
            children: const [
              Spacer(),
              Expanded(
                flex: 8,
                child: SignUpForm(),
              ),
              Spacer(),
            ],
          ),
          // const SocalSignUp()
        ],
      ),
    ));
  }
}
