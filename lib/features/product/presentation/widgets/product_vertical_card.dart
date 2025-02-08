import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/styles/shadow_styles.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/product_detail.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_price.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_title.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final width = THelperFunctions.screenWidth(context) * 0.4;
    return GestureDetector(
      onTap: () => goProductDetail("1"),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkerGrey : TColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TRoundedContainer(
              height: 180,
              width: width + 15,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  TRoundedImage(
                    width: width,
                    imageUrl: TImages.product1,
                    applyImageRadius: true,
                    fit: BoxFit.contain,
                  ),
                  // Positioned(
                  //   top: 12,
                  //   child: TRoundedContainer(
                  //     radius: TSizes.sm,
                  //     backgroundColor: TColors.secondary.withOpacity(0.8),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: TSizes.sm, vertical: TSizes.xs),
                  //     child: Text(
                  //       '25%',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .labelLarge!
                  //           .apply(color: TColors.black),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spacebtwItems / 2,
            ),

            //details

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: width,
                        ),
                        child: const TProductTitleText(
                          title: 'Green Nike Air Shoes Green Nike Air Shoes',
                          smallSize: true,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spacebtwItems / 2,
                      ),
                      // TBrandTitleWithVerifiedIcon(title: 'Nike'),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Price
                const Padding(
                  padding: EdgeInsets.all(TSizes.sm),
                  child: TProductPriceText(price: "35"),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(
                        Iconsax.add,
                        color: TColors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
