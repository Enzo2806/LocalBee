import 'package:flutter/material.dart';
import 'package:local_bee/Controller/quiz_participation_controller.dart';
import 'package:local_bee/Model/Question.dart';
import 'package:local_bee/Model/QuizParticipation.dart';
import 'package:local_bee/Model/WeeklyQuiz.dart';
import 'package:local_bee/Views/ViewData/green_button.dart';
import 'package:local_bee/Views/ViewData/show_error_dialog.dart';
import 'package:local_bee/Views/quiz_view/quiz_done_view.dart';

class InProgressQuizView extends StatefulWidget {
  final WeeklyQuiz quiz;
  final QuizParticipation quizParticipation;
  const InProgressQuizView(
      {super.key, required this.quiz, required this.quizParticipation});

  @override
  State<InProgressQuizView> createState() => _InProgressQuizViewState();
}

class _InProgressQuizViewState extends State<InProgressQuizView> {
  int _currentIndex = 0;
  int selectedAnswer = 0;

  @override
  Widget build(BuildContext context) {
    final List<Question> questions = widget.quiz.questions;
    Question currentQuestion = questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1} of ${questions.length}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentQuestion.questionText,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // Disbale scrolling: the ListView will be contained in a Column,
                      // so it will take up all the available space and won't need to scroll
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentQuestion.options.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(currentQuestion.options[index]),
                          leading: Radio<int>(
                            value: index,
                            groupValue: selectedAnswer,
                            activeColor: Colors.green[800],
                            onChanged: (int? value) {
                              setState(() {
                                selectedAnswer = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Adjust alignment for spacing
              children: [
                // Show "Previous" button only if it's not the first question
                if (_currentIndex > 0)
                  GreenButton(
                    icon: Icons
                        .arrow_back, // Assuming GreenButton supports an `icon` parameter
                    text: "Previous",
                    textSize: 13,
                    onPressed: () {
                      setState(() {
                        _currentIndex--;
                      });
                    },
                  )
                else
                  const Spacer(), // Use Spacer to align the next/done button to the right when there is no previous button
                // Change "Next" to "Done" for the last question and adjust onPressed behavior
                GreenButton(
                  icon: _currentIndex < questions.length - 1
                      ? Icons.arrow_forward
                      : Icons.check, // Change icon based on the context
                  text: _currentIndex < questions.length - 1 ? "Next" : "Done",
                  textSize: 13,
                  onPressed: () {
                    if (_currentIndex < questions.length - 1) {
                      setState(() {
                        widget.quizParticipation.addQuestionAndAnswer(
                            currentQuestion, selectedAnswer);
                        _currentIndex++;
                      });
                    } else {
                      widget.quizParticipation.addQuestionAndAnswer(
                          currentQuestion, selectedAnswer);
                      // Navigate to the quiz done view
                      QuizParticipationController controller =
                          QuizParticipationController();
                      controller
                          .saveQuizParticipation(widget.quizParticipation)
                          .catchError((e) {
                        // If there's an error, display it
                        // Convert the exception to a string and remove the 'Exception: ' part
                        final errorMessage =
                            e.toString().replaceAll('Exception: ', '');
                        showErrorDialog(
                            context, 'Registration Failed', errorMessage);
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizDoneView(
                              quizParticipation: widget.quizParticipation,
                              quiz: widget.quiz),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
