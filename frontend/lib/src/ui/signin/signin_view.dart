import 'package:flutter/material.dart';
import 'package:jober/src/ui/signin/components/login_form.dart';
import 'package:jober/src/ui/signin/components/login_screen_top_image.dart';
import 'package:jober/src/ui/signin/signin_viewmodel.dart';
import 'package:jober/src/ui/widgets/background.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);
  static const routeName = "/login";
  SignInViewModel _viewModel = SignInViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const LoginScreenTopImage(),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: LoginForm(viewModel: _viewModel),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
