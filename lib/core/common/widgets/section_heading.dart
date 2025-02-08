import 'package:flutter/material.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading(
      {super.key,
      this.onPressed,
      this.textColor,
      this.buttonTitle = 'View all',
      required this.title,
      this.showActionButton = true});

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(
                  color: textColor ??
                      (THelperFunctions.isDarkMode(context)
                          ? TColors.white
                          : TColors.black))
              .copyWith(fontWeight: FontWeight.w800),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: const TextStyle(color: TColors.primary),
              ))
      ],
    );
  }
}
