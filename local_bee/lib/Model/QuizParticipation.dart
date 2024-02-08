class QuizParticipation {
  double score;
  int totalPointsAwarded;
  List<String> questions;
  List<int> chosenAnswers;
  String userId;
  String quizId;

  QuizParticipation({
    required this.userId,
    required this.quizId,
    required this.score,
    required this.totalPointsAwarded,
    required this.questions,
    required this.chosenAnswers,
  });

  // Convert the QuizParticipation object to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'totalPointsAwarded': totalPointsAwarded,
      'questions': questions,
      'chosenAnswers': chosenAnswers,
    };
  }

  // Factory method to create a QuizParticipation from a map (if you need to retrieve it)
  factory QuizParticipation.fromMap(
      Map<String, dynamic> map, String userId, String quizId) {
    return QuizParticipation(
      userId: userId,
      quizId: quizId,
      score: map['score'],
      totalPointsAwarded: map['totalPointsAwarded'],
      questions: List<String>.from(map['questions']),
      chosenAnswers: List<int>.from(map['chosenAnswers']),
    );
  }
}
