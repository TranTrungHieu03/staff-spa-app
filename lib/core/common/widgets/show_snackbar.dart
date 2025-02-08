import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';

class TSnackBar {
  static hideSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

  static customToast(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(30),
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

  static successSnackBar(BuildContext context,
      {String title = "Success", required String message, int duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Iconsax.check, color: TColors.white),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: TColors.white)),
              if (message.isNotEmpty)
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: THelperFunctions.screenWidth(context) * 0.8),
                  child: Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: TColors.white),
                    maxLines: 3,
                  ),
                )
            ],
          ),
        ],
      ),
      backgroundColor: TColors.primary,
      duration: Duration(seconds: duration),
    ));
  }

  static warningSnackBar(BuildContext context,
      {String title = "Warning", required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Iconsax.warning_2, color: TColors.white),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: TColors.white)),
              if (message.isNotEmpty)
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: THelperFunctions.screenWidth(context) * 0.8),
                  child: Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: TColors.white),
                    maxLines: 3,
                  ),
                )
            ],
          ),
        ],
      ),
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 3),
    ));
  }

  static errorSnackBar(BuildContext context,
      {String title = "Error", required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(Iconsax.warning_2, color: TColors.white),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: TColors.white)),
              if (message.isNotEmpty)
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: THelperFunctions.screenWidth(context) * 0.8),
                  child: Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: TColors.white),
                    maxLines: 3,
                  ),
                )
            ],
          ),
        ],
      ),
      backgroundColor: Colors.red.shade600,
      duration: const Duration(seconds: 3),
    ));
  }
}
