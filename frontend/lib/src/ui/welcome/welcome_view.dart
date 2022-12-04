import 'package:flutter/material.dart';
import 'package:jober/src/ui/welcome/components/login_signup_btn.dart';
import 'package:jober/src/ui/welcome/components/welcome_image.dart';
import 'package:jober/src/ui/welcome/welcome_view_model.dart';
import 'package:jober/src/ui/widgets/background.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({Key? key}) : super(key: key);
  static const routeName = "/";
  final WelcomeViewModel _viewModel = WelcomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Background(child: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const WelcomeImage(),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: LoginAndSignupBtn(viewModel: _viewModel),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      )
    ));
  }
}
