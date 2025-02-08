import 'package:flutter/material.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';

class TLoader extends StatelessWidget {
  const TLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.white.withOpacity(0.4),
      width: THelperFunctions.screenWidth(context),
      height: THelperFunctions.screenHeight(context),
      child: Center(
        child: const CircularProgressIndicator(
          color: TColors.primary,
        ),
      ),
    );
  }
}
