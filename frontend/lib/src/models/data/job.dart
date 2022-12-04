
class Job {
  final int id;
  final int companyid;
  final List<String> skills;
  final String country;
  final String name;
  final int postalCode;
  final String level;
  final String imageUrl;
  final String description;

  Job({
    required this.id,
    required this.companyid,
    required this.skills,
    required this.country,
    required this.name,
    required this.postalCode,
    required this.level,
    required this.description,
    this.imageUrl = "assets/images/job_default.png",
  });

  Job.fromJson(Map<String, dynamic> json) : this (
    id: json['jobid'] as int,
    companyid: json['companyid'] as int,
    name: json['name'],
    country: json['country'],
    postalCode: json['postalcode'] as int,
    skills: (json['skills'] as List<dynamic>).cast<String>(),
    level: json['level'],
    description: json['description'],
    imageUrl: json['url'] ?? "assets/images/job_default.png",
  );
}
