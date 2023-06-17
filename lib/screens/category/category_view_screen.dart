import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste/theme/my_theme.dart';
import 'package:taste/widgets/circle_icon_button.dart';
import 'package:taste/widgets/custom_app_bar.dart';

import '../../controllers/restaurant_controller.dart';
import '../../widgets/floating_cart_button.dart';
import 'components/product_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.categoryId});

  final int categoryId;

  @override
  Widget build(BuildContext context) {
    final category = Get.find<RestaurantController>().restaurantsList.first.categories!.firstWhere((element) => element.id == categoryId);
    final theme = MyTheme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            title: Text(
              category.name,
              style: theme.textTheme.titleSmall,
            ),
            actions: [
              CircleIconButton(
                onTap: () {},
                icon: Icons.search
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: category.products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => ProductItem(product: category.products[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: floatingCartButton(),
    );
  }
}