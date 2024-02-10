import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:local_bee/Model/QuizParticipation.dart';

class QuizParticipationController {
  final String firebaseDatabaseURL = dotenv.env['FIREBASE_DATABASE_URL']!;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* 
  * This method checks if the user has completed a quiz
  * by sending a GET request to the Firebase Realtime Database
  * to check if the user has a participation record for the quiz.
  */
  Future<bool> hasUserCompletedQuiz(String quizName) async {
    final User? user = _auth.currentUser;
    if (user == null) return false;

    final url = Uri.https(
        firebaseDatabaseURL, 'quizParticipations/${user.uid}/$quizName.json');

    try {
      // Send a GET request to check the user's participation
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // If the response body is not null, the user has a participation record
        return response.body != 'null';
      } else {
        throw Exception('Failed to check user participation');
      }
    } catch (e) {
      print(e);
      // Handle exceptions by returning false or rethrowing the exception
    }
    return false;
  }

  /*
  * This method saves the user's quiz participation to the Firebase Realtime Database
  * by sending a PUT request with the quiz participation data.
  * It also adds the points to the user profile.
  */
  Future<void> saveQuizParticipation(
      QuizParticipation quizParticipation) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not signed in.');
    }

    final url = Uri.https(firebaseDatabaseURL,
        'quizParticipations/${user.uid}/${quizParticipation.quizId}.json');

    try {
      // Convert the QuizParticipation to a map
      final participationData = quizParticipation.toMap();

      // Send a PUT request to save the quiz participation
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(participationData),
      );

      // Add points to user account

      if (response.statusCode != 200) {
        throw Exception('Failed to save quiz participation.');
      }
    } catch (e) {
      print(e);
      // Handle exceptions by rethrowing or logging
      throw Exception('Failed to save quiz participation: $e');
    }
  }

  /*
  * This method fetches the user's quiz participations from the Firebase Realtime Database
  * by sending a GET request to the user's quizParticipations node.
  */
  Future<List<QuizParticipation>> fetchUserParticipations() async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('User is not signed in.');

    final url =
        Uri.https(firebaseDatabaseURL, 'quizParticipations/${user.uid}.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final participationsMap =
          json.decode(response.body) as Map<String, dynamic>;
      return participationsMap.entries.map((entry) {
        return QuizParticipation.fromMap(
            Map<String, dynamic>.from(entry.value));
      }).toList();
    } else {
      throw Exception('Failed to fetch user participations.');
    }
  }
}
