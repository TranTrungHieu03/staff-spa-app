import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/utils/constants/banners.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_price.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_title.dart';

class TProductBanner extends StatefulWidget {
  const TProductBanner({
    super.key,
  });

  @override
  _TProductBannerState createState() => _TProductBannerState();
}

class _TProductBannerState extends State<TProductBanner> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.6;
    return CarouselSlider(
        carouselController: _carouselController,
        options: CarouselOptions(
          aspectRatio: 1.2,
          viewportFraction: 0.7,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          // enlargeFactor: 1.2,
          onPageChanged: (index, _) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        items: banners
            .map((banner) => Container(
                  decoration: BoxDecoration(),
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.only(bottom: 20),
                  width: width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: TColors.grey, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: TColors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TRoundedImage(
                              imageUrl:
                                  "https://mfparis.vn/wp-content/uploads/2022/09/serum-la-roche-posay-pure-niacinamide-10-30ml.jpg",
                              isNetworkImage: true,
                              fit: BoxFit.contain,
                              onPressed: () => {},
                              width: width * 0.8,
                            ),
                            SizedBox(
                                height: _currentIndex != banners.indexOf(banner)
                                    ? 0
                                    : TSizes.spacebtwItems),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: width * 0.9,
                              ),
                              child: const TProductTitleText(
                                title: 'Green Nike Air Shoes',
                                smallSize: true,
                                maxLines: 1,
                              ),
                            ),
                            const TProductPriceText(price: '35'),
                            SizedBox(
                                height: _currentIndex != banners.indexOf(banner)
                                    ? 0
                                    : TSizes.spacebtwSections),
                          ],
                        ),
                        const Positioned(
                          child: TRoundedIcon(
                            backgroundColor: TColors.primary,
                            icon: Iconsax.add,
                            color: TColors.white,
                          ),
                          bottom: -20,
                        )
                      ],
                    ),
                  ),
                ))
            .toList());
  }
}
