import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/utils/constants/colors.dart';
import 'package:staff_app/core/utils/constants/exports_navigators.dart';
import 'package:staff_app/core/utils/constants/sizes.dart';
import 'package:staff_app/features/home/presentation/bloc/navigator/navigation_bloc.dart';
import 'package:staff_app/features/home/presentation/screen/home_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationIndexChangedState) {
            AppLogger.info(state.selectedIndex);
            return state.screens[state.selectedIndex];
          } else {
            return const HomeScreen();
          }
        },
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              final selectedIndex = state is NavigationIndexChangedState ? state.selectedIndex : 0;
              return Container(
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: BottomNavigationBar(
                  currentIndex: state is NavigationIndexChangedState ? state.selectedIndex : 0,
                  onTap: (index) {
                    context.read<NavigationBloc>().add(ChangeSelectedIndexEvent(index));
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: TColors.primary,
                  unselectedItemColor: TColors.darkerGrey.withOpacity(0.8),
                  selectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  unselectedIconTheme: const IconThemeData(size: 27),
                  selectedIconTheme: const IconThemeData(size: 27),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  showSelectedLabels: true,
                  items: [
                    BottomNavigationBarItem(icon: const Icon(Iconsax.home), label: AppLocalizations.of(context)!.home),
                    BottomNavigationBarItem(icon: const Icon(Iconsax.calendar_1), label: AppLocalizations.of(context)!.appointment),
                    const BottomNavigationBarItem(icon: SizedBox(), label: ''),
                    BottomNavigationBarItem(icon: const Icon(Iconsax.message), label: AppLocalizations.of(context)!.message),
                    BottomNavigationBarItem(icon: const Icon(Iconsax.setting_2), label: AppLocalizations.of(context)!.setting),
                  ],
                ),
              );
            },
          ),

          // QR Floating Button
          Positioned(
            bottom: 35,
            child: FloatingActionButton(
              backgroundColor: TColors.primary,
              onPressed: () {
                goScanner();
              },
              shape: const CircleBorder(),
              elevation: 4,
              child: const Icon(Icons.qr_code_scanner_rounded, size: 30, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
