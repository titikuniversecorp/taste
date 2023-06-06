import 'package:flutter/material.dart';
import 'package:taste/theme/my_theme.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.icon, this.onTap});

  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyTheme.of(context).frontColor
        ),
        child: Icon(
          icon,
          color: MyTheme.of(context).iconColor
        ),
      ),
    );
  }
}