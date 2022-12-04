import 'package:jober/src/models/data/job.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BackendRepository {
  final supabaseClient = Supabase.instance.client;
  List<Job> _jobs = [];

  static BackendRepository? _instance;

  BackendRepository._internal();

  List<Job> get jobs => _jobs;

  static BackendRepository getInstance() {
    _instance ??= BackendRepository._internal();
    return _instance!;
  }

  Future<void> fetchJobs() async {
    final response = await supabaseClient.functions.invoke('getJobs');
    print(response.data);
    for (var job in response.data) {
      _jobs.add(Job.fromJson(job));
    }
  }

}
