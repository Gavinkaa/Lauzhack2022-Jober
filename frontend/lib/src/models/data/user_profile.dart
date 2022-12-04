class UserProfile {
  String firstName;
  String lastName;
  int age;
  final String email;
  int salary;
  List<String> skills;
  // {'country': '<country>', 'postalcode': <postalcode>}
  Map<String, dynamic> location;
  String level;

  UserProfile(
      {required this.firstName,
      required this.lastName,
      required this.age,
      required this.email,
      required this.salary,
      required this.skills,
      required this.location,
      required this.level});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    String firstName = json.keys.contains('firstname') ? json['firstname'] : '';
    String lastName = json.keys.contains('lastname') ? json['lastname'] : '';
    int age = json.keys.contains('age') ? json['age'] : 0;
    String email = json.keys.contains('email') ? json['email'] : '';
    int salary = json.keys.contains('salary') ? json['salary'] : 0;
    List<String> skills = [];
    try {
      skills = json.keys.contains('skills')
          ? List<String>.from(json['skills'])
          : <String>[];
    } catch (e) {
      print('ERROR on skills: $e');
    }
    Map<String, dynamic> location = json.keys.contains('location')
        ? {
            'country': json['location']?.keys.contains('country') ?? false
                ? json['location']['country']
                : '',
            'postalcode': json['location']?.keys.contains('postalcode') ?? false
                ? int.parse(json['location']['postalcode'].toString())
                : 0,
          }
        : {'country': '', 'postalcode': 0};
    String level = json.keys.contains('level') ? json['level'] : '';

    return UserProfile(
        firstName: firstName,
        lastName: lastName,
        age: age,
        email: email,
        salary: salary,
        skills: skills,
        location: location,
        level: level);
  }
}
