import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/restaurant_controller.dart';
import '../models/product_model.dart';
import '../theme/my_theme.dart';

class ProductQuantityChanger extends StatelessWidget {
  const ProductQuantityChanger({super.key, required this.product, required this.showTotalPrice, this.margin, this.width, this.height, this.buttonWidth});

  final ProductModel product;
  final bool showTotalPrice;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return GetBuilder<CartController>(
      builder: (controller) {
        final productQuantity = controller.getProductQuantity(product);
        return Container(
          margin: margin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showTotalPrice) Row(
                children: [
                  Text(
                    (product.price * productQuantity).toStringAsFixed(0),
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    Get.find<RestaurantController>().restaurantsList.first.currency,
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
              if (showTotalPrice) const SizedBox(height: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: width ?? 100,
                height: height ?? 35,
                decoration: BoxDecoration(
                  color: productQuantity > 0 ? theme.brandColor : theme.backgroundColor,
                  // border: productQuantity == 0 ? Border.all(color: theme.iconColor.withOpacity(.3), width: 0.5, strokeAlign: BorderSide.strokeAlignOutside) : null,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.setProductQuantity(product, false);
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              alignment: Alignment.center,
                              height: double.maxFinite,
                              width: buttonWidth ?? 40,
                              child: Text(
                                '-',
                                style: theme.textTheme.titleMedium!.copyWith(
                                  color: productQuantity > 0 ? Colors.black : theme.iconColor
                                ),
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              controller.setProductQuantity(product, true);
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              alignment: Alignment.center,
                              height: double.maxFinite,
                              width: buttonWidth ?? 40,
                              child: Text(
                                '+',
                                style: theme.textTheme.titleMedium!.copyWith(
                                  color: productQuantity > 0 ? Colors.black : theme.iconColor
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: (height ?? 37) - 4, // 37
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                          ),
                          child: Text(
                            productQuantity.toString(),
                            style: theme.textTheme.bodySmall!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          )
                        )
                      ],
                    ),
                  ],
                )
              )
            ],
          ),
        );
      }
    );
  }
}