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
import 'package:spa_mobile/features/service/presentation/widgets/related_service.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key, required this.serviceId});

  final String serviceId;

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
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
            icon: Iconsax.heart5,
            color: Colors.red,
          )
        ],
      ),
      body: SingleChildScrollView(
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
                        .map((banner) => TRoundedImage(
                              imageUrl: TImages.thumbnailService,
                              applyImageRadius: false,
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
                      backgroundColor: Colors.transparent,
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
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: THelperFunctions.screenWidth(context) * 0.7,
                        ),
                        child: TProductTitleText(
                          title:
                              "Swedish Massage Swedish Massage Swedish Massage",
                          maxLines: 4,
                        ),
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
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.alarm_on),
                          const SizedBox(
                            width: TSizes.sm,
                          ),
                          Text(
                            "30 mins",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      TProductPriceText(price: "500")
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.md,
                  ),
                  Text("About the service",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Text(
                      "Relaxation: Swedish massage promotes deep relaxation, helping to alleviate tension and reduce stress levels. \nIncreased Circulation: The techniques used stimulate blood flow, which can aid in recovery and improve muscle function. \nPain Relief: It can help relieve muscle soreness and tension, making it an excellent choice for those with chronic pain or discomfort.\nMobility Enhancement: Regular sessions can improve flexibility and range of motion, contributing to overall physical health.",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: TSizes.md,
                  ),
                  Text("Related Service",
                      style: Theme.of(context).textTheme.titleLarge),
                  TRelatedService()
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () => goServiceBooking(),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: TColors.primary,
                ),
                padding: EdgeInsets.all(TSizes.sm / 2),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.book_now,
                  style: Theme.of(context)
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
