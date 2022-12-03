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
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
    _user = null;
  }

  Future<UserProfile> getUser() async {
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

    return UserProfile(
        firstName: 'FirstName', lastName: 'LastName', email: 'Email');
  }

  void getUserAs() async {
    final response = await supabaseClient.functions.invoke('getUser');
    print(response.data['error_code']);
  }

  User? get user => _user;
}
