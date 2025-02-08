import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';

class TNotify {
  static hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static customToast({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: THelperFunctions.isDarkMode(context)
                ? TColors.darkerGrey.withOpacity(0.9)
                : TColors.grey.withOpacity(0.9)),
        child: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    ));
  }

  static successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(
            Iconsax.check,
            color: TColors.white,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
        ],
      ),
      duration: Duration(seconds: duration),
      backgroundColor: TColors.primary,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
    ));
  }

  static warningSnackBar({
    required String title,
    String message = '',
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(
            Iconsax.warning_2,
            color: TColors.white,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
        ],
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.orange,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
    ));
  }

  static errorSnackBar({
    required String title,
    String message = '',
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(
            Iconsax.warning_2,
            color: TColors.white,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
        ],
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red.shade600,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
    ));
  }
}
