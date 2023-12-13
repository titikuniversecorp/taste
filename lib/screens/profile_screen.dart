// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste/controllers/restaurant_controller.dart';

import '../theme/my_theme.dart';
import 'address_select_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.isCloseOnDrag = true});

  final bool isCloseOnDrag;

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
        onNotification: widget.isCloseOnDrag == false ? null : (notification) {
          if (notification.metrics.pixels <= -50 && _topFlag == false) {
            _topFlag = true;
            Navigator.pop(context);
          }
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              // Весь Row - это полоска вверху которая помогает понять что нужно тянуть вниз
              if (widget.isCloseOnDrag) Row(
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
              GetBuilder<RestaurantController>(
                builder: (controller) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 400,
                      minHeight: 100
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (controller.restaurantsList.first.logoUrl != null) ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(controller.restaurantsList.first.logoUrl!, height: MediaQuery.of(context).size.height * 0.15)
                        ),
                        const SizedBox(height: 6),
                        Text(
                          controller.restaurantsList.first.name,
                          style: MyTheme.of(context).textTheme.titleSmall,
                        ),
                        // if (controller.restaurantsList.first.description != null) Text(
                        //   controller.restaurantsList.first.description!,
                        //   textAlign: TextAlign.justify,
                        //   maxLines: 10,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: MyTheme.of(context).textTheme.bodySmall,
                        // ),
                      ],
                    ),
                  );
                },
              ),
              const Spacer(),
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
              ProfileButtonItem(
                onTap: () {},
                title: 'Светлая тема',
                suffixIcon: Switch.adaptive(
                  value: isWhiteTheme,
                  onChanged: (value) {
                    toggleAppTheme();
                    setState(() {
                      isWhiteTheme = !isWhiteTheme;
                    });
                  }
                ),
              ),
              // ListTile(
              //   title: Text(
              //     'Светлая тема',
              //     style: MyTheme.of(context).textTheme.bodyMedium,
              //   ),
              //   trailing: Switch.adaptive(
              //     value: isWhiteTheme,
              //     onChanged: (value) {
              //       toggleAppTheme();
              //       setState(() {
              //         isWhiteTheme = !isWhiteTheme;
              //       });
              //     }
              //   ),
              // )
            ]
          ),
        ),
      ),
    );
  }
}

class ProfileButtonItem extends StatelessWidget {
  const ProfileButtonItem({super.key, this.onTap, this.suffixIcon, required this.title});

  final String title;
  final Widget? suffixIcon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: onTap != null ? MyTheme.of(context).frontColor : MyTheme.of(context).frontColor.withOpacity(.8),
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
              style: onTap != null ? MyTheme.of(context).textTheme.bodyMedium : MyTheme.of(context).textTheme.bodyMedium?.copyWith(color: MyTheme.of(context).textTheme.bodyMedium?.color?.withOpacity(.4)),
            ),
            const Spacer(),
            if (suffixIcon != null) suffixIcon!
            else Icon(Icons.arrow_forward_ios_rounded, color: onTap != null ? MyTheme.of(context).iconColor : MyTheme.of(context).iconColor.withOpacity(.4))
          ],
        ),
      ),
    );
  }
}