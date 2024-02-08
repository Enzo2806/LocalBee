import 'package:flutter/material.dart';
import 'package:local_bee/Views/ViewData/green_button.dart';
import 'package:local_bee/Views/ViewData/text_form_field.dart';
import 'package:local_bee/Views/main_screen.dart';
import 'package:local_bee/Views/ViewData/show_error_dialog.dart';
import 'package:local_bee/Controller/user_controller.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  _LogInViewState createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController _userController = UserController();

  void _tryLogin() async {
    try {
      await _userController.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // If successful, navigate to the MainScreen or show a success message
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // If there's an error, display it using your reusable error dialog
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      showErrorDialog(context, 'Login Failed', errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
            const SizedBox(height: 50.0),
            GreenButton(
              text: 'Log In',
              textSize: 16.0,
              horizontalPadding: 60.0,
              onPressed: () {
                _tryLogin();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
