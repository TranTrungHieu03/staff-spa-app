import 'package:flutter/material.dart';
import 'package:spa_mobile/core/common/widgets/rounded_image.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class TServiceCategories extends StatelessWidget {
  const TServiceCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(6, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TRoundedImage(
                    imageUrl: TImages.massage,
                    backgroundColor: TColors.primary,
                    borderRadius: 60,
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(TSizes.sm / 2),
                  ),
                  Text("Massage",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          }),
        ));
  }
}
