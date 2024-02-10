import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_bee/Model/QuizParticipation.dart';
import 'quiz_start_panel.dart';
import 'package:local_bee/Controller/weekly_quiz_controller.dart';
import 'package:local_bee/Controller/quiz_participation_controller.dart';
import 'package:local_bee/Model/WeeklyQuiz.dart';
import 'in_progress_quiz_view.dart';

class QuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  bool isQuizAvailable = false;
  DateTime? quizEndDate;
  final quizController = WeeklyQuizController();
  final participationController = QuizParticipationController();
  List<QuizParticipation> pastParticipations = [];
  WeeklyQuiz? quiz;

  @override
  void initState() {
    super.initState();
    _checkForAvailableQuiz();
    _fetchPastParticipations();
  }

  void _checkForAvailableQuiz() async {
    // Get the available quiz for the current week
    WeeklyQuiz? availableQuiz = await quizController.getAvailableQuiz();
    print(availableQuiz);
    if (availableQuiz != null) {
      // Check if the user has already completed the quiz
      bool hasCompleted = await participationController
          .hasUserCompletedQuiz(availableQuiz.name);

      setState(() {
        isQuizAvailable = !hasCompleted;
        quizEndDate = availableQuiz.endDate;
        quiz = availableQuiz;
      });
    }
  }

  void _fetchPastParticipations() async {
    try {
      final participations =
          await participationController.fetchUserParticipations();
      setState(() => pastParticipations = participations);
    } catch (e) {
      // Handle errors or show a message
      print('Error fetching past participations: $e');
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
                      // Navigate to the in-progress quiz view
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InProgressQuizView(
                            quiz: quiz!,
                            quizParticipation: QuizParticipation(
                              quizId: quiz!.name,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          ),
                        ),
                      );
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
            // Add a title for past quiz participations
            if (pastParticipations.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Past Quizzes',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // Display past quiz participations
            for (var participation in pastParticipations)
              Card(
                child: ListTile(
                  title: Text(
                      'Quiz: ${participation.quizId}'), // Display the quiz title or id
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                          'Date Completed: ${participation.dateCompleted.toString().split(' ')[0]}'),
                      Text('Score: ${participation.score}'),
                      Text(
                          'Points Awarded: ${participation.totalPointsAwarded}')
                      // Add more details if necessary
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
