import 'package:flutter/material.dart';
import 'package:jober/src/ui/login/login_view.dart';
import 'package:jober/src/ui/theme/app_colors.dart';
import 'package:jober/src/ui/widgets/already_have_an_account_acheck.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Theme.of(context).extension<AppColors>()!.primaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Theme.of(context).extension<AppColors>()!.primaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Hero(
            tag: "signup_btn",
            transitionOnUserGestures: true,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Sign Up".toUpperCase()),
            ),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginView();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
