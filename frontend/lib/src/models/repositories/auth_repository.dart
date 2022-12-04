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
  List<String>? _userSkills;

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
    final response = await supabaseClient.functions.invoke('getUserData');

    final userProfile = UserProfile.fromJson(response.data);

    _userProfile = userProfile;
  }

  Future<void> pushChanges() async {
    final response = await supabaseClient.functions.invoke('setUser', body: {
      'firstname': _userProfile!.firstName,
      'lastname': _userProfile!.lastName,
      'age': _userProfile!.age,
      'email': _userProfile!.email,
      'salary': _userProfile!.salary,
      'skills': _userProfile!.skills,
      'location': _userProfile!.location,
      'level': _userProfile!.level,
    });
  }

  Future<List<String>> getSkills() async {
    if (_userSkills == null) {
      final response = await supabaseClient.functions.invoke('getSkills');
      _userSkills = List<String>.from(response.data);
    }

    print(_userSkills);
    return _userSkills!;
  }

  User? get user => _user;
  UserProfile? get userProfile => _userProfile;
  List<String>? get userSkills => _userSkills;
  bool isConnected() => _user != null;
}
