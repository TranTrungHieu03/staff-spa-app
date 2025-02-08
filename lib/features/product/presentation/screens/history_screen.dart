import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/tabbar.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/product/presentation/widgets/status_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TAppbar(
          leadingOnPressed: () => goHome(),
          leadingIcon: Iconsax.arrow_left,
          title: Text(
            "Lịch sử đặt hàng",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: TColors.black),
          ),
        ),
        body: NestedScrollView(
          body: const Padding(
            padding: const EdgeInsets.all(TSizes.sm/2),
            child: TabBarView(
              children: [
                TStatusTab(),
                TStatusTab(),
                TStatusTab(),
              ],
            ),
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  expandedHeight: 0,
                  flexibleSpace: const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                  ),
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,
                  bottom: TTabBar(
                      tabs: ['Processing', 'Completed', 'Cancel']
                          .map((category) => Tab(child: Text(category)))
                          .toList()))
            ];
          },
        ),
      ),
    );
  }
}
