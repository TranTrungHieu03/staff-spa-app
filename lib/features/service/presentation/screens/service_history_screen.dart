import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/tabbar.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/exports_navigators.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/service/presentation/widgets/status_bar_service.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TAppbar(
          leadingOnPressed: () => goHome(),
          leadingIcon: Iconsax.arrow_left,
          title: Text(
            "Lịch sử đặt lịch",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: TColors.black),
          ),
        ),
        body: NestedScrollView(
          body: const Padding(
            padding: const EdgeInsets.all(TSizes.sm / 2),
            child: TabBarView(
              children: [
                TStatusTabService(),
                TStatusTabService(),
                TStatusTabService(),
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
                      tabs: ["Upcoming", "Done", "Cancel"]
                          .map((category) => Tab(child: Text(category)))
                          .toList()))
            ];
          },
        ),
      ),
    );
  }
}
