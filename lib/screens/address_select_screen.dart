import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste/widgets/custom_app_bar.dart';

import '../controllers/user_addresses_comtroller.dart';
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
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    var theme = MyTheme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels <= -50 && _topFlag == false) {
            _topFlag = true;
            Navigator.pop(context);
          }
          return true;
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                        controller.setVisitingType(VisitingType.values[id]);
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
              builder: (controller) {
                if (controller.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                return Form(
                  key: _formKey,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.userAdressesList.length,
                    itemBuilder: (context, index) {
                      _selectedValue = controller.userAdressesList.indexWhere((element) => element.id == Get.find<UserAddressesController>().getCurrentUserAddress()?.id);
                      return CheckboxListTile.adaptive(
                        value: _selectedValue == index,
                        title: Text(
                          controller.userAdressesList[index].shortAddressAsString,
                          style: theme.textTheme.bodyMedium
                        ),
                        onChanged: (value) {
                          setState(() {
                            // _selectedValue = index;
                            controller.setCurrentUserAddress(controller.userAdressesList[index]);
                          });
                        },
                      );
                    }
                  ),
                );
              }
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
        ),
      ),
    );
  }
}