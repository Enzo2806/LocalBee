import 'package:flutter/material.dart';
import 'package:local_bee/Model/Question.dart';
import 'package:local_bee/Model/QuizParticipation.dart';
import 'package:local_bee/Model/WeeklyQuiz.dart';
import 'package:local_bee/Views/ViewData/white_green_button.dart';
import 'package:local_bee/Views/main_screen.dart';

class QuizDoneView extends StatelessWidget {
  final QuizParticipation quizParticipation;
  final WeeklyQuiz quiz;

  const QuizDoneView(
      {super.key, required this.quizParticipation, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            // Score display
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color:
                    Colors.green[600], // Adjust the color to match the design
                borderRadius: BorderRadius.circular(40.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Your Score',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    quizParticipation.getScoreString(), // Display the score
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            quizParticipation.getScoreInPercentage(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Completion',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${quizParticipation.questions.length}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Total Questions',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Place text on the left
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Recap of your answers:",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            // Question recap
            ListView.builder(
              shrinkWrap: true,
              itemCount: quiz.questions.length,
              itemBuilder: (context, index) {
                Question question = quiz.questions[index];
                bool isCorrect = question.answerIndex ==
                    quizParticipation.chosenAnswers[index];
                return ListTile(
                  title: Text('Q${index + 1}: ' + question.questionText),
                  subtitle: Text(
                      'Your answer: ${question.options[quizParticipation.chosenAnswers[index]]}\n'
                      'Correct answer: ${question.options[question.answerIndex]}'),
                  trailing: Icon(
                    isCorrect ? Icons.check : Icons.close,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
            WhiteGreenButton(
                text: "Done",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
