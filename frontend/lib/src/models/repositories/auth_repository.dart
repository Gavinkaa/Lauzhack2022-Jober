import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

/// This class is used to connect the user to its account stored
/// in the database. Our database is supabase.io.
class AuthRepository {
  static AuthRepository? _instance;

  User? _user;

  AuthRepository._internal();

  static AuthRepository getInstance() {
    _instance ??= AuthRepository._internal();
    return _instance!;
  }

  Future<void> signIn(String email, String password) async {
    final response = await Supabase.instance.client.auth
        .signInWithPassword(email: email, password: password);
    final Session? session = response.session;
    final User? user = response.user;
    if (session != null && user != null) {
      _user = user;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> signUp(String email, String password) async {
    final response = await Supabase.instance.client.auth
        .signUp(email: email, password: password);
    final User? user = response.user;
    if (user != null) {
      _user = user;
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    _user = null;
  }
}
