import 'package:flutter/material.dart';

class WhiteGreenButton extends StatelessWidget {
  final String text;
  final double textSize;
  final VoidCallback onPressed;
  final Color textColor;
  final Color shadowColor;
  final double horizontalPadding;

  const WhiteGreenButton({
    super.key,
    required this.text,
    this.textSize = 16.0, // Default text size if not provided
    required this.onPressed,
    this.textColor = Colors.green, // Default text color
    this.shadowColor = Colors.green, // Default shadow color
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
          backgroundColor: Colors.white, // White background
          foregroundColor: textColor,
          shadowColor: shadowColor.withOpacity(0.5), //  shadow opacity
          elevation: 5, // The elevation gives the button a shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Round edges
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
