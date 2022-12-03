import 'package:flutter/material.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    print('ici ca build');
    final viewModel = context.watch<LoginViewModel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => viewModel.signUp(
                  'supabase_ICI_CA_TEST@myburnier.ch', '12345678901'),
              child: Text("SIGN UP"),
            ),
            ElevatedButton(
              onPressed: () => viewModel.signIn(
                  'supabase_ICI_CA_TEST@myburnier.ch', '12345678901'),
              child: Text("SIGN IN"),
            ),
          ],
        ),
      ),
    );
  }
}
