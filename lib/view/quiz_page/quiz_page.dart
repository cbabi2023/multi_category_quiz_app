import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/quiz_page_controller/quiz_page_controller.dart';
import 'package:quiz_app/utils/color_constants/color_constants.dart';
import 'package:quiz_app/view/dashboard_screen/dashboard_screen.dart';
import 'package:quiz_app/view/result_page/result_page.dart';

class QuizPage extends StatelessWidget {
  final String categoryName;
  final List categoryBaseQuestionCount;
  final CountDownController countDownController =
      CountDownController(); // Controller instance

  QuizPage({
    super.key,
    required this.categoryName,
    required this.categoryBaseQuestionCount,
  });

  @override
  Widget build(BuildContext context) {
    final quizController = Provider.of<QuizPageController>(context);
    if (quizController.questionCount == 0) {
      quizController.questionCount = categoryBaseQuestionCount.length;
      quizController.countQuestion(quizController.questionCount);
    }

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
        child: Column(
          children: [
            // ------------------------------------ Header Section -----------------------------------------------------
            const QuizHeaderSection(),

            // ------------------------------------ Header Section ENDS -----------------------------------------------------

            const SizedBox(
              height: 60,
            ),

            // ------------------------------------ Question Container Section -----------------------------------------------------

            SizedBox(
              height: 275,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 250,
                      width: 300,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 20),
                      decoration: BoxDecoration(
                          color: ColorConstants.backgroundContainerColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: ColorConstants
                                  .backgroundContainerBorderColor
                                  .withOpacity(0.3)),
                          boxShadow: const [
                            BoxShadow(blurRadius: 3, offset: Offset(3, 4))
                          ]),

                      // question section

                      child: Center(
                        child: Text(
                            categoryBaseQuestionCount[
                                quizController.questionIndex]["question"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.textColor,
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorConstants.backgroundColor,
                      child: CircularCountDownTimer(
                        duration: 5, // Set duration to 30 seconds
                        initialDuration: 0,
                        controller: countDownController,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2,
                        ringColor: Colors.grey[300]!,
                        fillColor: ColorConstants.rankValueColor,
                        backgroundColor: ColorConstants.backgroundColor,
                        strokeWidth: 6.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        textFormat: CountdownTextFormat.S,
                        isReverse: true, // Set to true to count down
                        isReverseAnimation:
                            true, // Set to true for reverse animation
                        isTimerTextShown: true,
                        autoStart: true, // Start the timer automatically
                        onStart: () {
                          debugPrint('Countdown Started');
                          quizController.canSelectOptions = true;
                        },
                        onComplete: () {
                          debugPrint('Countdown Ended');

                          quizController.timerFinish();
                          quizController
                              .disableOptionSelection(); // Disable option selection
                        },
                        onChange: (String timeStamp) {
                          debugPrint('Countdown Changed $timeStamp');
                        },
                        timeFormatterFunction:
                            (defaultFormatterFunction, duration) {
                          if (duration.inSeconds == 0) {
                            return "0"; // Customize text when timer ends
                          } else {
                            return Function.apply(
                                defaultFormatterFunction, [duration]);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),

            // ------------------------------------ Question Container Section ENDS -----------------------------------------------------

            const SizedBox(
              height: 22,
            ),

            // ------------------------------------ Question Option Section Starts-----------------------------------------------------

            Column(
              children: List.generate(4, (index) {
                bool isSelected = quizController.selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: InkWell(
                    onTap: () {
                      if (quizController.selectedIndex == null &&
                          quizController.canSelectOptions) {
                        // selected Index
                        quizController.selectIndex(index);
                        quizController.selectedOptionIndex = index;

                        quizController.visibleNextButton();

                        // Stop the countdown when an option is selected
                        countDownController.pause(); // Pause the countdown

                        // correct Index
                        quizController.correctIndex = categoryBaseQuestionCount[
                            quizController.questionIndex]["correctIndex"];

                        // cheking selected Index correct or not
                        quizController
                            .checkCorrectIndex(quizController.correctIndex!);

                        quizController.calculateScore();

                        log('total score: ${quizController.totalScore}');
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isSelected
                                        ? quizController.isCorrectIndex
                                            ? ColorConstants.correctAnswer
                                            : ColorConstants.wrongAnswer
                                        : ColorConstants
                                            .backgroundContainerBorderColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(16),
                                color: quizController.nextButtonVisible
                                    ? quizController.correctIndex == index
                                        ? ColorConstants.correctAnswer.withOpacity(
                                            0.3) // Light green for correct answer
                                        : (quizController.selectedIndex == index
                                            ? ColorConstants.wrongAnswer
                                                .withOpacity(
                                                    0.2) // Light red for wrong answer
                                            : Colors.transparent)
                                    : null),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  categoryBaseQuestionCount[quizController
                                      .questionIndex]["options"][index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.textColor,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      isSelected
                                          ? quizController.isCorrectIndex
                                              ? Icons.check_circle_outline
                                              : Icons.close
                                          : Icons.circle_outlined,
                                      color: isSelected
                                          ? quizController.isCorrectIndex
                                              ? ColorConstants.correctAnswer
                                              : ColorConstants.wrongAnswer
                                          : ColorConstants
                                              .backgroundContainerBorderColor,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            // ------------------------------------ Question Option Section ENDS -----------------------------------------------------

            // ------------------------------------ NExt Button Starts -----------------------------------------------------
            if (quizController.nextButtonVisible)
              InkWell(
                onTap: () {
                  quizController.updateQuestion(); // Update the question index
                  quizController.selectedIndex = null; // Reset selected index

                  // Delay the call to visibleNextButton
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    quizController.visibleNextButton();
                  });

                  // Restart the countdown
                  countDownController.restart(duration: 5);

                  // Check if it's time to navigate to the result page
                  if (quizController.resulPageNavigation) {
                    // Reset quiz state before navigating

                    // Navigate to the result page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          categoryName: categoryName,
                          categoryBaseQuestionCount: categoryBaseQuestionCount,
                        ),
                      ),
                    );
                    quizController.resetQuiz();
                    quizController.resulPageNavigation = false;
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorConstants.rankValueColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text('Next',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.textColor,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            // ------------------------------------ NExt Button ENDS -----------------------------------------------------
          ],
        ),
      ),
    );
  }
}

// ------------------------------------ Header Section -----------------------------------------------------

class QuizHeaderSection extends StatelessWidget {
  const QuizHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final quizControllerThree = Provider.of<QuizPageController>(context);
    quizControllerThree.questionCount;
    quizControllerThree.questionIndex;
    // Calculate the progress bar percentage based on the current question index
    double progressBarPercentage = ((quizControllerThree.questionIndex) /
            quizControllerThree.questionCount *
            100)
        .toDouble();

    return Row(
      children: [
        InkWell(
          onTap: () {
            quizControllerThree.closeQuestion();
            quizControllerThree.updateQuestion(); // Update the question index
            quizControllerThree.selectedIndex = null; // Reset selected index
            quizControllerThree.visibleNextButton();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ));
          },
          child: const CircleAvatar(
            radius: 17,
            backgroundColor: ColorConstants.backgroundContainerBorderColor,
            child: Center(
              child: CircleAvatar(
                radius: 16,
                backgroundColor: ColorConstants.backgroundContainerColor,
                child: Center(
                    child: Icon(
                  Icons.close,
                  color: ColorConstants.textColor,
                )),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 34,
              decoration: BoxDecoration(
                color: ColorConstants.backgroundContainerColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: ColorConstants.backgroundContainerBorderColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    // Use Expanded to take available space
                    child: Container(
                      // Use a Container for the progress bar
                      height: 20, // Match the height of the progress bar
                      child: RoundedProgressBar(
                        style: RoundedProgressBarStyle(),
                        milliseconds: 100,
                        percent: progressBarPercentage,
                        height: 5, // Set the same height
                        theme: RoundedProgressBarTheme.yellow,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Space between progress bar and text
                  Text(
                    '${quizControllerThree.questionIndex + 1} / ${quizControllerThree.questionCount}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: ColorConstants.rankValueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

// ------------------------------------ Header Section ENDS -----------------------------------------------------
