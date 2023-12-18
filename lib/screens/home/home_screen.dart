import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taste/controllers/user_addresses_comtroller.dart';
import 'package:taste/screens/category/components/product_item.dart';

import '../../controllers/restaurant_controller.dart';
import '../../models/user_address_model.dart';
import '../../theme/my_theme.dart';
import '../../widgets/floating_cart_button.dart';
import '../address_select_screen.dart';
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
  late TabController productsTabController;

  @override
  void initState() {
    super.initState();
    var restaurant = Get.find<RestaurantController>();
    productsTabController = TabController(length: restaurant.currentRestaurant.categories!.length, vsync: this);
    restaurant.addListener(() {
      productsTabController = TabController(length: restaurant.currentRestaurant.categories!.length, vsync: this);
    });
  }

  @override
  void dispose() {
    productsTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.of(context).backgroundColor,
      endDrawer: Drawer(
        backgroundColor: MyTheme.of(context).backgroundColor,
        child: const SafeArea(child: ProfileScreen(isCloseOnDrag: false)),
      ),
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
            actions: const [SizedBox()], // this will hide endDrawer hamburger icon 
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              expandedTitleScale: 1.0,
              title: SizedBox(
                height: 40,
                child: TextField(
                  cursorHeight: 12,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  style: MyTheme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    filled: true,
                    fillColor: MyTheme.of(context).frontColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: MyTheme.of(context).iconColor.withOpacity(.5)
                    ),
                    hintText: 'Поиск',
                    hintStyle: MyTheme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyTheme.of(context).textTheme.bodySmall!.color!.withOpacity(.4)
                    )
                  ),
                ),
              ),
              // title: TextFieldTapRegion(
              //   child: InkWell(
              //     onTap: () {},
              //     borderRadius: BorderRadius.circular(15),
              //     child: Container(
              //       margin: const EdgeInsets.all(1),
              //       padding: const EdgeInsets.symmetric(horizontal: 15),
              //       width: MediaQuery.of(context).size.width,
              //       height: 40,
              //       decoration: BoxDecoration(
              //         color: MyTheme.of(context).frontColor,
              //         borderRadius: BorderRadius.circular(15)
              //       ),
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.search,
              //             color: MyTheme.of(context).iconColor.withOpacity(.5),
              //           ),
              //           const SizedBox(width: 10),
              //           Expanded(
              //             child: TextField(
              //               decoration: InputDecoration(
              //                 contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              //                 border: const OutlineInputBorder(
              //                   borderSide: BorderSide.none
              //                 ),
              //                 hintText: 'Поиск',
              //                 hintStyle: MyTheme.of(context).textTheme.bodySmall!.copyWith(
              //                   color: MyTheme.of(context).textTheme.bodySmall!.color!.withOpacity(.4)
              //                 )
              //               ),
              //             ),
              //           )
              //           // Text(
              //           //   'Поиск',
              //           //   style: MyTheme.of(context).textTheme.bodySmall!.copyWith(
              //           //     color: MyTheme.of(context).textTheme.bodySmall!.color!.withOpacity(.6)
              //           //   ),
              //           // )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              background: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            enableDrag: false,
                            backgroundColor: MyTheme.of(context).backgroundColor,
                            builder: (context) => const AddressSelectScreen(),
                          );
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GetBuilder<UserAddressesController>(
                                builder: (controller) {
                                  AddressModel? userAddressModel = controller.getCurrentUserAddress();
                                  String currentAddress = controller.visitingType == VisitingType.delivery 
                                    ? userAddressModel?.shortAddressAsString ?? 'Выберите адрес'
                                    : Get.find<RestaurantController>().restaurantsList.firstWhereOrNull((element) => element.address.id == controller.userAddressesRepo.lastSelectedRestorauntAddressId)?.address.shortAddressAsString ?? 'Выберите адрес';
                                  return Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: MyTheme.of(context).brandColor,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Text(
                                            controller.visitingType.asString,
                                            style: MyTheme.of(context).textTheme.labelSmall?.copyWith(fontSize: 14, color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: TextOneLine(
                                            currentAddress,
                                            style: MyTheme.of(context).textTheme.labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
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
                    ),
                    // const Spacer(),
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                        // showCupertinoModalBottomSheet(
                        //   context: context,
                        //   enableDrag: false,
                        //   backgroundColor: MyTheme.of(context).backgroundColor,
                        //   builder: (context) => const ProfileScreen(),
                        // );
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
                    return BannerListView(banners: controller.currentRestaurant.banners);
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
                  if (controller.isLoading == false) {
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
                          ...controller.currentRestaurant.categories!.map((e) => Tab(icon: Image.asset(e.backgroundImageUrl!, height: 60), height: 100, text: e.name,))
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
                    itemCount: controller.currentRestaurant.categories!.length,//restaurantModel.foodCategories!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 4
                    ),
                    itemBuilder: (context, index) => CategoryCard3x4(caregory: controller.currentRestaurant.categories![index]),
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
                    itemCount: controller.currentRestaurant.categories!.length,//restaurantModel.foodCategories!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 1
                    ),
                    itemBuilder: (context, index) => CategoryCard3x1(caregory: controller.currentRestaurant.categories![index]),
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
                  ...controller.currentRestaurant.categories!
                    .map((e) => ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, top: 10, left: 15, right: 15),
                      itemCount: e.productContainers.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10,),
                      itemBuilder: (context, index) => ProductItem(productContainer: e.productContainers[index]),
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