import 'package:flutter/material.dart';

class ResultProvider extends ChangeNotifier {
  List<double> result;

  ResultProvider({
    this.result = const [0.0, 0.0],
  });

  void changeresult({
    required List<double> newResult,
  }) async {
    result = newResult;
    notifyListeners();
  }
}
