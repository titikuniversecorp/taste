import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/my_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              toggleAppTheme();
            },
            icon: currentAppTheme == ThemeMode.light ? const Icon(CupertinoIcons.light_max) : const Icon(CupertinoIcons.light_min),
          )
        ],
      ),
    );
  }
}