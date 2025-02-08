import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/grid_layout.dart';
import 'package:spa_mobile/core/common/widgets/notification.dart';
import 'package:spa_mobile/core/common/widgets/primary_header_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/home/presentation/widgets/banner.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_vertical_card.dart';
import 'package:spa_mobile/features/service/presentation/widgets/service_categories.dart';
import 'package:spa_mobile/features/service/presentation/widgets/service_vertical_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: TSizes.defaultSpace / 2,
                ),
                TAppbar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TRoundedImage(
                        imageUrl: TImages.avatar,
                        borderRadius: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: TSizes.defaultSpace / 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getGreetingMessage(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(color: TColors.white),
                            ),
                            Text(
                              "Tran Trung Hieu",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(color: TColors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TNotificationIcon(
                        onPressed: () {}, iconColor: TColors.white),
                    const SizedBox(
                      width: TSizes.sm,
                    ),
                    TRoundedIcon(
                      icon: Iconsax.message,
                      color: TColors.primary,
                      onPressed: () {
                        goChat();
                      },
                    ),
                    const SizedBox(
                      width: TSizes.sm,
                    ),
                  ],
                ),

                // const TSearchHome(),
                const SizedBox(
                  height: TSizes.md * 2,
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: TSizes.defaultSpace,
                  ),
                  Text(AppLocalizations.of(context)!.bannerTitle,
                      style: Theme.of(context).textTheme.titleLarge),
                  const TBanner(),
                  const SizedBox(
                    height: TSizes.defaultSpace,
                  ),
                  Text(AppLocalizations.of(context)!.service_type,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  TServiceCategories(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.featured_service,
                          style: Theme.of(context).textTheme.titleLarge),
                      GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(AppLocalizations.of(context)!.view_all,
                                  style: Theme.of(context).textTheme.bodySmall),
                              const TRoundedIcon(icon: Icons.chevron_right)
                            ],
                          ))
                    ],
                  ),
                  TGridLayout(
                      itemCount: 2,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return const TServiceCard();
                      }),
                  const SizedBox(
                    height: TSizes.md,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.best_selling_product,
                          style: Theme.of(context).textTheme.titleLarge),
                      GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(AppLocalizations.of(context)!.view_all,
                                  style: Theme.of(context).textTheme.bodySmall),
                              const TRoundedIcon(icon: Icons.chevron_right)
                            ],
                          ))
                    ],
                  ),
                  TGridLayout(
                      crossAxisCount: 2,
                      itemCount: 2,
                      itemBuilder: (_, index) => const TProductCardVertical()),
                  const SizedBox(
                    height: TSizes.md,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getGreetingMessage() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return AppLocalizations.of(context)!.helloMorning;
    } else if (hour >= 12 && hour < 14) {
      return AppLocalizations.of(context)!.helloAfternoon;
    } else if (hour >= 14 && hour < 18) {
      return AppLocalizations.of(context)!.helloEvening;
    } else {
      return AppLocalizations.of(context)!.helloNight;
    }
  }
}

class TSearchHome extends StatelessWidget {
  const TSearchHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.md),
      child: GestureDetector(
          onTap: () => goSearch(),
          child: TRoundedContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.md),
                  child: Text(AppLocalizations.of(context)!.search,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                TRoundedIcon(icon: Iconsax.search_favorite)
              ],
            ),
          )),
    );
  }
}
