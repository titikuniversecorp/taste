import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/banner_model.dart';
import '../../../widgets/icon_and_text.dart';
import '../../../theme/my_theme.dart';

class BannerStackedItem extends StatelessWidget {
  const BannerStackedItem({super.key, this.banner});

  final BannerModel? banner;

  @override
  Widget build(BuildContext context) {
    if (banner == null) return const SizedBox();
    return Stack(
      children: [
        Container(
          height: 160,
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: double.maxFinite,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: MyTheme.of(context).frontColor
          ),
          child: Image.asset(
            banner!.backgroundImageUrl!,
            fit: BoxFit.cover
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 105,
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: MyTheme.of(context).frontColor,
              boxShadow: [
                BoxShadow(
                  color: MyTheme.of(context).shadowColor.withOpacity(.6),
                  blurRadius: 5,
                  offset: const Offset(0, 5)
                ),
                BoxShadow(
                  color: MyTheme.of(context).frontColor,
                  offset: const Offset(-5, 0)
                ),
                BoxShadow(
                  color: MyTheme.of(context).frontColor,
                  offset: const Offset(5, 0)
                )
              ]
            ),
            child: Container(
              width: double.maxFinite,
              padding: Pad(horizontal: 15, vertical: banner!.linkedProduct == null ? 10 : 3),
              child: Column(
                mainAxisAlignment: banner!.linkedProduct == null ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _frontCardChildren(context)
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _frontCardChildren(BuildContext context) {
    // ignore: curly_braces_in_flow_control_structures
    if (banner!.linkedProduct == null) return [
      TextOneLine(
        banner!.label,
        style: MyTheme.of(context).textTheme.titleSmall,
      ),
      if (banner!.description != null) Flexible(
        child: Text(
          banner!.description!,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: MyTheme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14, fontStyle: FontStyle.italic),
        ),
      ),
    ];
    return [
      Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextOneLine(
              banner!.linkedProduct!.name,
              style: MyTheme.of(context).textTheme.titleSmall,
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: MyTheme.of(context).iconColor,
            )
          ],
        ),
      ),
      Row(
        children: [
          Wrap(
            children: List.generate(5, (index) => Icon(Icons.star, color: MyTheme.of(context).brandColor, size: 15)),
          ),
          const SizedBox(width: 5),
          TextOneLine(
            (banner!.linkedProduct!.score ?? 0).toString(),
            style: MyTheme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: TextOneLine(
              '${banner!.linkedProduct!.commentCount} комментариев',
              overflow: TextOverflow.ellipsis,
              style: MyTheme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
      Row(
        children: [
          IconAndText(
            icon: Icons.access_time,
            text: Constants.getWaitTime(banner!.linkedProduct!.waitTime),
            iconColor: Colors.blue
          ),
          const SizedBox(width: 15),
          IconAndText(
            icon: Icons.currency_ruble_rounded,
            text: banner!.linkedProduct!.price.toStringAsFixed(0),
            iconColor: Colors.green
          )
        ],
      )
    ];
  }
}