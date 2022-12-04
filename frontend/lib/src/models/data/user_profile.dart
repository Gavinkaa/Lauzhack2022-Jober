import 'dart:convert';

class UserProfile {
  String firstName;
  String lastName;
  final String email;
  int salary;
  List<String> skills;
  // {'country': '<country>', 'postalcode': '<postalcode>'}
  Map<String, String> location;
  String level;

  UserProfile(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.salary,
      required this.skills,
      required this.location,
      required this.level});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        firstName: json['firstname'],
        lastName: json['lastname'],
        email: json['email'],
        salary: json['salary'],
        skills: jsonDecode(json['skills']),
        location: jsonDecode(json['location']),
        level: json['level']);
  }
}
