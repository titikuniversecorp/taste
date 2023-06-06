import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taste/controllers/cart_controller.dart';

import '../screens/cart/cart_screen.dart';
import '../theme/my_theme.dart';

Widget? floatingCartButton() {
  double totalPrice = Get.find<CartController>().getTotalPrice();
  final theme = MyTheme.of(Get.context!);

  if (totalPrice == 0) return null;
  return GetBuilder<CartController>(
    builder: (controller) {
      return Hero(
        tag: 'floatingCartButton',
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 46
          ),
          child: RawMaterialButton(
            onPressed: () {
              // Get.toNamed(RouteHelper.cart());
              showCupertinoModalBottomSheet(
                context: Get.context!,
                backgroundColor: theme.backgroundColor,
                topRadius: const Radius.circular(50),
                enableDrag: false,
                builder: (context) => const CartScreen()
              );
            },
            fillColor: MyTheme.of(Get.context!).brandColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                const SizedBox(width: 6),
                Text(
                  '${controller.getTotalPrice().toStringAsFixed(0)}₽',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                  )
                )
              ],
            ),
          ),
        ),
      );
    }
  );
}