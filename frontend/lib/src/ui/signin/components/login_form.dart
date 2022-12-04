import 'package:flutter/material.dart';
import 'package:jober/src/ui/signin/signin_viewmodel.dart';
import 'package:jober/src/ui/signup/signup_view.dart';
import 'package:jober/src/ui/theme/app_colors.dart';
import 'package:jober/src/ui/widgets/already_have_an_account_acheck.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
            validator: (val) => viewModel.validateNotNull(val, AppLocalizations.of(context)!.email, context),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.yourEmail,
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
              validator: (val) => viewModel.validateNotNull(val, AppLocalizations.of(context)!.password, context),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.yourPassword,
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
                AppLocalizations.of(context)!.signIn.toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            press: () {
              viewModel.navigateToSignUp(context);
            },
          ),
        ],
      ),
    );
  }
}
