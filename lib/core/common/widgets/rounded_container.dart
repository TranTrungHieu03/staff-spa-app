import 'package:flutter/material.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = TSizes.cardRadiusSm,
      this.child,
      this.showBorder = false,
      this.backgroundColor = TColors.white,
      this.borderColor = TColors.borderPrimary,
      this.padding,
      this.shadow = true,
      this.margin});

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
          boxShadow: [
            shadow
                ? BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 0.2,
                    spreadRadius: 0.5,
                  )
                : BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                  ),
          ]),
      child: child,
    );
  }
}
