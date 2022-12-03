import 'package:flutter/material.dart';
import 'package:jober/src/models/repositories/auth_repository.dart';
import 'package:jober/src/ui/profile/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final ProfileViewModel _viewModel = ProfileViewModel();
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                AuthRepository authRepository = AuthRepository.getInstance();
                await authRepository.signUp(
                    'supabase_ICI_CA_TEST@myburnier.ch', '12345678901');
              },
              child: Text("SIGN UP"),
            ),
            ElevatedButton(
              onPressed: () async {
                AuthRepository authRepository = AuthRepository.getInstance();
                await authRepository.signUp('douglas.bouchet@epfl.ch', '321');
              },
              child: Text("SIGN UP - small password"),
            ),
            ElevatedButton(
              onPressed: () async {
                AuthRepository authRepository = AuthRepository.getInstance();
                await authRepository.signIn(
                    'supabase_ICI_CA_TEST@myburnier.ch', '12345678901');
              },
              child: Text("SIGN IN"),
            ),
            ElevatedButton(
              onPressed: () async {
                AuthRepository authRepository = AuthRepository.getInstance();
                await authRepository.signIn(
                    'supabase_ICI_CA_TEST@myburnier.ch', '12345678900');
              },
              child: Text("SIGN IN - wrong password"),
            ),
            ElevatedButton(
              onPressed: () async {
                AuthRepository authRepository = AuthRepository.getInstance();
                await authRepository.signOut();
              },
              child: Text("SIGN OUT"),
            ),
          ],
        ),
      ),
    );
  }
}
