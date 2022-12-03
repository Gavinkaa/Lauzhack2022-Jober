import 'package:flutter/material.dart';
import 'package:jober/src/ui/profile/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final ProfileViewModel _viewModel = ProfileViewModel();
  static const routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
