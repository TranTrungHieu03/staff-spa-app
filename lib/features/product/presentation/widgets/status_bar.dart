import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/product_detail.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_price.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_title.dart';

class TStatusTab extends StatelessWidget {
  const TStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    // if (items.isEmpty) {
    //   return const Center(child: Text('Do not have any order here!!'));
    // }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return TRoundedContainer(
          padding: EdgeInsets.all(TSizes.sm),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: THelperFunctions.screenWidth(context) * 0.6),
                    child: Row(
                      children: [
                        Icon(Iconsax.shop),
                        const SizedBox(
                          width: TSizes.spacebtwItems / 2,
                        ),
                        Text(
                          "Innisfree",
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Đang xử lý",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              SizedBox(
                  width: THelperFunctions.screenWidth(context),
                  child: const Divider(
                    thickness: 0.2,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TRoundedImage(
                    imageUrl: TImages.product3,
                    applyImageRadius: true,
                    isNetworkImage: true,
                    onPressed: () => {},
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    width: THelperFunctions.screenWidth(context) * 0.28,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.sm),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: THelperFunctions.screenWidth(context) * 0.6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TProductTitleText(
                            title: TProductDetail.name,
                            maxLines: 2,
                            smallSize: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TProductPriceText(
                                price: TProductDetail.price,
                                currencySign: '\₫',
                              ),
                              Text(
                                "x1",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: TSizes.spacebtwItems,
      ),
      itemCount: 5,
    );
  }
}
