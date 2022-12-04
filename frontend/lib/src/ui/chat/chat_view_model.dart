import 'package:jober/src/models/data/job.dart';
import 'package:jober/src/models/repositories/backend_repository.dart';

class ChatViewModel {
  late BackendRepository _backendRepository;

  ChatViewModel() {
    _backendRepository = BackendRepository.getInstance();
  }

  List<Job> getJobs() {
    return _backendRepository.jobs;
  }

  Future<void> fetchJobs() async {
    if (_backendRepository.jobs.isEmpty) {
      await _backendRepository.fetchJobs();
    }
  }
}
