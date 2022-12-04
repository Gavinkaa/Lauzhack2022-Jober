import 'package:jober/src/models/data/job.dart';
import 'package:jober/src/models/repositories/backend_repository.dart';

class ChatViewModel {
  late BackendRepository _backendRepository;

  ChatViewModel() {
    _backendRepository = BackendRepository.getInstance();
  }

  get jobs => null;
  List<Job> getJobs() {
    return _backendRepository.jobs;
  }
}
