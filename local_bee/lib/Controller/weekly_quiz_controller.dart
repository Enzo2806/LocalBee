import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:local_bee/Model/WeeklyQuiz.dart';

class WeeklyQuizController {
  final String firebaseDatabaseURL = dotenv.env['FIREBASE_DATABASE_URL']!;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* 
  * This method fetches the available quiz for the current week
  * by sending a GET request to the Firebase Realtime Database
  * to fetch the list of quizzes and find the one that is currently active.
  */
  Future<WeeklyQuiz?> getAvailableQuiz() async {
    // Construct the URL for the quizzes endpoint
    final url = Uri.https(firebaseDatabaseURL, 'quizzes.json');

    try {
      // Send a GET request to fetch quizzes
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final quizzesData = json.decode(response.body) as Map<String, dynamic>;
        // Find the quiz that is currently active
        DateTime now = DateTime.now();
        for (var quizId in quizzesData.keys) {
          final quizData = quizzesData[quizId];
          final startDate = DateTime.parse(quizData['startDate']).toLocal();
          final endDate = DateTime.parse(quizData['endDate']).toLocal();
          if (now.isAfter(startDate) && now.isBefore(endDate)) {
            return WeeklyQuiz.fromMap(quizData, quizId);
          }
        }
      } else {
        throw Exception('Failed to fetch quizzes from the database');
      }
    } catch (e) {
      print(e);
      // Handle exceptions by returning null or rethrowing the exception
    }
    return null;
  }
}
