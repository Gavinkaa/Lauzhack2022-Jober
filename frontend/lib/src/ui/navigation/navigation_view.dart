import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:jober/src/ui/match/match_view.dart';
import 'package:jober/src/ui/navigation/navigation_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jober/src/ui/theme/app_colors.dart';
import 'package:provider/provider.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NavigationViewModel>();

    return Scaffold(
      body: _buildBody(viewModel),
      bottomNavigationBar: CurvedNavigationBar(
        index: viewModel.currentIndex,
        color: Theme.of(context).extension<AppColors>()!.bottomAppBarColor!,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.person, color: Theme.of(context).extension<AppColors>()!.bottomAppBarIconColor),
            label: AppLocalizations.of(context)!.profile,
            labelStyle: TextStyle(color: Theme.of(context).extension<AppColors>()!.bottomAppBarIconColor),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.flash_on, color: Theme.of(context).extension<AppColors>()!.bottomAppBarIconColor),
            label: AppLocalizations.of(context)!.match,
            labelStyle: TextStyle(color: Theme.of(context).extension<AppColors>()!.bottomAppBarIconColor),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.chat, color: Theme.of(context).extension<AppColors>()!.bottomAppBarIconColor),
            label: AppLocalizations.of(context)!.chat,
            labelStyle: TextStyle(color: Theme.of(context).extension<AppColors>()!.bottomAppBarIconColor),
          ),
        ],
        onTap: (index) {
          viewModel.changeIndex(index);
        },
      ),
    );
  }

  Widget _buildBody(NavigationViewModel viewModel) {
    switch (viewModel.currentIndex) {
      case 0:
        return Container();
      case 1:
        return MatchView();
      case 2:
        return Container();
      default:
        return Container();
    }
  }
}
