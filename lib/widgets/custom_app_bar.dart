import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'circle_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.leading, this.title, this.actions, this.automaticlyImplLeading = true});

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool automaticlyImplLeading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 25, 
        right: 25,
        bottom: 10
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leading != null) leading!
              else if (automaticlyImplLeading == true) CircleIconButton(
                onTap: () {
                  Get.back();
                },
                icon: CupertinoIcons.back
              ),
              const Spacer(),
              if (actions != null && actions!.isNotEmpty) ...actions!.map((e) => e)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (title != null) title!
            ],
          )
        ],
      ),
    );
  }
}