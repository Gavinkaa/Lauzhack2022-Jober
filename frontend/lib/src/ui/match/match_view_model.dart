
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jober/src/models/data/job.dart';

enum CardStatus { like, dislike, superLike }

class MatchViewModel extends ChangeNotifier {
  List<Job> _jobs = [];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;

  List<Job> get jobs => _jobs;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  MatchViewModel() {
    resetUsers();
  }

  void setScreenSize(Size size) => _screenSize = size;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
  }
  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }
  void endPosition() {
    _isDragging = false;
    final status = getStatus(force: true);

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        superlike();
        break;
      default:
        resetPosition();
    }

    notifyListeners();
  }

  double getStatusOpacity() {
    const delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos/delta;

    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    double delta = 30;
    if (force) {
      delta = 100;
    }
    if (x >= delta) {
      return CardStatus.like;
    }
    if (x <= -delta) {
      return CardStatus.dislike;
    }
    if (y <= -delta/2 && x.abs() < 30) {
      return CardStatus.superLike;
    }
    return null;
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  void resetUsers() {
    _jobs = <Job>[
          Job(name: "Name", description: "A very long descriptions that contains a lot of informations, A very long descriptions that contains a lot of informations !", level: "Level", location: "Location", skills: ["Skill1", "Skill2", "Skill3"]),
          Job(name: "Name2", description: "Description2", level: "Level2", location: "Location2", skills: ["Skill1", "Skill2", "Skill3"]),
          Job(name: "Name2", description: "Description2", level: "Level2", location: "Location2", skills: ["Skill1", "Skill2", "Skill3"]),
          Job(name: "Name2", description: "Description2", level: "Level2", location: "Location2", skills: ["Skill1", "Skill2", "Skill3"]),
          Job(name: "Name2", description: "Description2", level: "Level2", location: "Location2", skills: ["Skill1", "Skill2", "Skill3"]),
          ].reversed.toList();
    notifyListeners();
  }

  void like() {
    _angle = 20;
    _position += Offset(2*_screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2*_screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void superlike() {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _nextCard();

    notifyListeners();
  }

  void _nextCard() async {
    if (_jobs.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _jobs.removeLast();
    resetPosition();
  }
}
