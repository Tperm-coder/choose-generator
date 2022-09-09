import 'package:flutter/material.dart';

class QuestionPageProvider extends ChangeNotifier {
  List<dynamic> json;
  QuestionPageProvider({
    required this.json,
  }) : super();
  Map<int, int> choosedAnswers = {};
  bool showCorrectAnswer = false;
  void toggleShowAnswersState() {
    showCorrectAnswer = !showCorrectAnswer;
    notifyListeners();
  }

  void updateAnswer(int questionIndex, int answerIndex) {
    choosedAnswers[questionIndex] = answerIndex;
    notifyListeners();
  }
}
