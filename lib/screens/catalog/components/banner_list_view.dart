import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/product_category.dart';
import '../../../routes/route_helper.dart';
import '../../../theme/my_theme.dart';
import 'banner_item.dart';

class BannerListView extends StatefulWidget {
  const BannerListView({super.key, required this.category});

  final ProductCategoryModel category;

  @override
  State<BannerListView> createState() => _BannerListViewState();
}

class _BannerListViewState extends State<BannerListView> {
  late final PageController _pageController;
  double _currentPage = 0.0;
  final double _scaleFactor = 0.8;
  final double _bannerHeight = 290;
  final double _bannerContainerHeight = 200;
  final double _bannerTextHeight = 110;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.85);
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
    return Column(
      children: [
        SizedBox(
          height: _bannerHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.category.foods.length,
            itemBuilder: (context, index) {
              Matrix4 matrix = Matrix4.identity();
              if (index == _currentPage.floor()) {
                var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
                var currTrans = _bannerContainerHeight * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
              }
              else if (index == _currentPage.floor() + 1) {
                var currScale = _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
                var currTrans = _bannerContainerHeight * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1);
                matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
              }
              else if (index == _currentPage.floor() - 1) {
                var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
                var currTrans = _bannerContainerHeight * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1);
                matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
              }
              else {
                var currScale = _scaleFactor;
                matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _bannerContainerHeight * (1 - _scaleFactor) / 2, 1);
              }

              return Transform(
                transform: matrix,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.product(widget.category.foods[index].id));
                  },
                  child: BannerItem(food: widget.category.foods[index], height: _bannerContainerHeight, textHeight: _bannerTextHeight)
                )
              );
            }
          ),
        ),
        DotsIndicator(
          dotsCount: widget.category.foods.length,
          position: _currentPage.round(),
          decorator: DotsDecorator(
            activeColor: MyTheme.of(context).brandColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }
}