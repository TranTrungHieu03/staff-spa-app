import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart'; // Assuming you have a custom widget
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/banners.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/images.dart'; // Assuming you have a color constants file

class TBanner extends StatefulWidget {
  const TBanner({
    super.key,
  });

  @override
  _TBannerState createState() => _TBannerState();
}

class _TBannerState extends State<TBanner> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: (index, _) {
                setState(() {
                  _currentIndex = index;
                });
              },
              autoPlay: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: banners
                .map((banner) => TRoundedImage(
                      imageUrl:
                          TImages.banner1,
                      applyImageRadius: true,
                      isNetworkImage: true,
                      onPressed: () => {},
                      width: THelperFunctions.screenWidth(context) * 0.9,
                    ))
                .toList()),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: banners.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: Container(
                width: _currentIndex == entry.key ? 20.0 : 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: TColors.primary
                        .withOpacity(_currentIndex == entry.key ? 0.9 : 0.2)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
