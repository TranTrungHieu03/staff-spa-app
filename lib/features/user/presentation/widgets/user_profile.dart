import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/common/widgets/circular_image.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
        image: TImages.avatar,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text("Tran Trung Hieu",
          style: Theme.of(context).textTheme.headlineSmall!),
      subtitle: Text(
        "hieuttjob@gmail.com",
        style: Theme.of(context).textTheme.bodyMedium!,
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Iconsax.edit,
          color: TColors.primary,
        ),
      ),
    );
  }
}
