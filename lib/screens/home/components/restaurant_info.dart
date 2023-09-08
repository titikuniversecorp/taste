import 'package:flutter/material.dart';
import 'package:taste/constants.dart';
import 'package:taste/models/restaurant_model.dart';
import 'package:taste/theme/my_theme.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  String get _getDistanse {
    String distanseLabel = 'м'; // TODO: Настроить: "км" или "м" + локализация
    return '${restaurant.distanse ?? 0} $distanseLabel';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: MyTheme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.4),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text(
                          Constants.getWaitTime(restaurant.waitTime),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _getDistanse,
                        style: MyTheme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      if (restaurant.label != null) Text(
                        restaurant.label!,
                        style: MyTheme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(restaurant.logoUrl ?? 'asssets/images/no_image.png', width: 70, height: 70, fit: BoxFit.cover),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  restaurant.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: MyTheme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 25),
              Row(
                children: [
                  Icon(
                    Icons.star_rate_rounded,
                    color: MyTheme.of(context).brandColor,
                  ),
                  Text(
                    (restaurant.score ?? 0).toString(),
                    style: MyTheme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}