import 'package:flutter/material.dart';
import 'quiz_start_panel.dart';
import 'package:local_bee/Controller/weekly_quiz_controller.dart';
import 'package:local_bee/Controller/quiz_participation_controller.dart';
import 'package:local_bee/Model/WeeklyQuiz.dart';

class QuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  bool isQuizAvailable = false;
  DateTime? quizEndDate;
  final quizController = WeeklyQuizController();
  final participationController = QuizParticipationController();
  WeeklyQuiz? quiz;

  @override
  void initState() {
    super.initState();
    _checkForAvailableQuiz();
  }

  void _checkForAvailableQuiz() async {
    // Get the available quiz for the current week
    WeeklyQuiz? availableQuiz = await quizController.getAvailableQuiz();

    if (availableQuiz != null) {
      // Check if the user has already completed the quiz
      bool hasCompleted =
          await participationController.hasUserCompletedQuiz(availableQuiz.id);

      setState(() {
        isQuizAvailable = !hasCompleted;
        quizEndDate = availableQuiz.endDate;
        quiz = availableQuiz;
      });
    }
  }

  void timerDone() {
    setState(() {
      isQuizAvailable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),
            isQuizAvailable && quizEndDate != null
                ? QuizStartPanel(
                    quizEndDate: quizEndDate!,
                    onStartPressed: () {
                      // TODO: Handle the start quiz action
                    },
                    timerDone: () {
                      timerDone();
                    },
                  )
                : Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("No new quiz available at the moment.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
