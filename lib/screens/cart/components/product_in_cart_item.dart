
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/restaurant_controller.dart';
import '../../../models/product_model.dart';
import '../../../theme/my_theme.dart';
import '../../../widgets/product_quantity_changer.dart';

class ProductInCartItem extends StatelessWidget {
  const ProductInCartItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.frontColor,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(12, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 12,
            spreadRadius: 1
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Hero(
              tag: 'product-image-${product.imageUrl}',
              child: Image.asset(product.imageUrl ?? 'assets/image/no_image.png', fit: BoxFit.fitHeight,)
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: theme.textTheme.labelMedium!.copyWith(height: 1.1),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(0)}${Get.find<RestaurantController>().restaurantsList.first.currency}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(height: 2)
                      ),
                      Text(' • ', style: theme.textTheme.bodySmall),
                      Text(
                        '${product.weight} г',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(height: 2)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ProductQuantityChanger(
            products: [product],
            showTotalPrice: true,
            margin: const EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
}