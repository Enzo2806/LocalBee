import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(color: Colors.green[800]),
      ),
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Okay',
            style: TextStyle(
                color: Colors.green[800],
                fontWeight: FontWeight.bold,
                decorationColor: Colors.green[800]),
          ),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
