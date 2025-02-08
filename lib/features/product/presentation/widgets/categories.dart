import 'package:flutter/material.dart';
import 'package:spa_mobile/core/utils/constants/categories.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class TCategories extends StatefulWidget {
  const TCategories({super.key});

  @override
  _TCategoriesState createState() => _TCategoriesState();
}

class _TCategoriesState extends State<TCategories> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
              vertical: TSizes.sm/2,
            ),
            decoration: BoxDecoration(
              color: isSelected ? TColors.primary : TColors.lightGrey,
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
                categories[index]['name'] ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(color: isSelected ? TColors.white : TColors.black),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: TSizes.spacebtwSections),
      itemCount: categories.length,
    );
  }
}
