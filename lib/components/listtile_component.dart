import 'package:flutter/material.dart';

class ListTileComponent extends StatelessWidget {
  final IconData? icon;
  final String label;
  final void Function()? onTap;

  const ListTileComponent({
    super.key,
    this.icon,
    this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListTile(
          dense: false,
          leading: Icon(icon, color: const Color(0xff001F3D), size: 20),
          title: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xff001F3D),
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: onTap),
    );
  }
}
