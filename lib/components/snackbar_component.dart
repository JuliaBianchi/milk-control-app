import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String message,
      required Color? backgroundColor}) {
  SnackBar snackBar = SnackBar(
    content: Container(
      padding: EdgeInsets.all(10),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        textAlign: TextAlign.center,
      ),
    ),
    backgroundColor: backgroundColor,
    duration: Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
   
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
