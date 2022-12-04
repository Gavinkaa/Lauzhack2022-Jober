import 'dart:convert';

import 'package:jober/src/models/data/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// This class is used to connect the user to its account stored
/// in the database. Our database is supabase.io.
class AuthRepository {
  static AuthRepository? _instance;
  final supabaseClient = Supabase.instance.client;

  // TODO: check if useful
  User? _user;
  UserProfile? _userProfile;

  AuthRepository._internal() {
    _user = supabaseClient.auth.currentUser;
  }

  static AuthRepository getInstance() {
    _instance ??= AuthRepository._internal();
    return _instance!;
  }

  Future<void> signIn(String email, String password) async {
    final response = await supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    final Session? session = response.session;
    final User? user = response.user;
    if (session != null && user != null) {
      _user = user;
    } else {
      throw Exception('Failed to sign in');
    }

    await _fetchUser();
  }

  Future<void> signUp(String email, String password) async {
    final response =
        await supabaseClient.auth.signUp(email: email, password: password);
    final User? user = response.user;
    if (user != null) {
      _user = user;
    } else {
      throw Exception('Failed to sign up');
    }

    await _fetchUser();
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
    _user = null;
  }

  Future<void> _fetchUser() async {
    // final response = await Supabase.instance.client
    //     .from('profiles')
    //     .select()
    //     .eq('id', _user!.id)
    //     .execute();
    // final data = response.data;
    // if (data != null) {
    //   final userProfile = UserProfile.fromJson(jsonDecode(data[0]['data']));
    //   return userProfile;
    // } else {
    //   throw Exception('Failed to get user');
    // }
    print('USER IS: $_user');

    _userProfile = UserProfile(
        firstName: 'FirstName', lastName: 'LastName', email: 'Email');
  }

  UserProfile getUser() {
    return UserProfile(
        firstName: 'FirstName', lastName: 'LastName', email: 'Email');

    if (_userProfile == null) {
      throw Exception('Failed to get user');
    }
    return _userProfile!;
  }

  Future<void> setUser(UserProfile userProfile) async {
    // TODO
  }

  User? get user => _user;
}
