import 'package:flutter/cupertino.dart';

class MatchDetailViewModel {
  late ScrollController scrollController;

  MatchDetailViewModel() {
    scrollController = ScrollController();
  }

  void disposeController() {
    scrollController.dispose();
  }


}
