import 'package:flutter/material.dart';
import 'package:jober/src/ui/welcome/components/login_signup_btn.dart';
import 'package:jober/src/ui/welcome/components/welcome_image.dart';
import 'package:jober/src/ui/widgets/background.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Background(child: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WelcomeImage(),
            Row(
              children: const [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: LoginAndSignupBtn(),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      )
    ));
  }
}
