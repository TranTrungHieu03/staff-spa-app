import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/grid_layout.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/categories.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_banner.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_vertical_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppbar(
          title: Text(
            'Product',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: TColors.black),
          ),
          actions: const [
            TRoundedIcon(
              icon: Iconsax.shopping_bag,
              size: 30,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Luxury of Skincare",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "Curated for You",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: TSizes.sm,
                ),
                const SizedBox(height: 40, child: TCategories()),
                const SizedBox(
                  height: TSizes.spacebtwItems,
                ),
                TProductBanner(),
                const SizedBox(
                  height: TSizes.spacebtwSections,
                ),
                Text(
                  "Popular",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: TSizes.sm,
                ),
                TGridLayout(
                    crossAxisCount: 2,
                    itemCount: 6,
                    itemBuilder: (_, index) => const TProductCardVertical()),
              ],
            ),
          ),
        ));
  }
}
