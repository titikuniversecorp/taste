import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste/controllers/restaurant_controller.dart';
import 'package:taste/widgets/custom_app_bar.dart';

import '../controllers/user_addresses_comtroller.dart';
import '../models/restaurant_model.dart';
import '../theme/my_theme.dart';
import '../widgets/toggle_button.dart';

class AddressSelectScreen extends StatefulWidget {
  const AddressSelectScreen({super.key, this.showAppBar = false});

  final bool showAppBar;

  @override
  State<AddressSelectScreen> createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {
  _AddressSelectScreenState() {
    Get.find<UserAddressesController>().getUserAddresses();
  }

  bool _topFlag = false;
  final _formKey = GlobalKey<FormState>();
  int? _selectedValue;
  RestaurantModel? selectedRest;

  @override
  Widget build(BuildContext context) {
    var theme = MyTheme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: widget.showAppBar ? null : (notification) {
          if (notification.metrics.pixels <= -50 && _topFlag == false) {
            _topFlag = true;
            Navigator.pop(context);
          }
          return true;
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          physics: widget.showAppBar ? const ClampingScrollPhysics() : null,
          children: [
            if (widget.showAppBar) CustomAppBar(
              margin: const EdgeInsets.only(bottom: 10),
              title: Text(
                'Мои адреса',
                style: theme.textTheme.titleSmall,
              ),
            ),
            GetBuilder<UserAddressesController>(
              builder: (controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ToggleButton(
                      onSelected: (id, instance) {
                        controller.visitingType = VisitingType.values[id];
                      },
                      initialIndex: controller.visitingType.index,
                      width: MediaQuery.of(context).size.width / VisitingType.values.length - 18, // last number is padding in this time
                      height: 40,
                      selectedColor: theme.brandColor,
                      backgroundColor: theme.frontColor,
                      enabledElementStyle: theme.textTheme.labelSmall?.copyWith(color: Colors.black),
                      disabledElementStyle: theme.textTheme.labelSmall,
                      labels: [...VisitingType.values.map((e) => e.asString)],
                    ),
                  ],
                );
              },
            ),
            GetBuilder<UserAddressesController>(
              builder: (addressController) {
                if (addressController.isLoading && addressController.visitingType == VisitingType.delivery) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (addressController.visitingType == VisitingType.delivery) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (addressController.userAdressesList.isNotEmpty) Form(
                        key: _formKey,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: addressController.userAdressesList.length,
                          itemBuilder: (context, index) {
                            _selectedValue = addressController.userAdressesList.indexWhere((element) => element.id == Get.find<UserAddressesController>().getCurrentUserAddress()?.id);
                            return CheckboxListTile.adaptive(
                              value: _selectedValue == index,
                              title: Text(
                                addressController.userAdressesList[index].shortAddressAsString,
                                style: theme.textTheme.bodyMedium
                              ),
                              activeColor: theme.brandColor,
                              onChanged: (value) {
                                setState(() {
                                  // _selectedValue = index;
                                  addressController.setCurrentUserAddress(addressController.userAdressesList[index]);
                                });
                              },
                            );
                          }
                        ),
                      )
                      else Container(
                        margin: const Pad(horizontal: 16, top: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          // color: Colors.redAccent.withOpacity(.6),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Text(
                          'Нет сохраненных адресов.\nДобавьте новый...',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black)
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // todo: open add_new_address_screen
                        },
                        child: const Text(
                          'Добавить новый адрес',
                        )
                      )
                    ],
                  );
                }
                else {
                  return GetBuilder<RestaurantController>(
                    builder: (restController) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (addressController.visitingType == VisitingType.pickup) Container(
                            margin: const Pad(horizontal: 16, top: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.brandColor.withOpacity(.6),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Text(
                              'Забрать заказ нужно будет самостоятельно из выбранного ресторана',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: Colors.black)
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: restController.restaurantsList.length,
                              itemBuilder: (context, index) {
                                selectedRest = restController.restaurantsList.firstWhereOrNull((element) => element.address.id == addressController.currentRestorauntAddressId);
                                return CheckboxListTile.adaptive(
                                  value: selectedRest?.address.id == restController.restaurantsList[index].address.id,
                                  activeColor: theme.brandColor,
                                  title: Text(
                                    restController.restaurantsList[index].address.shortAddressAsString,
                                    style: theme.textTheme.bodyMedium
                                  ),
                                  subtitle: Text(
                                    restController.restaurantsList[index].name,
                                    style: theme.textTheme.bodySmall
                                  ),
                                  onChanged: (value) {
                                    // todo: сделать тут предупреждение, что если добавленный в корзину продукт недоступен в новом ресторане, то его придется выкинуть из коризны
                                    setState(() {
                                      addressController.currentRestorauntAddressId = restController.restaurantsList[index].address.id;
                                    });
                                  },
                                );
                              }
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}