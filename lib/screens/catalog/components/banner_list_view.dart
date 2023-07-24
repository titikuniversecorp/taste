import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/banner_model.dart';
import '../../../routes/route_helper.dart';
import '../../../theme/my_theme.dart';
import 'banner_item.dart';
import 'banner_stacked_item.dart';

class BannerListView extends StatefulWidget {
  const BannerListView({super.key, this.banners});

  final List<BannerModel>? banners;

  @override
  State<BannerListView> createState() => _BannerListViewState();
}

class _BannerListViewState extends State<BannerListView> {
  late final PageController _pageController;
  double _currentPage = 0.0;
  final double _scaleFactor = 0.8;
  final double _bannerContainerHeight = 200;

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
    if (widget.banners == null || widget.banners!.isEmpty) return const SizedBox();
    return Column(
      children: [
        SizedBox(
          height: 235,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners!.length,
            itemBuilder: (context, index) {
              Matrix4 matrix = Matrix4.identity();
              if (index == _currentPage.floor()) {
                var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
                var currTrans = _bannerContainerHeight * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              }
              else if (index == _currentPage.floor() + 1) {
                var currScale = _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
                var currTrans = _bannerContainerHeight * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1);
                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              }
              else if (index == _currentPage.floor() - 1) {
                var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
                var currTrans = _bannerContainerHeight * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1);
                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              }
              else {
                var currScale = _scaleFactor;
                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, _bannerContainerHeight * (1 - _scaleFactor) / 2, 1);
              }

              return Transform(
                transform: matrix,
                child: true ? SizedBox(
                  height: _bannerContainerHeight,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.banners![index].linkedProduct != null) Get.toNamed(RouteHelper.product(widget.banners![index].linkedProduct!.id));
                    },
                    child: BannerItem(banner: widget.banners![index])
                  ),
                )
                : SizedBox(
                  height: _bannerContainerHeight,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.banners![index].linkedProduct != null) Get.toNamed(RouteHelper.product(widget.banners![index].linkedProduct!.id));
                    },
                    child: BannerStackedItem(banner: widget.banners?[index])
                  ),
                )
              );
            }
          ),
        ),
        if (widget.banners!.length > 1) DotsIndicator(
          dotsCount: widget.banners!.length,
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