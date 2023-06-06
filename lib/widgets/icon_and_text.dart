import 'package:flutter/material.dart';
import 'package:taste/theme/my_theme.dart';

class IconAndText extends StatelessWidget {
  const IconAndText({super.key, required this.icon, required this.text, required this.iconColor, this.padding = EdgeInsets.zero});

  final IconData icon;
  final String text;
  final Color iconColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 5),
          Text(
            text,
            style: MyTheme.of(context).textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14
            )
          )
        ],
      ),
    );
  }
}