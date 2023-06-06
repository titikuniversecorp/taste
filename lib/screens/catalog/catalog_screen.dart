import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../controllers/restaurant_controller.dart';
import '../../theme/my_theme.dart';
import '../../widgets/floating_cart_button.dart';
import '../profile_screen.dart';
import 'components/banner_list_view.dart';
import 'components/category_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    Get.find<RestaurantController>().getRestaurans();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            forceElevated: innerBoxIsScrolled,
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 110,
            automaticallyImplyLeading: false,
            backgroundColor: MyTheme.of(context).backgroundColor,
            // surfaceTintColor: MyTheme.of(context).backgroundColor,
            elevation: 0,
            shape: ShapeBorder.lerp(RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)), null, 0),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              expandedTitleScale: 1.0,
              title: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  margin: const EdgeInsets.all(1),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: MyTheme.of(context).frontColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: MyTheme.of(context).iconColor.withOpacity(.5),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Поиск',
                        style: MyTheme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyTheme.of(context).textTheme.bodySmall!.color!.withOpacity(.6)
                        ),
                      )
                    ],
                  ),
                ),
              ),
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Агеева, 1А',
                              style: MyTheme.of(context).textTheme.labelMedium,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: MyTheme.of(context).iconColor.withOpacity(.7),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => const ProfileScreen(),
                        );
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        child: Icon(
                          CupertinoIcons.profile_circled,
                          color: MyTheme.of(context).iconColor.withOpacity(.8),
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GetBuilder<RestaurantController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return const CircularProgressIndicator.adaptive();
                  } 
                  else {
                    return BannerListView(category: controller.restaurantsList.first.foodCategories!.first);
                  }
                }
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(
                'Категории',
                textAlign: TextAlign.left,
                style: MyTheme.of(context).textTheme.titleMedium,
              ),
            ),
            GetBuilder<RestaurantController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                } 
                else {
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.restaurantsList.first.foodCategories!.length,//restaurantModel.foodCategories!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 4
                    ),
                    itemBuilder: (context, index) => CategoryCard(caregory: controller.restaurantsList.first.foodCategories![index]),
                  );
                }
              }
            )
          ],
        )
      ),
      floatingActionButton: floatingCartButton()
    );
  }
}