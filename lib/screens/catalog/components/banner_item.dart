import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../widgets/icon_and_text.dart';
import '../../../models/product_model.dart';
import '../../../theme/my_theme.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({super.key, required this.food, this.height = 220, this.textHeight = 120});

  final ProductModel food;
  final double height;
  final double textHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: MyTheme.of(context).frontColor
          ),
          child: Image.asset(
            food.imageUrl!,
            fit: BoxFit.contain
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: textHeight,
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: MyTheme.of(context).frontColor,
              boxShadow: [
                BoxShadow(
                  color: MyTheme.of(context).shadowColor,
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
              padding: const EdgeInsets.only(top: 15, left:  15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      food.name,
                      style: MyTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(5, (index) => Icon(Icons.star, color: MyTheme.of(context).brandColor, size: 15)),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        (food.score ?? 0).toString(),
                        style: MyTheme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          '${food.commentCount} комментариев',
                          overflow: TextOverflow.ellipsis,
                          style: MyTheme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      IconAndText(
                        icon: Icons.access_time,
                        text: Constants.getWaitTime(food.waitTime),
                        iconColor: Colors.blue
                      ),
                      const SizedBox(width: 15),
                      IconAndText(
                        icon: Icons.currency_ruble_rounded,
                        text: food.price.toStringAsFixed(0),
                        iconColor: Colors.green
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}