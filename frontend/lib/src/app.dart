import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jober/src/ui/login/login_view.dart';
import 'package:jober/src/ui/match/match_view.dart';
import 'package:jober/src/ui/match_detail/match_detail_view.dart';
import 'package:jober/src/ui/navigation/navigation_view.dart';
import 'package:jober/src/ui/profile/profile_view.dart';
import 'package:jober/src/ui/signup/signup_view.dart';
import 'package:jober/src/ui/theme/app_theme.dart';
import 'package:jober/src/ui/welcome/components/welcome_image.dart';
import 'package:jober/src/ui/welcome/welcome_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                return ProfileView(key: key,);
              case NavigationView.routeName:
                return NavigationView(key: key,);
              case MatchView.routeName:
                return MatchView(key: key,);
              case LoginView.routeName:
                return LoginView(key: key,);
              case WelcomeView.routeName:
                return WelcomeView(key: key,);
              case SignupView.routeName:
                return SignupView(key: key,);
              default:
                return WelcomeView(key: key,);
            }
          },
        );
      },
    );
  }
}
