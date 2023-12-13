import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../controllers/cart_controller.dart';
import '../controllers/restaurant_controller.dart';
import '../models/product_model.dart';
import '../theme/my_theme.dart';

class ProductQuantityChanger extends StatelessWidget {
  const ProductQuantityChanger({super.key, required this.products, required this.showTotalPrice, this.margin, this.width, this.height, this.buttonWidth, this.popoverDirection});
    // : assert(
    //   showTotalPrice == false && products.length > 1,
    //   'Cannot provide both a showTotalPrice and several products\n'
    //   'To showTotalPrice use single product'
    // );

  final List<ProductModel> products;
  final bool showTotalPrice;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? buttonWidth;
  final PopoverDirection? popoverDirection;

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return GetBuilder<CartController>(
      builder: (controller) {
        final productQuantity = controller.getProductContainerQuantity(products);
        return Container(
          margin: margin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showTotalPrice && products.length == 1) Row(
                children: [
                  Text(
                    (products.first.price * productQuantity).toStringAsFixed(0),
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
                              if (products.length == 1) {
                                controller.setProductQuantity(products.first, isAddition: false);
                              } else {
                                showPopover(
                                  context: context,
                                  bodyBuilder: (context) => ProductVariantSelector(products),
                                  direction: popoverDirection ?? PopoverDirection.left,
                                  backgroundColor: theme.frontColor,
                                  constraints: BoxConstraints(
                                    minHeight: 100,
                                    maxHeight: 300,
                                    minWidth: 100,
                                    maxWidth: MediaQuery.of(context).size.width * 0.55
                                  ),
                                  arrowHeight: 15,
                                  arrowWidth: 30,
                                );
                              }
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
                              if (products.length == 1) {
                                controller.setProductQuantity(products.first, isAddition: true);
                              } else {
                                showPopover(
                                  context: context,
                                  bodyBuilder: (context) => ProductVariantSelector(products),
                                  direction: popoverDirection ?? PopoverDirection.left,
                                  backgroundColor: theme.frontColor,
                                  constraints: BoxConstraints(
                                    minHeight: 100,
                                    maxHeight: 300,
                                    minWidth: 100,
                                    maxWidth: MediaQuery.of(context).size.width * 0.55
                                  ),
                                  arrowHeight: 15,
                                  arrowWidth: 30,
                                );
                              }
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

class ProductVariantSelector extends StatelessWidget {
  const ProductVariantSelector(this.products, {super.key});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    var theme = MyTheme.of(context);
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 6),
      itemBuilder: (context, index) => Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                products[index].variantLabel ?? 'None',
                style: theme.textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              ),
              Row(
                children: [
                  Text(
                    '${products[index].price.toStringAsFixed(0)}${Get.find<RestaurantController>().restaurantsList.first.currency}',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(' • ', style: theme.textTheme.bodySmall),
                  Text(
                    '${products[index].weight} г',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(height: 2)
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          ProductQuantityChanger(
            products: [products[index]],
            showTotalPrice: false,
          )
        ],
      ),
    );
  }
}