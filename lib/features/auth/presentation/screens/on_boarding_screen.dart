import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:staff_app/core/common/widgets/appbar.dart';
import 'package:staff_app/core/helpers/helper_functions.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/constants/images.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/auth/presentation/bloc/on_boarding_bloc.dart';
import 'package:staff_app/features/auth/presentation/widgets/language_dropdown.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        appBar: const TAppbar(),
        body: BlocListener<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingPageChanged) {
              _pageController.animateToPage(
                state.pageIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Stack(
            children: [
              BlocBuilder<OnboardingBloc, OnboardingState>(
                builder: (context, state) {
                  return PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(OnPageChangedEvent(index));
                    },
                    children: [
                      OnBoardingPage(
                        title: AppLocalizations.of(context)!.page1Title,
                        image: TImages.page1,
                        subTitle: AppLocalizations.of(context)!.page1Sub,
                      ),
                      OnBoardingPage(
                        title: AppLocalizations.of(context)!.page2Title,
                        image: TImages.page1,
                        subTitle: AppLocalizations.of(context)!.page2Sub,
                      ),
                      OnBoardingPage(
                        title: AppLocalizations.of(context)!.page3Title,
                        image: TImages.page1,
                        subTitle: AppLocalizations.of(context)!.page3Sub,
                      ),
                    ],
                  );
                },
              ),
              const OnBoardingDotNavigation(),
              const Positioned(
                right: TSizes.md,
                left: 0,
                top: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    LanguageDropdown(),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(TSizes.sm),
                  width: THelperFunctions.screenWidth(context),
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () => goSignUp(),
                              child: Text(
                                AppLocalizations.of(context)!.get_started.toUpperCase(),
                              ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () => goLoginNotBack(),
                              child: Text(
                                AppLocalizations.of(context)!.has_account,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.title, required this.image, required this.subTitle});

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: THelperFunctions.screenWidth(context) * 0.8,
              height: THelperFunctions.screenHeight(context) * 0.5,
              image: AssetImage(image)),
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
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnBoardingNextBtn extends StatelessWidget {
  const OnBoardingNextBtn({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: TSizes.sm,
      bottom: TSizes.xl * 5,
      child: ElevatedButton(
        onPressed: () => context.read<OnboardingBloc>().add(NextPageEvent()),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingComplete) {
            goLoginNotBack();
          }
        },
        child: Positioned(
          top: 0,
          right: 16,
          child: TextButton(
            onPressed: () => context.read<OnboardingBloc>().add(SkipPageEvent()),
            child: Text(AppLocalizations.of(context)!.skip),
          ),
        ));
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: TSizes.xl * 5,
      left: 0,
      right: 0,
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final currentIndex = state is OnboardingPageChanged ? state.pageIndex : 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: PageController(initialPage: currentIndex),
                count: 3,
                effect: ExpandingDotsEffect(activeDotColor: !dark ? TColors.dark : TColors.light, dotHeight: 6),
              ),
            ],
          );
        },
      ),
    );
  }
}
