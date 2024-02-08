import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class QuizParticipationController {
  final String firebaseDatabaseURL = dotenv.env['FIREBASE_DATABASE_URL']!;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> hasUserCompletedQuiz(String quizId) async {
    final User? user = _auth.currentUser;
    if (user == null) return false;

    final url = Uri.https(
        firebaseDatabaseURL, 'quizParticipations/${user.uid}/$quizId.json');

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
}
