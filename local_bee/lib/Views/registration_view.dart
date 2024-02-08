import 'package:flutter/material.dart';
import 'package:local_bee/Controller/user_controller.dart';
import 'package:local_bee/Model/Constants.dart';
import 'package:local_bee/Views/ViewData/text_form_field.dart';
import 'package:local_bee/Views/ViewData/drop_down_form_field.dart';
import 'package:local_bee/Views/ViewData/white_green_button.dart';
import 'package:local_bee/Views/main_screen.dart';
import 'package:local_bee/Views/ViewData/show_error_dialog.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _preferredLanguage = 'EN'; // Default value is english

  final UserController _userController = UserController();

  void _tryRegister() async {
    try {
      await _userController.registerUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        familyName: _familyNameController.text.trim(),
        preferredLanguage: _preferredLanguage,
      );
      // If successful, navigate to the MainScreen or show a success message
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // If there's an error, display it
      // Convert the exception to a string and remove the 'Exception: ' part
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      showErrorDialog(context, 'Registration Failed', errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView to ensure the keyboard does not cover the form fields
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomTextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              labelText: 'Name',
              hintText: 'Enter your name',
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              controller: _familyNameController,
              keyboardType: TextInputType.name,
              labelText: 'Family Name',
              hintText: 'Enter your family name',
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.name,
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
            const SizedBox(height: 20.0),
            CustomDropdownButtonFormField<String>(
              value: _preferredLanguage,
              labelText: 'Preferred Language',
              items: [
                DropdownMenuItem(
                  value: 'EN',
                  child: Row(
                    children: <Widget>[
                      Image.asset(AppConstants.britishFlagPath,
                          width: 24, height: 24),
                      const SizedBox(
                          width: 10), // Space between the flag and the text
                      const Text('EN'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'FR',
                  child: Row(
                    children: <Widget>[
                      Image.asset(AppConstants.frenchFlagPath,
                          width: 24, height: 24),
                      const SizedBox(
                          width: 10), // Space between the flag and the text
                      const Text('FR'),
                    ],
                  ),
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  _preferredLanguage = newValue!;
                });
              },
            ),
            const SizedBox(height: 50.0),
            WhiteGreenButton(
              text: 'Register',
              textSize: 16.0,
              textColor: Colors.green[800]!,
              onPressed: () {
                // Implement registration logic
                _tryRegister();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _familyNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
