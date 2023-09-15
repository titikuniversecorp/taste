// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';

import '../theme/my_theme.dart';
import 'address_select_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool isWhiteTheme;
  bool _topFlag = false;

  @override
  void initState() {
    if (currentAppTheme == ThemeMode.light) isWhiteTheme = true;
    else isWhiteTheme = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).backgroundColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels <= -50 && _topFlag == false) {
            _topFlag = true;
            Navigator.pop(context);
          }
          return true;
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            // Весь Row - это полоска вверху которая помогает понять что нужно тянуть вниз
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 6,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: MyTheme.of(context).frontColor.withOpacity(.6),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ],
            ),
            const ProfileButtonItem(
              title: 'Мои заказы',
            ),
            ProfileButtonItem(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressSelectScreen(showAppBar: true)));
              },
              title: 'Мои адреса',
            ),
            const ProfileButtonItem(
              title: 'Способы оплаты',
            ),
            const ProfileButtonItem(
              title: 'Статистика',
            ),
            ListTile(
              title: Text(
                'Светлая тема',
                style: MyTheme.of(context).textTheme.bodyMedium,
              ),
              trailing: Switch.adaptive(
                value: isWhiteTheme,
                onChanged: (value) {
                  toggleAppTheme();
                  setState(() {
                    isWhiteTheme = !isWhiteTheme;
                  });
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileButtonItem extends StatelessWidget {
  const ProfileButtonItem({super.key, this.onTap, required this.title});

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: MyTheme.of(context).frontColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: MyTheme.of(context).shadowColor,
              blurRadius: 2,
              // offset: const Offset(0, 1),
            )
          ]
        ),
        child: Row(
          children: [
            Text(
              title,
              style: MyTheme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: MyTheme.of(context).iconColor)
          ],
        ),
      ),
    );
  }
}