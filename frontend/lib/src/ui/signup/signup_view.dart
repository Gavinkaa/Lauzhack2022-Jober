import 'package:flutter/material.dart';
import 'package:jober/src/ui/signup/components/sign_up_top_image.dart';
import 'package:jober/src/ui/signup/components/signup_form.dart';
import 'package:jober/src/ui/signup/singup_view_model.dart';
import 'package:jober/src/ui/widgets/background.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  static const routeName = "/signup";
  SignupViewModel _viewModel = SignupViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SignUpViewTopImage(),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SignUpForm(viewModel: _viewModel,),
                  ),
                  const Spacer(),
                ],
              ),
              // const SocalSignUp()
            ],
          ),
        ),
      ),
    );
  }
}
