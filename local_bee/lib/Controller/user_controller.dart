import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_bee/Model/User.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String firebaseDatabaseURL = dotenv.env['FIREBASE_DATABASE_URL']!;

  /*
  * Register a user with email and password
  * @param email: user's email
  * @param password: user's password
  * @param name: user's name
  * @param familyName: user's family name
  * @param preferredLanguage: user's preferred language
  * @throws Exception if any of the fields are empty
  * @throws Exception if the email is not in the correct format
  * @throws Exception if the password is not at least 6 characters long
  * @throws Exception if the password does not contain at least one uppercase and one lowercase letter
  * @throws Exception if the user profile could not be saved to the database
  */
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String familyName,
    required String preferredLanguage,
  }) async {
    // List to keep track of empty fields
    List<String> emptyFields = [];

    // Check each field and add to the list if empty
    if (name.isEmpty) emptyFields.add("name");
    if (familyName.isEmpty) emptyFields.add("family name");
    if (email.isEmpty) emptyFields.add("email");
    if (password.isEmpty) emptyFields.add("password");

    // If all fields are empty, throw a single message
    if (emptyFields.length == 4) {
      throw Exception("All fields are empty");
    } else if (emptyFields.isNotEmpty) {
      // Join the list of empty fields into a single string separated by commas
      throw Exception(
          "Please fill in the following fields: ${emptyFields.join(', ')}");
    }

    // Validate email with regex for format X@Y.Z
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      throw Exception("Please enter a valid email address");
    }

    // Validate password length and complexity
    final passwordLength = password.length >= 6;
    final containsUppercase = password.contains(RegExp(r'[A-Z]'));
    final containsLowercase = password.contains(RegExp(r'[a-z]'));

    if (!passwordLength || !containsUppercase || !containsLowercase) {
      throw Exception(
          "Password must be at least 6 characters, include both a lowercase and an uppercase letter.");
    }

    // Create user with email and password
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    // Construct user profile
    UserProfile userProfile = UserProfile(
      userId: userCredential.user!.uid,
      name: name,
      familyName: familyName,
      email: email,
      preferredLanguage: preferredLanguage,
    );

    print(firebaseDatabaseURL);
    // Push data to Firebase Realtime Database
    final url = Uri.https(
        firebaseDatabaseURL, 'users/${userCredential.user!.uid}.json');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userProfile.toMap()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to register user profile in the database');
      }
    } catch (e) {
      // Handle the exception, e.g., by logging or rethrowing
      print(e);
    }
  }

  /*
  * Login a user with email and password
  * @param email: user's email
  * @param password: user's password
  * @throws Exception if the email or password is empty
  * @throws Exception if the email is not in the correct format
  * @throws Exception if the password is not at least 6 characters long
  * @throws Exception if the user could not be authenticated
  */
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    // Validate inputs
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email and password cannot be empty");
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      throw Exception("Invalid email format");
    }

    // Validate password length and complexity
    final passwordLength = password.length >= 6;
    final containsUppercase = password.contains(RegExp(r'[A-Z]'));
    final containsLowercase = password.contains(RegExp(r'[a-z]'));

    if (!passwordLength || !containsUppercase || !containsLowercase) {
      throw Exception(
          "Password must be at least 6 characters, include both a lowercase and an uppercase letter.");
    }

    // Authenticate user with email and password
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // The user is now logged in
    } on FirebaseAuthException catch (e) {
      // Handle different FirebaseAuthException cases
      throw Exception(e.message); // Provide a user-friendly error message
    }
  }
}
