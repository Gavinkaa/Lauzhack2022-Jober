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

    await fetchUser();
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

    await fetchUser();
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
    _user = null;
    _userProfile = null;
  }

  Future<void> fetchUser() async {
    print('USER IS: $_user');

    _userProfile = UserProfile(
        firstName: 'John',
        lastName: 'Doe',
        age: 20,
        email: _user!.email!,
        salary: 0,
        skills: ['Java', 'Flutter'],
        location: {'country': 'CH', 'postalcode': '1234'},
        level: 'Junior');
  }

  Future<void> pushChanges() async {}

  Future<void> setUser(UserProfile userProfile) async {
    final response = await supabaseClient.functions.invoke('setUser', body: {
      'salary': userProfile.salary,
      'firstname': userProfile.firstName,
      'lastname': userProfile.lastName,
      'age': userProfile.age,
      'skills': jsonEncode(['Java']),
    });
  }

  Future<void> dougyStyle() async {
    final response = await supabaseClient.functions.invoke('getUserData');

    print(response.data);

    final userProfile = UserProfile.fromJson(response.data);

    print(userProfile);
  }

  User? get user => _user;
  UserProfile? get userProfile => _userProfile;
  bool isConnected() => _user != null;
}
