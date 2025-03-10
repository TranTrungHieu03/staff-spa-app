import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:staff_app/core/common/widgets/rounded_icon.dart';
import 'package:staff_app/core/utils/constants/colors.dart';

class TNotificationIcon extends StatelessWidget {
  const TNotificationIcon({super.key, required this.onPressed, required this.iconColor});

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TRoundedIcon(
        icon: Iconsax.alarm,
        color: iconColor,
        size: 30,
        onPressed: onPressed,
        backgroundColor: TColors.primaryBackground,
      ),
      Positioned(
        right: 0,
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(color: TColors.primaryBackground, borderRadius: BorderRadius.circular(100)),
          child: Center(
            child: Text(
              '5+',
              style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.primary, fontSizeFactor: 0.8),
            ),
          ),
        ),
      ),
    ]);
  }
}
