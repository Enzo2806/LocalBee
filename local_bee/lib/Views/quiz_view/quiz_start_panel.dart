import 'package:flutter/material.dart';
import 'package:local_bee/Views/ViewData/green_button.dart';
import 'dart:async';

class QuizStartPanel extends StatefulWidget {
  final DateTime quizEndDate;
  final VoidCallback onStartPressed;
  final VoidCallback timerDone;

  const QuizStartPanel({
    super.key,
    required this.quizEndDate,
    required this.onStartPressed,
    required this.timerDone,
  });

  @override
  _QuizStartPanel createState() => _QuizStartPanel();
}

class _QuizStartPanel extends State<QuizStartPanel> {
  Timer? _timer;
  Duration _timeLeft = const Duration();

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    final now = DateTime.now();
    // Convert the quiz end date to local time
    final localQuizEndDate = widget.quizEndDate;

    // Initialize the timeLeft with the difference between the local end date and now
    _timeLeft = localQuizEndDate.difference(now);

    // Only create the timer if there is time left
    if (_timeLeft.inSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        final now = DateTime.now();
        if (now.isAfter(localQuizEndDate)) {
          _timer?.cancel();
          setState(() {
            _timeLeft = Duration.zero;
            widget.timerDone();
          });
        } else {
          setState(() {
            _timeLeft = localQuizEndDate.difference(now);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "New Quiz!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text('Quiz Ends in',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              )),
          const SizedBox(height: 5),
          Text(
            '${_timeLeft.inHours.toString().padLeft(2, '0')} : ${(_timeLeft.inMinutes % 60).toString().padLeft(2, '0')} : ${(_timeLeft.inSeconds % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          GreenButton(
              text: "Start Quiz",
              textSize: 16,
              onPressed: () {
                widget.onStartPressed();
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
