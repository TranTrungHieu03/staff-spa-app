import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_price.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_title.dart';

class BookingServiceScreen extends StatefulWidget {
  const BookingServiceScreen({super.key});

  @override
  State<BookingServiceScreen> createState() => _BookingServiceScreenState();
}

class _BookingServiceScreenState extends State<BookingServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(TSizes.sm),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selected Service",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              TRoundedContainer(
                shadow: true,
                padding: EdgeInsets.all(TSizes.sm),
                radius: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TRoundedImage(
                          applyImageRadius: true,
                          imageUrl: TImages.thumbnailService,
                          isNetworkImage: true,
                          width: THelperFunctions.screenWidth(context) * 0.2,
                          height: THelperFunctions.screenWidth(context) * 0.2,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: TSizes.md,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    THelperFunctions.screenWidth(context) * 0.6,
                              ),
                              child: TProductTitleText(
                                title: "Service Name 1",
                                maxLines: 1,
                              ),
                            ),
                            TProductPriceText(
                              price: "150",
                            ),
                          ],
                        )
                      ],
                    ),
                    Text("30 mins"),
                    Text("Relaxing full body"),
                    Text("6-step process. Includes 10-min massage"),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.md,
              ),
              Text(
                "Related Services",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              TRoundedContainer(
                shadow: true,
                padding: EdgeInsets.all(TSizes.sm),
                radius: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TRoundedImage(
                      applyImageRadius: true,
                      imageUrl: TImages.thumbnailService,
                      isNetworkImage: true,
                      width: THelperFunctions.screenWidth(context) * 1,
                      height: THelperFunctions.screenWidth(context) * 0.5,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    THelperFunctions.screenWidth(context) * 0.7,
                              ),
                              child: TProductTitleText(
                                title: "Service Name 1",
                                maxLines: 1,
                              ),
                            ),
                            TProductPriceText(
                              price: "150",
                            ),
                          ],
                        ),
                        TRoundedContainer(
                          shadow: true,
                          radius: 20,
                          backgroundColor: TColors.primary,
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: TSizes.sm, horizontal: TSizes.md),
                              child: Row(
                                children: [
                                  Icon(Iconsax.add),
                                  Text("Add"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text("30 mins"),
                    Text("Relaxing full body"),
                    Text("6-step process. Includes 10-min massage"),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              TRoundedContainer(
                shadow: true,
                padding: EdgeInsets.all(TSizes.sm),
                radius: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TRoundedImage(
                      applyImageRadius: true,
                      imageUrl: TImages.thumbnailService,
                      isNetworkImage: true,
                      width: THelperFunctions.screenWidth(context) * 1,
                      height: THelperFunctions.screenWidth(context) * 0.5,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    THelperFunctions.screenWidth(context) * 0.7,
                              ),
                              child: TProductTitleText(
                                title: "Service Name 1",
                                maxLines: 1,
                              ),
                            ),
                            TProductPriceText(
                              price: "150",
                            ),
                          ],
                        ),
                        TRoundedContainer(
                          shadow: true,
                          radius: 20,
                          backgroundColor: TColors.primary,
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: TSizes.sm, horizontal: TSizes.md),
                              child: Row(
                                children: [
                                  Icon(Iconsax.add),
                                  Text("Add"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text("30 mins"),
                    Text("Relaxing full body"),
                    Text("6-step process. Includes 10-min massage"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(TSizes.sm),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.totalPayment,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: TSizes.sm / 2,
                ),
                const TProductPriceText(price: "5000"),
                const SizedBox(width: TSizes.md),
                ElevatedButton(
                  onPressed: () {
                    goServiceCheckout();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.md, vertical: 10),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.buy,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: TSizes.md,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
