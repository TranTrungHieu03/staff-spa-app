import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/core/utils/constants/images.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';
import 'package:spa_mobile/features/auth/presentation/bloc/auth_bloc.dart';

class SocialBtn extends StatelessWidget {
  const SocialBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: TColors.grey)),
          child: IconButton(
            onPressed: () => context.read<AuthBloc>().add(GoogleLoginEvent()),
            icon: const Image(
              width: TSizes.iconLg,
              height: TSizes.iconLg,
              image: AssetImage(TImages.google),
            ),
          ),
        ),
        const SizedBox(
          width: TSizes.spacebtwItems,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: TColors.grey)),
          child: IconButton(
            onPressed: () => context.read<AuthBloc>().add(FacebookLoginEvent()),
            icon: const Image(
              width: TSizes.iconLg,
              height: TSizes.iconLg,
              image: AssetImage(TImages.facebook),
            ),
          ),
        )
      ],
    );
  }
}
