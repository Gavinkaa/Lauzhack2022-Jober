import 'package:flutter/material.dart';
import 'package:jober/src/ui/signin/signin_view.dart';
import 'package:jober/src/ui/signup/singup_view_model.dart';
import 'package:jober/src/ui/theme/app_colors.dart';
import 'package:jober/src/ui/widgets/already_have_an_account_acheck.dart';

class SignUpForm extends StatelessWidget {
  SignupViewModel viewModel;
  String email = "", password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  SignUpForm({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

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
              validator: (val) => viewModel.validateNotNull(val, 'password'),
              onSaved: (password) {this.password = password!;},
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
              onPressed: () {
                if (viewModel.validateForm(_formKey)) {
                  viewModel.signup(context: context, email: email, password: password);
                }
              },
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
                    return SignInView();
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