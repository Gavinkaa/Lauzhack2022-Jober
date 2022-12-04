import 'package:flutter/material.dart';
import 'package:jober/src/ui/signin/signin_viewmodel.dart';
import 'package:jober/src/ui/signup/signup_view.dart';
import 'package:jober/src/ui/theme/app_colors.dart';
import 'package:jober/src/ui/widgets/already_have_an_account_acheck.dart';


class LoginForm extends StatelessWidget {
  SignInViewModel viewModel;
  LoginForm({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  String email = "", password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Theme.of(context).extension<AppColors>()!.primaryColor,
            onSaved: (email) {this.email = email!;},
            validator: (val) => viewModel.validateNotNull(val, 'email'),
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              onSaved: (password) {this.password = password!;},
              cursorColor: Theme.of(context).extension<AppColors>()!.primaryColor,
              validator: (val) => viewModel.validateNotNull(val, 'password'),
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Hero(
            tag: "login_btn",
            transitionOnUserGestures: true,
            child: ElevatedButton(
              onPressed: () {
                if (viewModel.validateForm(_formKey)) {
                  viewModel.signIn(email, password, context);
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignupView();
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
