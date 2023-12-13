import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/restaurant_controller.dart';
import '../../../models/product_category.dart';
import '../../../routes/route_helper.dart';
import '../../../theme/my_theme.dart';
import '../../../widgets/product_quantity_changer.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productContainer});

  final ProductContainerModel productContainer;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.product(productContainer.id));
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // height: 105,
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
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: Hero(
                tag: 'product-image-${productContainer.products.first.imageUrl}',
                child: Image.asset(productContainer.products.first.imageUrl ?? 'assets/image/no_image.png', fit: BoxFit.fitHeight,)
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            productContainer.products.first.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium!.copyWith(height: 1.5),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: theme.iconColor,
                        )
                      ],
                    ),
                    IntrinsicWidth(
                      child: Text(
                        productContainer.products.first.about ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: productContainer.products.first.highLight ? theme.brandColor : theme.textTheme.bodySmall!.color
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '${productContainer.products.first.price.toStringAsFixed(0)}${Get.find<RestaurantController>().restaurantsList.first.currency}',
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        Text(' • ', style: theme.textTheme.bodySmall),
                        Text(
                          '${productContainer.products.first.weight} г',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall!.copyWith(height: 2)
                        ),
                        const Spacer(),
                        ProductQuantityChanger(
                          product: productContainer.products.first,
                          showTotalPrice: false
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}