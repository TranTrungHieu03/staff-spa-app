import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/product_detail.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/cubit/checkbox_cart_cubit.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_price.dart';
import 'package:spa_mobile/features/product/presentation/widgets/product_title.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckboxCartCubit(),
      child: Scaffold(
        appBar: TAppbar(
          showBackArrow: true,
          title: Text(
            AppLocalizations.of(context)!.cart,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.edit,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(index.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Item deleted')),
                      );
                    },
                    background: Container(
                      color: Colors.redAccent.withOpacity(0.8),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Iconsax.shop_remove,
                            color: Colors.white,
                            size: TSizes.lg,
                          ),
                        ),
                      ),
                    ),
                    child: TProductCart(
                        index: index), // Pass the index to TProductCart
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(
                    height: TSizes.sm,
                  );
                },
                itemCount: 6)),
        bottomNavigationBar: BlocBuilder<CheckboxCartCubit, CheckboxCartState>(
          builder: (context, state) {
            if (state is CheckboxCartInitial) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm, vertical: TSizes.sm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: state.isAllSelected,
                      onChanged: (bool? newValue) {
                        context
                            .read<CheckboxCartCubit>()
                            .toggleSelectAll(newValue ?? false);
                      },
                    ),
                    Text(
                      AppLocalizations.of(context)!.all,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.totalPayment ,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: TSizes.sm/2,),
                        const TProductPriceText(price: "5000"),
                        const SizedBox(width: TSizes.md),
                        ElevatedButton(
                          onPressed: () {
                            goCheckout();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.md, vertical: 10),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.buy,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: TSizes.md,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class TProductCart extends StatelessWidget {
  final int index;

  const TProductCart({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CheckboxCartCubit, CheckboxCartState>(
          builder: (context, state) {
            if (state is CheckboxCartInitial) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm / 2, vertical: TSizes.sm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 0.2,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: Column(
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
                        child: const Divider(thickness: 0.2,)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: state.itemStates[index.toString()] ?? false,
                          onChanged: (bool? newValue) {
                            context
                                .read<CheckboxCartCubit>()
                                .toggleItemCheckbox(
                                    index.toString(), newValue ?? false);
                          },
                        ),
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
                              maxWidth:
                                  THelperFunctions.screenWidth(context) * 0.5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TProductTitleText(
                                  title: TProductDetail.name,
                                  maxLines: 2,
                                  smallSize: true,
                                ),
                                TProductPriceText(
                                  price: TProductDetail.price,
                                  currencySign: '\₫',
                                ),
                                const SizedBox(
                                  height: TSizes.spacebtwItems / 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TRoundedIcon(
                                      icon: Iconsax.minus,
                                      backgroundColor:
                                          TColors.primary.withOpacity(0.05),
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(width: TSizes.sm / 2),
                                    SizedBox(
                                      width: THelperFunctions.screenWidth(
                                              context) *
                                          0.1,
                                      height: THelperFunctions.screenWidth(
                                              context) *
                                          0.1,
                                      child: Form(
                                          child: TextFormField(
                                        initialValue: "1",
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Vui lòng nhập số.";
                                          }
                                          final number = int.tryParse(value);
                                          if (number == null) {
                                            return "Vui lòng nhập số nguyên hợp lệ.";
                                          }
                                          if (number <= 0 || number >= 1000) {
                                            return "Số phải lớn hơn 0 và nhỏ hơn 1000.";
                                          }
                                          return null;
                                        },
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                          contentPadding:
                                              EdgeInsets.all(TSizes.sm),
                                        ),
                                      )),
                                    ),
                                    const SizedBox(width: TSizes.sm / 2),
                                    TRoundedIcon(
                                      icon: Iconsax.add,
                                      width: 40,
                                      backgroundColor:
                                          TColors.primary.withOpacity(0.05),
                                      height: 40,
                                    ),
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
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
