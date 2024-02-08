import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  final String text;
  final double textSize;
  final VoidCallback onPressed;
  final double horizontalPadding;

  const GreenButton({
    super.key,
    required this.text,
    required this.textSize,
    required this.onPressed,
    this.horizontalPadding = 30.0, // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding), // Added padding
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(1), //  shadow opacity
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Round edges
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
