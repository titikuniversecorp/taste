import 'package:flutter/material.dart';

import '../../../models/restaurant_model.dart';
import '../../../theme/my_theme.dart';
import 'product_item.dart';

class FoodList extends StatefulWidget {
  const FoodList({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: widget.restaurant.categories!.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final category = widget.restaurant.categories!;
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 22),
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // Creates border
                color: MyTheme.of(context).brandColor
              ),
              labelStyle: MyTheme.of(context).textTheme.labelMedium,
              unselectedLabelStyle: MyTheme.of(context).textTheme.labelMedium,
              labelColor: MyTheme.of(context).textTheme.labelMedium!.color,
              unselectedLabelColor: MyTheme.of(context).textTheme.labelMedium!.color,
              tabs: [
                ...category.map((e) => Tab(text: e.name,))
              ]
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ...category.map((c) => ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  itemCount: c.productContainers.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) => ProductItem(productContainer: c.productContainers[index]),
                ))
              ]
            ),
          )
        ],
      ),
    );
  }
}