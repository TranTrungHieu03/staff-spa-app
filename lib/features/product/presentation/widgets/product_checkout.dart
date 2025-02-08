import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/product_detail.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_title.dart';

import 'product_price.dart';

class TProductCheckout extends StatelessWidget {
  const TProductCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.sm, vertical: TSizes.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 0.2,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Iconsax.shop),
              const SizedBox(
                width: TSizes.spacebtwItems / 2,
              ),
              Text(
                "Innisfree",
                style: Theme.of(context).textTheme.titleLarge,
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
          const SizedBox(
            height: TSizes.sm,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.shop_voucher,
                  style: Theme.of(context).textTheme.bodyMedium),
              GestureDetector(
                  onTap: () {
                    _showVoucherModal(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppLocalizations.of(context)!.select_or_enter_code,
                          style: Theme.of(context).textTheme.bodySmall),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                    ],
                  ))
            ],
          ),
          const SizedBox(
            height: TSizes.sm,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.message_to_shop,
                  style: Theme.of(context).textTheme.bodyMedium),
              GestureDetector(
                  onTap: () {
                    _showMessageModal(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppLocalizations.of(context)!.leave_a_message,
                          style: Theme.of(context).textTheme.bodySmall),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      )
                    ],
                  ))
            ],
          ),
          const SizedBox(
            height: TSizes.sm,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.shipping_carrier,
                  style: Theme.of(context).textTheme.bodyMedium),
              Text("Giao hàng nhanh",
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.total_amount,
                  style: Theme.of(context).textTheme.bodyMedium),
              const TProductPriceText(
                price: "550",
              )
            ],
          ),
          const SizedBox(
            height: TSizes.sm,
          ),
        ],
      ),
    );
  }
}

void _showVoucherModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: TSizes.md,
          right: TSizes.md,
          top: TSizes.md,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.shop_voucher,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your voucher code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Available Vouchers",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: false,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return _buildVoucherItem(context, index);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildVoucherItem(BuildContext context, int index) {
  final voucherTitles = [
    "10% Off for First Order",
    "Free Shipping on Orders Over \$50",
    "Buy 2 Get 1 Free",
    "Buy 3 Get 1 Free",
    "Buy 5 Get 2 Free",

  ];
  final voucherCodes = ["FIRST10", "FREE_SHIP50", "B2G1FREE","B3G1FREE","B5G2FREE"];

  return Card(
    margin: const EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      leading: const Icon(
        Icons.local_offer,
        color: Colors.green,
      ),
      title: Text(voucherTitles[index]),
      subtitle: Text("Code: ${voucherCodes[index]}"),
      trailing: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.md, vertical: 10),
        ),
        child: Text(
          AppLocalizations.of(context)!.apply,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: TSizes.md,
              ),
        ),
      ),
    ),
  );
}

void _showMessageModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: TSizes.md,
          right: TSizes.md,
          top: TSizes.md,
          bottom: MediaQuery.of(context).viewInsets.bottom + TSizes.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.message_to_shop,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Enter your massage",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.md, vertical: 10),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontSize: TSizes.md,
                          ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
