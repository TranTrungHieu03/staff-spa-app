import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spa_mobile/core/utils/constants/colors.dart';
import 'package:spa_mobile/features/home/presentation/blocs/navigation_bloc.dart';
import 'package:spa_mobile/features/home/presentation/screens/home_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationIndexChangedState) {
            return state.screens[state.selectedIndex];
          } else {
            return const HomeScreen();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Container(
            height: 70,
            decoration: BoxDecoration(
              color: TColors.primary.withOpacity(0.1), // Background color
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: BottomNavigationBar(
              currentIndex: state is NavigationIndexChangedState
                  ? state.selectedIndex
                  : 0,
              onTap: (index) {
                context
                    .read<NavigationBloc>()
                    .add(ChangeSelectedIndexEvent(index));
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: TColors.primary,
              unselectedItemColor: TColors.darkerGrey.withOpacity(0.8),
              backgroundColor: TColors.primary.withOpacity(0.0),
              elevation: 0,
              showSelectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.home_2), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.box), label: 'Product'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.activity), label: 'Service'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.setting_2), label: 'Settings'),
              ],
            ),
          );
        },
      ),
    );
  }
}
