import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/quiz_page_controller/quiz_page_controller.dart';
import 'package:quiz_app/utils/color_constants/color_constants.dart';
import 'package:quiz_app/view/dashboard_screen/dashboard_screen.dart';
import 'package:quiz_app/view/quiz_page/quiz_page.dart';

class ResultPage extends StatelessWidget {
  final String categoryName;
  final List categoryBaseQuestionCount;
  const ResultPage({
    super.key,
    required this.categoryName,
    required this.categoryBaseQuestionCount,
  });

  @override
  Widget build(BuildContext context) {
    final quizControllerrResult = Provider.of<QuizPageController>(context);
    // Calculate percentage
    double percentage = quizControllerrResult.totalQuestion > 0
        ? (quizControllerrResult.totalScore /
                quizControllerrResult.totalQuestion) *
            100
        : 0; // Default to 0 if totalQuestion is 0

// Determine the number of filled stars
    int filledStars = (percentage / 20).floor(); // 20% increments

// Set star colors
    Color getStarColor(int index) {
      return index < filledStars
          ? ColorConstants.starColorPointed
          : ColorConstants.textColor;
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Container(
                height: screenHeight / 1.9,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.resultScreenGradientOne,
                      ColorConstants.resultScreenGradientTwo,
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  height: screenHeight / 2,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: ColorConstants.backgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),

              // -------------- Stars Got by Percentage -------------------------------------
              Positioned(
                bottom: screenHeight / 1.55,
                left: screenWidth / 6.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: index == 2
                          ? 100
                          : (index == 1 || index == 3 ? 50 : 25),
                      color: getStarColor(index),
                    ),
                  ),
                ),
              ),

              // -------------- Total Score in the Quiz -------------------------------------
              Positioned(
                bottom: screenHeight / 1.75,
                left: screenWidth / 2.4,
                child: Text(
                  '${quizControllerrResult.totalScore} / ${quizControllerrResult.totalQuestion}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textColor,
                  ),
                ),
              ),

              // -------------- Home Quiz Button -------------------------------------
              Positioned(
                bottom: screenHeight / 3.5,
                left: screenWidth / 3.2,
                child: Container(
                  width: 150,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorConstants.textColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            ColorConstants.rankValueColor.withOpacity(0.3),
                        child: IconButton(
                            onPressed: () {
                              quizControllerrResult.backtoNomalScore();
                              log('question count${quizControllerrResult.questionCount}');
                              log(' question index ${quizControllerrResult.questionIndex}');

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardScreen(),
                                  ));
                            },
                            icon: Icon(Icons.home)),
                      ),

                      // retry button
                      CircleAvatar(
                        backgroundColor:
                            ColorConstants.rankValueColor.withOpacity(0.3),
                        child: IconButton(
                            onPressed: () {
                              quizControllerrResult.backtoNomalScore();
                              log('question count${quizControllerrResult.questionCount}');
                              log(' question index ${quizControllerrResult.questionIndex}');

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizPage(
                                      categoryBaseQuestionCount:
                                          categoryBaseQuestionCount,
                                      categoryName: categoryName,
                                    ),
                                  ));
                            },
                            icon: const Icon(Icons.rotate_right)),
                      ),
                    ],
                  ),
                ),
              ),

              // -------------- Retry Quiz Button -------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
