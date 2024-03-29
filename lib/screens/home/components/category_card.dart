import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste/routes/route_helper.dart';

import '../../../models/product_category.dart';
import '../../../theme/my_theme.dart';

class CategoryCard3x4 extends StatelessWidget {
  const CategoryCard3x4({super.key, required this.caregory});

  final ProductCategoryModel caregory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.category(caregory.id));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: caregory.backgroundColor != null ? Color(caregory.backgroundColor!) : MyTheme.of(context).frontColor,
          image: caregory.backgroundImageUrl != null ? DecorationImage(
            image: AssetImage(caregory.backgroundImageUrl!),
            fit: BoxFit.cover
          ) : null,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(12, 0, 0, 0),
              offset: Offset(0, 2),
              blurRadius: 12,
              spreadRadius: 1
            )
          ]
        ),
        child: Text(
          caregory.name,
          softWrap: true,
          style: MyTheme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CategoryCard3x1 extends StatelessWidget {
  const CategoryCard3x1({super.key, required this.caregory});

  final ProductCategoryModel caregory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.category(caregory.id));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: caregory.backgroundColor != null ? Color(caregory.backgroundColor!) : MyTheme.of(context).frontColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(24, 0, 0, 0),
              offset: Offset(0, 2),
              blurRadius: 12,
              spreadRadius: 1
            )
          ]
        ),
        child: Stack(
          children: [
            caregory.backgroundImageUrl != null ? Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                caregory.backgroundImageUrl!,
                width: MediaQuery.of(context).size.width * 0.3,
                fit: BoxFit.cover
              ),
            ) : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                caregory.name,
                softWrap: true,
                style: MyTheme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}