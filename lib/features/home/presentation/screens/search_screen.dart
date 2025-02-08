import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/appbar.dart';
import 'package:spa_mobile/core/common/widgets/rounded_container.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.sm),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search ...",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: TSizes.md),
                  suffixIcon: const TRoundedIcon(icon: Iconsax.search_favorite),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: TSizes.sm,
              ),
              SizedBox(
                width: THelperFunctions.screenWidth(context),
                height: THelperFunctions.screenHeight(context) * 0.8,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(6, (index) {
                    return GestureDetector(
                      child: TRoundedContainer(
                        radius: 0,
                        shadow: false,
                        padding:
                            const EdgeInsets.symmetric(horizontal: TSizes.md),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${_searchController.text}$index",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const TRoundedIcon(
                                  icon: Icons.chevron_right,
                                  color: TColors.primary,
                                )
                              ],
                            ),
                            SizedBox(
                                height: 1,
                                width: THelperFunctions.screenWidth(context),
                                child: const Divider(
                                  thickness: 0.2,
                                )),
                          ],
                        ),
                      ),
                      onTap: () {
                        _searchController.text =
                            "${_searchController.text}$index";
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
