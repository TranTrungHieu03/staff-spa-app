import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_mobile/core/common/styles/spacing_styles.dart';
import 'package:spa_mobile/core/utils/constants/sizes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppbarHeight * 2,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.6,
                child: Lottie.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: TSizes.spacebtwSections,
              ),

              //Title and subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spacebtwItems,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spacebtwItems,
              ),

              //Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(AppLocalizations.of(context)!.submit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
