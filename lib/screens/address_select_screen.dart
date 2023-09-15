import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_addresses_comtroller.dart';
import '../theme/my_theme.dart';

class AddressSelectScreen extends StatefulWidget {
  const AddressSelectScreen({super.key});

  @override
  State<AddressSelectScreen> createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {
  bool _topFlag = false;
  final _formKey = GlobalKey<FormState>();
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    var theme = MyTheme.of(context);
    var mq = MediaQuery.of(context);
    Get.find<UserAddressesController>().getUserAddresses();
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
            Text(
              'Мои адреса',
              style: theme.textTheme.labelMedium,
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
                            Get.find<UserAddressesController>().setCurrentUserAddress(controller.userAdressesList[index]);
                          });
                        },
                      );
                    }
                  ),
                );
              }
            ),
            TextButton(
              onPressed: () {},
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