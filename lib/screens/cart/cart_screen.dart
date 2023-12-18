import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taste/controllers/cart_controller.dart';

import '../../controllers/restaurant_controller.dart';
import '../../controllers/user_addresses_comtroller.dart';
import '../../theme/my_theme.dart';
import '../../widgets/icon_and_text.dart';
import '../address_select_screen.dart';
import 'components/product_in_cart_item.dart';

/// Показывает, открыта ли сейчас корзина или нет. Нужно для определения: стоит ли выходить назад при полном обнулении корзины
bool cartIsOpen = false;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _topFlag = false; 

  @override
  void initState() {
    cartIsOpen = true;
    super.initState();
  }

  @override
  void dispose() {
    cartIsOpen = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: GetBuilder<CartController>(
        builder: (controller) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels <= -50 && _topFlag == false) {
                _topFlag = true;
                Navigator.pop(context);
              }
              return true;
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 50,
                    height: 7,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.6),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                ListView(
                  primary: true,
                  padding: const EdgeInsets.only(top: 35, bottom: 10, left: 15, right: 15),
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) => ProductInCartItem(product: controller.items.values.toList()[index].product),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const IconAndText(
                          icon: Icons.access_time_outlined,
                          text: '40 мин',
                          iconColor: Colors.blue
                        ),
                        const IconAndText(
                          icon: Icons.delivery_dining_outlined,
                          text: '0₽',
                          iconColor: Colors.deepOrange
                        ),
                        IconAndText(
                          icon: Icons.fastfood_outlined,
                          text: controller.getTotalWeightAsFormattedString(),
                          iconColor: Colors.orange
                        ),
                      ]
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Промокод',
                              style: theme.textTheme.labelSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, color: theme.textTheme.labelSmall!.color, size: 18)
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<UserAddressesController>(
                      builder: (controller) {
                        var userAddressModel = controller.getCurrentUserAddress();
                        String currentAddress = controller.visitingType == VisitingType.delivery 
                          ? userAddressModel?.shortAddressAsString ?? 'Выберите адрес'
                          : Get.find<RestaurantController>().restaurantsList.firstWhereOrNull((element) => element.address.id == controller.userAddressesRepo.lastSelectedRestorauntAddressId)?.address.shortAddressAsString ?? 'Выберите адрес';
                        return InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              context: context,
                              enableDrag: false,
                              backgroundColor: MyTheme.of(context).backgroundColor,
                              builder: (context) => const AddressSelectScreen(),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: TextOneLine(
                                          currentAddress,
                                          style: theme.textTheme.labelSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
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
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(Icons.arrow_forward_ios_rounded, color: theme.textTheme.labelSmall!.color, size: 18)
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Оплата SberPay  • • • 1302',
                              style: theme.textTheme.labelSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, color: theme.textTheme.labelSmall!.color, size: 18)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        'Итого',
                        style: theme.textTheme.labelSmall!.copyWith(
                          fontSize: 18,
                          height: 0.6
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${controller.getTotalPrice().toStringAsFixed(0)}₽',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 32
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.brandColor,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Vibrate.feedback(FeedbackType.success);
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                            
                            alignment: Alignment.center,
                            child: Text(
                              'Оплатить',
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: Colors.black
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}