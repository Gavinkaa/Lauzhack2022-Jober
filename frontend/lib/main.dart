import 'package:flutter/material.dart';
import 'package:jober/src/ui/navigation/navigation_view_model.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

void main() async {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => NavigationViewModel()),
    ], child: const MyApp()),
  );
}
