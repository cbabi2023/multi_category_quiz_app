import 'package:flutter/material.dart';
import 'package:quiz_app/utils/color_constants/color_constants.dart';

class QuizPageController with ChangeNotifier {
  int questionIndex = 0; // question index value in a questionList
  int questionCount = 0; // total count of questions in the questionList

  int totalQuestion = 0; // count question

  // count question function
  countQuestion(int countQuestion) {
    totalQuestion = countQuestion;
    notifyListeners();
  }

  int? selectedOptionIndex;
  int? correctIndex;
  bool isCorrectIndex = false;

  bool resulPageNavigation = false;

  int? selectedIndex; // to select a option

  // timer logic variables

  bool canSelectOptions = true; // Flag to control option selection

  int totalScore = 0; // total correct answers

  // calculate total correct answers

  calculateScore() {
    if (selectedIndex == correctIndex) {
      totalScore++;
      notifyListeners();
    }
  }

   

  // back to normal stage score
  backtoNomalScore() {
    totalScore = 0;
    questionCount = 0;
    totalQuestion = 0;

    notifyListeners();
  }

  // reset quiz questions
  resetQuiz() {
    questionIndex = 0;
    selectedIndex = null;
    questionCount = 0;

    notifyListeners();
  }

  // set selecting option disable after timer ends
  void disableOptionSelection() {
    canSelectOptions = false;
    nextButtonVisible = true;

    notifyListeners();
  }

  // to select an option
  void selectIndex(int index) {
    if (canSelectOptions) {
      selectedIndex = index;
      // Call setter to trigger notifyListeners
      notifyListeners(); // Already included
    }
  }

  // next button visible when any selected

  bool nextButtonVisible = false;

  visibleNextButton() {
    if (selectedIndex != null) {
      nextButtonVisible = true;
      notifyListeners();
    } else {
      nextButtonVisible = false;
      notifyListeners();
    }
  }

  timerFinish() {
    nextButtonVisible = true;

    notifyListeners();
  }

  // to check selected option equals to selected index
  checkCorrectIndex(int correctIndex) {
    if (correctIndex == selectedIndex) {
      isCorrectIndex = true;
      notifyListeners();
    } else {
      isCorrectIndex = false;
      notifyListeners();
    }
  }

// Updating the Question number and Options
  void updateQuestion() {
    if (questionIndex < questionCount - 1) {
      questionIndex++;
      print('Question updated to index: $questionIndex');
    } else if (questionIndex == questionCount - 1) {
      resulPageNavigation = true; // Set flag to indicate navigation to results
      print('Last question answered, set resulPageNavigation to true');
    }
    notifyListeners(); // Notify listeners after state change
  }

// Closing Quiz Question Page & All back to Normal
  closeQuestion() {
    questionIndex = 0;
    selectedIndex = null;
    notifyListeners();
  }


 
}
