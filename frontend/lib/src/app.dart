import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jober/src/ui/match/match_view.dart';
import 'package:jober/src/ui/navigation/navigation_view.dart';
import 'package:jober/src/ui/profile/profile_view.dart';
import 'package:jober/src/ui/theme/app_theme.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'jober',

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      theme: AppTheme.getLightTheme(),

      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case ProfileView.routeName:
                return ProfileView();
              case NavigationView.routeName:
                return ProfileView();
              case MatchView.routeName:
                return MatchView();
              default:
                return NavigationView(
                  key: key,
                );
            }
          },
        );
      },
    );
  }
}
