import 'package:flutter/material.dart';

class ElevatedButtonComponent extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Color? color;
  final double? width;
  final void Function()? onPressed;

  const ElevatedButtonComponent(
      {super.key,
      this.text,
      required this.onPressed,
      this.color,
      this.icon,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
