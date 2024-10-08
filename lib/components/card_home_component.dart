import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CardHomeComponent extends StatelessWidget {
  final Widget child;
  final IconData? icon;
  final String label;

  const CardHomeComponent({
    super.key,
    required this.child,
    this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: child,
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: Card(
              elevation: 2,
              color: Colors.white,
              margin: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
