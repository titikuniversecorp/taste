import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

import '../../../models/banner_model.dart';
import '../../../theme/my_theme.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    var theme = MyTheme.of(context);
    return Container(
      margin: const Pad(horizontal: 10, vertical: 5),
      // clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.frontColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.maxFinite,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(color: theme.iconColor.withOpacity(.4), strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(20)
              ),
              child: banner.backgroundImageUrl != null ? Image.asset(banner.backgroundImageUrl!, fit: BoxFit.cover,) : const SizedBox(),
            )
          ),
          Padding(
            padding: const Pad(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextOneLine(
                  banner.label,
                  style: theme.textTheme.labelMedium!.copyWith(fontSize: 20),
                ),
                if (banner.description != null) Text(
                  banner.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}