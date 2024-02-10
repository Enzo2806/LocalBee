import 'Question.dart';

class WeeklyQuiz {
  String name;
  DateTime startDate;
  DateTime endDate;
  List<Question> questions;

  WeeklyQuiz({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.questions,
  });

  // Convert the WeeklyQuiz object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'questions': questions.map((question) => question.toMap()).toList(),
    };
  }

  // Factory method to create a WeeklyQuiz from a map
  factory WeeklyQuiz.fromMap(Map<String, dynamic> map) {
    return WeeklyQuiz(
        name: map['name'],
        startDate: DateTime.parse(map['startDate']),
        endDate: DateTime.parse(map['endDate']),
        questions: List<Question>.from(
          map['questions'].map((question) => Question.fromMap(question)),
        ));
  }
}
