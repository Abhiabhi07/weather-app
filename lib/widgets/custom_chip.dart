import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 35,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 12,
            color: Colors.white70
          ),
        ),
      ],
    );
  }
}
