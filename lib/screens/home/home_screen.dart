import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taste/screens/category/category_view_screen.dart';
import 'package:taste/screens/category/components/product_item.dart';

import '../../controllers/restaurant_controller.dart';
import '../../theme/my_theme.dart';
import '../../widgets/floating_cart_button.dart';
import '../profile_screen.dart';
import 'components/banner_list_view.dart';
import 'components/category_card.dart';

enum HomeScreenUIVariant {
  category3x4,
  caregory3x1,
  listTab
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeScreenUIVariant homeScreenUIVariant = HomeScreenUIVariant.listTab;
  TabController? productsTabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var restaurans = await Get.find<RestaurantController>().getRestaurans();
      setState(() {
        productsTabController = TabController(length: restaurans.first.categories!.length, vsync: this);
      });
    });
  }

  @override
  void dispose() {
    productsTabController?.dispose();
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GetBuilder<RestaurantController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return const CircularProgressIndicator.adaptive();
                  } 
                  else {
                    return BannerListView(banners: controller.restaurantsList.first.banners);
                  }
                }
              )
            ),
          ),
          if (homeScreenUIVariant == HomeScreenUIVariant.listTab) SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeader(
              extent: 100,
              widget: GetBuilder<RestaurantController>(
                builder: (controller) {
                  if (controller.isLoading == false && productsTabController != null) {
                    return Theme(
                      data: MyTheme.of(context).themeData.copyWith(
                        colorScheme: MyTheme.of(context).themeData.colorScheme.copyWith(surfaceVariant: Colors.transparent) // Это чтобы убрать подчёркивание постоянное у всех элементов tabbar
                      ),
                      child: TabBar(
                        isScrollable: true,
                        controller: productsTabController,
                        indicatorColor: MyTheme.of(context).brandColor,
                        indicatorPadding: EdgeInsets.zero,
                        // indicator: BoxDecoration(
                        //   color: MyTheme.of(context).brandColor.withOpacity(.5),
                        //   borderRadius: BorderRadius.circular(10),
                        //   border: Border.all(color: Colors.transparent)
                        // ),
                        indicatorWeight: 2,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: MyTheme.of(context).textTheme.bodyMedium!.color,
                        unselectedLabelColor: MyTheme.of(context).textTheme.bodyMedium!.color!.withOpacity(.54),
                        tabs: [
                          ...controller.restaurantsList.first.categories!.map((e) => Tab(icon: Image.asset(e.backgroundImageUrl!, height: 60), height: 100, text: e.name,))
                        ]
                      ),
                    );
                  }
                  return const CircularProgressIndicator.adaptive();
                }
              ),
            )
          )
        ],
        body: _getBody()
      ),
      floatingActionButton: floatingCartButton()
    );
  }

  Widget _getBody() {
    switch (homeScreenUIVariant) {
      case HomeScreenUIVariant.category3x4:
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
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
                    itemCount: controller.restaurantsList.first.categories!.length,//restaurantModel.foodCategories!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 4
                    ),
                    itemBuilder: (context, index) => CategoryCard3x4(caregory: controller.restaurantsList.first.categories![index]),
                  );
                }
              }
            )
          ],
        );
      case HomeScreenUIVariant.caregory3x1:
        return ListView(
          padding: EdgeInsets.zero,
          children: [
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
                    itemCount: controller.restaurantsList.first.categories!.length,//restaurantModel.foodCategories!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 1
                    ),
                    itemBuilder: (context, index) => CategoryCard3x1(caregory: controller.restaurantsList.first.categories![index]),
                  );
                }
              }
            )
          ],
        );
      case HomeScreenUIVariant.listTab:
        return GetBuilder<RestaurantController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const CircularProgressIndicator.adaptive();
            } 
            else {
              return TabBarView(
                controller: productsTabController,
                children: [
                  ...controller.restaurantsList.first.categories!
                    .map((e) => ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, top: 10, left: 15, right: 15),
                      itemCount: e.products.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10,),
                      itemBuilder: (context, index) => ProductItem(product: e.products[index]),
                    ))
                ]
              );
            }
          }
        );
      default:
        return const Text(
          'Ошибка: HomeScreenUIVariant not selected'
        );
    }
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double extent;

  PersistentHeader({required this.widget, this.extent = 56});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: extent,
      decoration: BoxDecoration(
        color: MyTheme.of(context).backgroundColor,
      ),
      child: Center(child: widget)
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}