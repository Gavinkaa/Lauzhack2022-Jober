import 'package:flutter/material.dart';
import 'package:jober/src/ui/match/match_view_model.dart';
import 'package:jober/src/ui/navigation/navigation_view_model.dart';
import 'package:jober/src/ui/profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';
import 'src/models/repositories/auth_repository.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://uzvwpbxzjtfbbmdapacz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV6dndwYnh6anRmYmJtZGFwYWN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzAwNzQ1OTYsImV4cCI6MTk4NTY1MDU5Nn0.5oDKYiph012cKHRgr8sFUHrpehhtzG2YkatX1LI7NwA',
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ChangeNotifierProvider(create: (_) => MatchViewModel()),
      ChangeNotifierProvider(create: (_) => ProfileViewModel()),
    ], child: const MyApp()),
  );
}
