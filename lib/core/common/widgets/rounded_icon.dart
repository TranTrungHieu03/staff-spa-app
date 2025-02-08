import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';

class TRoundedIcon extends StatelessWidget {
  const TRoundedIcon(
      {super.key,
      this.height,
      this.width,
      this.size = TSizes.lg,
      required this.icon,
      this.color,
      this.borderRadius = 100,
      this.backgroundColor,
      this.onPressed});

  final double? height, width, size;
  final double borderRadius;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (dark
                ? Colors.black.withOpacity(0.9)
                : Colors.white.withOpacity(0.9)),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
