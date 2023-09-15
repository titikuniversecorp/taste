import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste/constants.dart';
import 'package:taste/controllers/restaurant_controller.dart';
import 'package:taste/models/product_model.dart';
import 'package:taste/theme/my_theme.dart';
import 'package:taste/widgets/circle_icon_button.dart';
import 'package:taste/widgets/floating_cart_button.dart';
import 'package:taste/widgets/icon_and_text.dart';
import 'package:taste/widgets/product_quantity_changer.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final ProductModel product;
  late final PageController _pageController;
  double _currentPage = 0.0;
  bool _topFlag = false;

  @override
  void initState() {
    for (var element in Get.find<RestaurantController>().restaurantsList.first.categories!) {
      final findedEl = element.products.firstWhereOrNull((food) => food.id == widget.productId);
      if (findedEl != null) {
        product = findedEl;
        break;
      }
    }
    _pageController = PageController(viewportFraction: 0.6);
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Scaffold(
      backgroundColor: theme.frontColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels <= -50 && _topFlag == false) {
            _topFlag = true;
            Navigator.pop(context);
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: 430,
              toolbarHeight: 80,
              backgroundColor: theme.backgroundColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleIconButton(
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.arrow_back_ios_new,
                  )
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    PageView(
                      scrollDirection: Axis.vertical,
                      controller: _pageController,
                      children: [
                        if (product.galleryImages != null && product.galleryImages!.isNotEmpty) ...product.galleryImages!.map((image) => Hero(
                          tag: 'product-image-$image',
                          child: Image.asset(
                            image,
                            fit: BoxFit.contain,
                          ),
                        ))
                        else Image.asset(
                          'asset/images/no_image.png',
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                    if (product.galleryImages != null && product.galleryImages!.length > 1) Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 80),
                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                        decoration: BoxDecoration(
                          color: theme.frontColor,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(10))
                        ),
                        child: DotsIndicator(
                          axis: Axis.vertical,
                          dotsCount: product.galleryImages!.length,
                          position: _currentPage.round(),
                          decorator: DotsDecorator(
                            activeColor: MyTheme.of(context).brandColor,
                            size: const Size.square(9.0),
                            activeSize: const Size(9.0, 18.0),
                            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Container(
                  width: double.maxFinite,
                  height: 80,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: theme.frontColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(70))
                  ),
                  child: Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: false,
              child: Container(
                color: theme.frontColor,
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          IconAndText(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            icon: Icons.access_time_outlined,
                            text: Constants.getWaitTime(product.waitTime),
                            iconColor: Colors.blue
                          ),
                          IconAndText(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            icon: Icons.fastfood_outlined,
                            text: '${product.weight} г',
                            iconColor: Colors.orange
                          ),
                          // IconAndText(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   icon: Icons.star_outline_rounded,
                          //   text: (product.score ?? 0.0).toString(),
                          //   iconColor: Colors.amber
                          // ),
                          IconAndText(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            icon: Icons.local_fire_department_outlined,
                            text: '${product.calories} ккал',
                            iconColor: Colors.red
                          ),
                        ]
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 43,
                          decoration: BoxDecoration(
                            color: theme.backgroundColor,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: double.maxFinite,
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                decoration: BoxDecoration(
                                  color: theme.backgroundColor,
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      product.price.toStringAsFixed(0),
                                      style: MyTheme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                    Text(
                                      Get.find<RestaurantController>().restaurantsList.first.currency,
                                      style: MyTheme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              ProductQuantityChanger(
                                product: product,
                                showTotalPrice: false,
                                width: 125,
                                height: 43,
                                buttonWidth: 50,
                              )
                              // GetBuilder<CartController>(
                              //   builder: (controller) {
                              //     return Container(
                              //       width: 125,
                              //       height: double.maxFinite,
                              //       decoration: BoxDecoration(
                              //         color: theme.brandColor,
                              //         borderRadius: BorderRadius.circular(30)
                              //       ),
                              //       child: Stack(
                              //         fit: StackFit.expand,
                              //         children: [
                              //           Row(
                              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //             crossAxisAlignment: CrossAxisAlignment.center,
                              //             children: [
                              //               Material(
                              //                 color: Colors.transparent,
                              //                 child: InkWell(
                              //                   onTap: () {
                              //                     Vibrate.feedback(FeedbackType.impact);
                              //                     controller.setProductQuantity(product, false);
                              //                   },
                              //                   borderRadius: BorderRadius.circular(30),
                              //                   child: Container(
                              //                     alignment: Alignment.center,
                              //                     height: double.maxFinite,
                              //                     width: 50,
                              //                     child: Text(
                              //                       '-',
                              //                       style: theme.textTheme.titleMedium!.copyWith(
                              //                         color: Colors.black
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               Material(
                              //                 color: Colors.transparent,
                              //                 child: InkWell(
                              //                   onTap: () {
                              //                     Vibrate.feedback(FeedbackType.impact);
                              //                     controller.setProductQuantity(product, true);
                              //                   },
                              //                   borderRadius: BorderRadius.circular(30),
                              //                   child: Container(
                              //                     alignment: Alignment.center,
                              //                     height: double.maxFinite,
                              //                     width: 50,
                              //                     child: Text(
                              //                       '+',
                              //                       style: theme.textTheme.titleMedium!.copyWith(
                              //                         color: Colors.black
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           Row(
                              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //             children: [
                              //               Container(
                              //                 width: 40,
                              //                 alignment: Alignment.center,
                              //                 decoration: const BoxDecoration(
                              //                   shape: BoxShape.circle,
                              //                   color: Colors.white
                              //                 ),
                              //                 child: Text(
                              //                   controller.getProductQuantity(product).toString(),
                              //                   style: MyTheme.of(context).textTheme.bodySmall!.copyWith(
                              //                     fontSize: 18,
                              //                     fontWeight: FontWeight.bold,
                              //                     color: Colors.black
                              //                   ),
                              //                 )
                              //               )
                              //             ],
                              //           ),
                              //         ],
                              //       )
                              //     );
                              //   }
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            'Ингридиенты',
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 115,
                      width: double.maxFinite,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        scrollDirection: Axis.horizontal,
                        itemCount: product.ingridients!.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 15),
                        itemBuilder: (context, index) {
                          final ingridient = product.ingridients![index];
                          return Container(
                            decoration: BoxDecoration(
                              color: theme.backgroundColor,
                              borderRadius: BorderRadius.circular(40)
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    clipBehavior: Clip.none,
                                    backgroundColor: theme.backgroundColor,
                                    builder: (context) => SizedBox.expand(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            ingridient.imageUrl,
                                            width: 140,
                                            fit: BoxFit.contain,
                                          ),
                                          Text(
                                            ingridient.name,
                                            style: theme.textTheme.titleSmall,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(40),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  constraints: const BoxConstraints(
                                    minWidth: 80,
                                    maxWidth: 80
                                  ),
                                  
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        ingridient.imageUrl,
                                        width: 52,
                                        fit: BoxFit.contain,
                                      ),
                                      IntrinsicWidth(
                                        child: Text(
                                          ingridient.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.labelSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            'Описание',
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.description ?? 'Нет описания',
                              textAlign: TextAlign.start,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 130)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: floatingCartButton(),
    );
  }
}