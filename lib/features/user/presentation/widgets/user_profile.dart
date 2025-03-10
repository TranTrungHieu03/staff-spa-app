import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:staff_app/core/common/widgets/circular_image.dart';
import 'package:staff_app/core/common/widgets/shimmer.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/images.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/auth/data/models/user_model.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
    required this.userData,
  });

  final VoidCallback onPressed;
  final UserModel? userData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TCircularImage(
        image: userData?.avatar ?? TImages.avatar,
        isNetworkImage: userData?.avatar != null,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: userData?.userName != null
          ? Text(userData!.userName, style: Theme.of(context).textTheme.headlineSmall!)
          : const TShimmerEffect(width: TSizes.shimmerLg, height: TSizes.shimmerSx),
      subtitle: userData?.userName != null
          ? Text(
              userData!.email,
              style: Theme.of(context).textTheme.bodyMedium!,
            )
          : const TShimmerEffect(width: TSizes.shimmerXl, height: TSizes.shimmerSx),
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
