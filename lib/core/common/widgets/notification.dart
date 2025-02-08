import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/rounded_icon.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';

class TNotificationIcon extends StatelessWidget {
  const TNotificationIcon(
      {super.key, required this.onPressed, required this.iconColor});

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TRoundedIcon(
        icon: Iconsax.notification,
        color: iconColor,
        size: 30,
        onPressed: onPressed,
        backgroundColor: TColors.white.withOpacity(0.25),
      ),
      Positioned(
        right: 7,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
              color: TColors.primary, borderRadius: BorderRadius.circular(100)),
          child: Center(
            child: Text(
              '2',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.white, fontSizeFactor: 0.8),
            ),
          ),
        ),
      ),
    ]);
  }
}
