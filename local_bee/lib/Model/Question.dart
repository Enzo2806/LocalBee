class Question {
  String questionText;
  List<String> options;
  int answerIndex; // Index of the correct option
  int pointsAwarded;

  Question({
    required this.questionText,
    required this.options,
    required this.answerIndex,
    required this.pointsAwarded,
  });

  // Convert the Question object to a map
  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options,
      'answerIndex': answerIndex,
      'pointsAwarded': pointsAwarded,
    };
  }

  // Factory method to create a Question from a map
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionText: map['questionText'],
      options: List<String>.from(map['options']),
      answerIndex: map['answerIndex'],
      pointsAwarded: map['pointsAwarded'],
    );
  }
}
