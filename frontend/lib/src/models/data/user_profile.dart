class UserProfile {
  String firstName;
  String lastName;
  String email;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : this(
          firstName: json['firstName'],
          lastName: json['lastName'],
          email: json['email'],
        );
}
