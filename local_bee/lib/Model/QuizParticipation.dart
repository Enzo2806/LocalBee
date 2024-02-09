import 'package:local_bee/Model/Question.dart';

class QuizParticipation {
  int score = 0;
  int totalPointsAwarded = 0;
  List<String> questions = [];
  List<int> chosenAnswers = [];
  String userId;
  String quizId;
  DateTime? dateCompleted = DateTime.now().toLocal();

  QuizParticipation.fromDB(
      {required this.userId,
      required this.quizId,
      required this.score,
      required this.totalPointsAwarded,
      required this.chosenAnswers,
      required this.dateCompleted});

  QuizParticipation({
    required this.userId,
    required this.quizId,
  });

  // Convert the QuizParticipation object to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'totalPointsAwarded': totalPointsAwarded,
      'chosenAnswers': chosenAnswers,
      'dateCompleted': dateCompleted.toString(),
    };
  }

  // Factory method to create a QuizParticipation from a map (if you need to retrieve it)
  factory QuizParticipation.fromMap(Map<String, dynamic> map) {
    return QuizParticipation.fromDB(
      userId: map['userId'],
      quizId: map['quizId'],
      score: map['score'],
      totalPointsAwarded: map['totalPointsAwarded'],
      chosenAnswers: List<int>.from(map['chosenAnswers']),
      dateCompleted: DateTime.parse(map['dateCompleted']),
    );
  }

  // This function takes a QuizParticipation object and adds a question and the answer the user selected when completing the quiz.
  void addQuestionAndAnswer(Question question, int chosenAnswer) {
    String questionText = question.questionText;
    // check if the question is already there (user already gave an answer)
    // If it is there, just update the corresponding answer (same index)
    // Otherise append quiz and answer
    if (questions.contains(questionText)) {
      int index = questions.indexOf(questionText);

      // first check if the user changed the answer
      if (chosenAnswers[index] != chosenAnswer) {
        // If the answer is correct (go in question and check the answer index, comapre it to passed answer)
        // If it is correct, add the points to the totalPointsAwarded and add 1 to score
        // If it is not correct, subtract the points from the totalPointsAwarded and subtract 1 from score
        if (question.answerIndex == chosenAnswer) {
          totalPointsAwarded += question.pointsAwarded;
          score += 1;
        } else {
          totalPointsAwarded -= question.pointsAwarded;
          score -= 1;
        }
        chosenAnswers[index] = chosenAnswer;
      }
    } else {
      questions.add(questionText);
      chosenAnswers.add(chosenAnswer);

      // If the answer is correct (go in question and check the answer index, comapre it to passed answer)
      // If it is correct, add the points to the totalPointsAwarded and add 1 to score
      // If it is not correct, do nothing
      if (question.answerIndex == chosenAnswer) {
        totalPointsAwarded += question.pointsAwarded;
        score += 1;
      }
    }
    // Score cannot be negative:
    if (score < 0) {
      score = 0;
    }
  }

  String getScoreString() {
    return '$score / ${questions.length}';
  }

  String getScoreInPercentage() {
    return '${((score / questions.length) * 100).toStringAsFixed(0)}%';
  }
}
