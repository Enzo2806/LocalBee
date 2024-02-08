import 'Question.dart';

class WeeklyQuiz {
  String id;
  DateTime startDate;
  DateTime endDate;
  List<Question> questions;

  WeeklyQuiz({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.questions,
  });

  // Convert the WeeklyQuiz object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'questions': questions.map((question) => question.toMap()).toList(),
    };
  }

  // Factory method to create a WeeklyQuiz from a map
  factory WeeklyQuiz.fromMap(Map<String, dynamic> map, String id) {
    // The questions are contained in a nested map,
    // so we first access the values of the nested map, and then we map each one to a Question object.
    List<Question> questions = (map['questions'] as Map<String, dynamic>)
        .values
        .map<Question>((questionMap) {
      return Question.fromMap(questionMap as Map<String, dynamic>);
    }).toList();

    return WeeklyQuiz(
      id: id,
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      questions: questions,
    );
  }
}
