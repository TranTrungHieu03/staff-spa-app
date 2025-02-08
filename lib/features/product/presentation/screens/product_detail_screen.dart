import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/banners.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/product_detail.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_price.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_title.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CarouselSliderController _carouselController =
  CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        actions: [
          TRoundedIcon(
            icon: Iconsax.shopping_bag,
            size: 30,
            onPressed: () => goCart(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                          pageSnapping: true,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          scrollPhysics: const BouncingScrollPhysics(),
                          onPageChanged: (index, _) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          aspectRatio: 3 / 2),
                      items: banners
                          .map((banner) =>
                          TRoundedImage(
                            imageUrl: TImages.product3,
                            applyImageRadius: true,
                            isNetworkImage: true,
                            onPressed: () => {},
                            width: THelperFunctions.screenWidth(context),
                          ))
                          .toList()),
                  if (_currentIndex > 0)
                    Positioned(
                      left: 0,
                      child: TRoundedIcon(
                        icon: Iconsax.arrow_left_2,
                        onPressed: () {
                          _carouselController.previousPage();
                        },
                      ),
                    ),
                  if (_currentIndex < banners.length - 1)
                    Positioned(
                      right: 0,
                      child: TRoundedIcon(
                        icon: Iconsax.arrow_right_34,
                        onPressed: () {
                          _carouselController.nextPage();
                        },
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TProductDetail.category,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  TRoundedContainer(
                    radius: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.star,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: TSizes.sm,
                          ),
                          Text(TProductDetail.rate)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              TProductTitleText(
                title: TProductDetail.name,
                maxLines: 4,
              ),
              const SizedBox(
                height: TSizes.spacebtwItems / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TProductPriceText(price: TProductDetail.price),
                  Text(
                    TProductDetail.ml + " ml",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  )
                ],
              ),
              const SizedBox(
                height: TSizes.spacebtwItems / 2,
              ),
              Text(TProductDetail.content),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 55,
                  padding: EdgeInsets.all(TSizes.sm / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.bag_tick,
                        color: TColors.primary,
                      ),
                      Text(
                        AppLocalizations.of(context)!.addToCart,
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelMedium,
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                goCheckout();
              },
              child: Container(
                height: 55,
                decoration: const BoxDecoration(
                  color: TColors.primary,
                ),
                padding: EdgeInsets.all(TSizes.sm / 2),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.buyNow,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
