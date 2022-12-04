import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jober/src/ui/signup/singup_view_model.dart';
import 'package:jober/src/ui/theme/app_colors.dart';
import 'package:jober/src/ui/widgets/already_have_an_account_acheck.dart';

class SignUpForm extends StatelessWidget {
  SignUpViewModel viewModel;
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
            validator: (val) => viewModel.validateNotNull(val, AppLocalizations.of(context)!.email, context),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.yourEmail,
              prefixIcon: const Padding(
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
              validator: (val) => viewModel.validateNotNull(val, AppLocalizations.of(context)!.password, context),
              onSaved: (password) {this.password = password!;},
              cursorColor: Theme.of(context).extension<AppColors>()!.primaryColor,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.yourPassword,
                prefixIcon: const Padding(
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
              child: Text(AppLocalizations.of(context)!.signUp.toUpperCase()),
            ),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              viewModel.navigateToSignIn(context);
            },
          ),
        ],
      ),
    );
  }
}
