import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jober/src/ui/theme/app_colors.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "${AppLocalizations.of(context)!.dontHaveAnAccount} " : "${AppLocalizations.of(context)!.alreadyHaveAnAccount} ",
          style: TextStyle(color: Theme.of(context).extension<AppColors>()!.primaryColor),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? AppLocalizations.of(context)!.signUp : AppLocalizations.of(context)!.signIn,
            style: TextStyle(
              color: Theme.of(context).extension<AppColors>()!.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
