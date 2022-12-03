import 'package:flutter/material.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    print('ici ca build');
    final viewModel = context.watch<ProfileViewModel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: viewModel.isConnected()
              ? [
                  Text('connected'),
                  ElevatedButton(
                    onPressed: () => viewModel.signOut(),
                    child: Text("SIGN OUT"),
                  ),
                ]
              : [
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
