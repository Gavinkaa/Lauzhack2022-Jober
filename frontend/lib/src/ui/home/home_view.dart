import 'package:flutter/material.dart';
import 'package:jober/src/ui/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final HomeViewModel _viewModel = HomeViewModel();
  static const routeName = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
    );
  }
}
