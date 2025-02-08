import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_checkout.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_price.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppbar(
          showBackArrow: true,
          title: Text(
            AppLocalizations.of(context)!.checkout,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace / 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TContactInformation(),
                SizedBox(
                  height: TSizes.md,
                ),
                TProductCheckout(),
                SizedBox(
                  height: TSizes.md,
                ),
                TPaymentMethod(),
                SizedBox(
                  height: TSizes.md,
                ),
                TPaymentDetail()
              ],
            ),
          ),
        ),
        bottomNavigationBar: const TBottomCheckout());
  }
}

class TPaymentDetail extends StatelessWidget {
  const TPaymentDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      radius: 10,
      padding: const EdgeInsets.all(TSizes.sm),
      borderColor: TColors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.payment_details,
              style: Theme.of(context).textTheme.bodyLarge),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.total_order_amount,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const TProductPriceText(
                    price: "550",
                    isLarge: true,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.shipping_fee,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const TProductPriceText(
                    price: "50",
                    isLarge: true,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.total_payment,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const TProductPriceText(
                    price: "500",
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TPaymentMethod extends StatelessWidget {
  const TPaymentMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      radius: 10,
      padding: const EdgeInsets.all(TSizes.sm),
      borderColor: TColors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.payment_method,
              style: Theme.of(context).textTheme.bodyLarge),
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Iconsax.money_send,
                    color: TColors.primary,
                  ),
                  const SizedBox(
                    width: TSizes.sm,
                  ),
                  Text(AppLocalizations.of(context)!.cash,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  const Icon(
                    Iconsax.tick_circle,
                    color: TColors.primary,
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              Row(
                children: [
                  const Icon(
                    Iconsax.wallet,
                    color: TColors.primary,
                  ),
                  const SizedBox(
                    width: TSizes.sm,
                  ),
                  Text(AppLocalizations.of(context)!.bank_transfer,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  // const TRoundedIcon(
                  //   icon: Iconsax.tick_circle,
                  //   color: TColors.primary,
                  // ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class TContactInformation extends StatelessWidget {
  const TContactInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.sm, vertical: TSizes.md * 2 / 3),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: THelperFunctions.screenWidth(context) * 0.5,
                    ),
                    child: Text(
                      "Tran Trung Hieu",
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                    width: THelperFunctions.screenWidth(context) * 0.3,
                    child: Text(
                      "0837 394 311",
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: THelperFunctions.screenWidth(context) * 0.8,
                child: Text(
                  "147 Hoang Huu Nam, Tan Phu, Thu Duc, HCM",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          ),
          TRoundedIcon(
            icon: Iconsax.edit,
            width: 30,
            size: 20,
            height: 30,
            onPressed: () {
              goShipmentInfo();
            },
          )
        ],
      ),
    );
  }
}

class TBottomCheckout extends StatelessWidget {
  const TBottomCheckout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.sm, vertical: TSizes.sm),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
              onPressed: () => goSuccess(
                  AppLocalizations.of(context)!.paymentSuccessTitle,
                  AppLocalizations.of(context)!.paymentSuccessSubTitle,
                  () => goFeedback(),
                  TImages.success),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.md, vertical: 10),
              ),
              child: Text(
                AppLocalizations.of(context)!.order,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontSize: TSizes.md,
                    ),
              ),
            ),
          ],
        ));
  }
}
