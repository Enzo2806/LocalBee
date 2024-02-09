import 'package:flutter/material.dart';
import 'package:local_bee/Views/welcome_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_bee/Views/main_screen.dart';
import 'package:local_bee/Model/constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Load the environment variables from the .env file
  await dotenv.load();

  // Reset the firebaseauth
  // await FirebaseAuth.instance.signOut();

  // Create localShops
  // AppConstants().createSampleShops();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bee Local',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          // If the user is not authenticated, show the WelcomeScreen.
          // If the user is authenticated, show the MainScreen.
          return user == null ? const WelcomeScreen() : const MainScreen();
        }
        // While checking the authentication state, show a loading indicator.
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
