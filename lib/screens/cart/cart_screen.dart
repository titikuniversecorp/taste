import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:taste/controllers/cart_controller.dart';

import '../../theme/my_theme.dart';
import '../../widgets/icon_and_text.dart';
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
                  padding: EdgeInsets.only(top: Get.mediaQuery.padding.top + 10, bottom: 10, left: 15, right: 15),
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
                    GestureDetector(
                      onTap: () {},
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
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Агеева, 1А',
                              style: theme.textTheme.labelSmall!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, color: theme.textTheme.labelSmall!.color, size: 18)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
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