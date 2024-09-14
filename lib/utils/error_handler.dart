import 'package:flutter/material.dart';

class ErrorHandler {
  // Private constructor to prevent instantiation
  ErrorHandler._();

  // Static method to show error messages using SnackBar
  static void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
