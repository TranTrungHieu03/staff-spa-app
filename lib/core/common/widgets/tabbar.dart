import 'package:flutter/material.dart';
import 'package:staff_app/core/helpers/helper_functions.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/device/device_utility.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs, required this.isScroll});

  final List<Widget> tabs;
  final bool isScroll;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : Colors.white,
      child: Align(
        alignment: Alignment.center,
        child: TabBar(
          isScrollable: isScroll,
          indicatorColor: TColors.primary,
          unselectedLabelColor: TColors.darkGrey,
          labelColor: dark ? TColors.white : TColors.primary,
          tabs: tabs,
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    TDeviceUtils deviceUtils = TDeviceUtils();
    return Size.fromHeight(deviceUtils.getAppBarHeight());
  }
}
