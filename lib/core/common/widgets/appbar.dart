import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/helpers/helper_functions.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/device/device_utility.dart';

class TAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TAppbar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Iconsax.arrow_left,
                color: THelperFunctions.isDarkMode(context)
                    ? Colors.white
                    : TColors.black,
              ))
          : leadingIcon != null
              ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
              : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize {
    TDeviceUtils deviceUtils = TDeviceUtils();
    return Size.fromHeight(deviceUtils.getAppBarHeight());
  }
}
