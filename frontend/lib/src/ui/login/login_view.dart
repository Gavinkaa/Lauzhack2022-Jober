import 'package:flutter/material.dart';
import 'package:jober/src/ui/login/components/login_form.dart';
import 'package:jober/src/ui/login/components/login_screen_top_image.dart';
import 'package:jober/src/ui/widgets/background.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

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
                children: const [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: LoginForm(),
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
