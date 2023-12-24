import 'package:flutter/material.dart';

class GoalProvider extends ChangeNotifier {
  double goal;

  GoalProvider({
    this.goal = 0.0,
  });

  void changeresult({
    required double newGoal,
  }) async {
    goal = newGoal;
    notifyListeners();
  }
}

class NotificationProvider extends ChangeNotifier {
  List<String> notifications = [];

  void addNotification(String notification) {
    notifications.add(notification);
    notifyListeners();
  }
}
