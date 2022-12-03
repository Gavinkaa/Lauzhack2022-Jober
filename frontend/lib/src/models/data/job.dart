
class Job {
  final List<String> skills;
  final String location;
  final String name;
  final String description;
  final String level;
  final String imageUrl;

  Job({
    required this.skills,
    required this.location,
    required this.name,
    required this.description,
    required this.level,
    this.imageUrl = "assets/images/job_default.png",
  });

  Job.fromJson(Map<String, dynamic> json) : this (
    skills: json['skills'],
    location: json['location'],
    name: json['name'],
    description: json['description'],
    level: json['level'],
    imageUrl: json['imageUrl'],
  );
}
