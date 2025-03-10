import 'package:flutter/material.dart';
import 'package:staff_app/core/helpers/helper_functions.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

class TLoader extends StatelessWidget {
  const TLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.white.withOpacity(0.4),
      width: THelperFunctions.screenWidth(context),
      height: THelperFunctions.screenHeight(context),
      child: const Center(
        child: CircularProgressIndicator(
          color: TColors.primary,
        ),
      ),
    );
  }
}
