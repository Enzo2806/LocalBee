import 'package:flutter/material.dart';
import 'package:local_bee/Model/Constants.dart';
import 'package:local_bee/Views/ViewData/green_button.dart';
import 'package:local_bee/Views/ViewData/white_green_button.dart';
import 'package:local_bee/Views/login_view.dart';
import 'package:local_bee/Views/registration_view.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Image
              Image.asset(
                AppConstants.montrealSustainable,
                height: 300.0,
              ),
              const SizedBox(
                  height: 48.0), // Provide space between the image and the text

              // Add the welcome text
              const Text(
                'Welcome to Local Bee!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                  height:
                      8.0), // Provide space between the text and the buttons

              // Add the subtitle
              const Text(
                'Sustain your city, one point at a time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                  height:
                      48.0), // Provide space between the subtitle and the buttons

              // Add the buttons
              GreenButton(
                text: 'Log In',
                textSize: 16.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInView()),
                  );
                },
              ),
              const SizedBox(height: 16.0), // Provide space between the buttons

              WhiteGreenButton(
                text: 'Register',
                textSize: 16.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationView()),
                  );
                },
                textColor: Colors.green[800]!,
                shadowColor: Colors.green[800]!,
              ),

              const SizedBox(height: 24.0), // Provide additional bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
