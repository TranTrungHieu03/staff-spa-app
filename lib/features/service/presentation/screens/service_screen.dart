import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/grid_layout.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/service/presentation/widgets/service_vertical_card.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          AppLocalizations.of(context)!.service,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TRoundedIcon(
            icon: Iconsax.ticket,
            onPressed: () => goServiceHistory(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
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
              const SizedBox(
                height: TSizes.md,
              ),
              Container(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final bool isSelected = _selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 80),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.md,
                          vertical: TSizes.sm / 2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? TColors.primary : TColors.lightGrey,
                          borderRadius: BorderRadius.circular(70),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: TColors.primary.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            "Massage",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .apply(
                                    color: isSelected
                                        ? TColors.white
                                        : TColors.black),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spacebtwSections),
                  itemCount: 8,
                ),
              ),
              const SizedBox(
                height: TSizes.md,
              ),
              TGridLayout(
                  itemCount: 8,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return const TServiceCard();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
