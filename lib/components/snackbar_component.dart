import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String message,
      required Color? backgroundColor}) {
  SnackBar snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: backgroundColor,
    duration: Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
