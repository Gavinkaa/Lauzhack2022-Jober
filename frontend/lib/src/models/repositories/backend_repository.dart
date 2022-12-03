class BackendRepository {

  static BackendRepository? _instance;

  BackendRepository._internal();

  static BackendRepository getInstance() {
    _instance ??= BackendRepository._internal();
    return _instance!;
  }

}