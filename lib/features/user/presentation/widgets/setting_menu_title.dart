import 'package:flutter/material.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      this.trailing,
      this.onTap});

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: TColors.black,
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
