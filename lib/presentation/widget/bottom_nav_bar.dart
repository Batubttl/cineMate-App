import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/core/theme/app_colors.dart';
import 'package:cinemate_app/init/navigation/navigation_cubit.dart';
import 'package:cinemate_app/init/navigation/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentIndex,
          onTap: (index) {
            context.read<NavigationCubit>().changeIndex(index);

            switch (index) {
              case 0:
                context.go('/');
                break;
              case 1:
                context.go('/search');
                break;
              case 2:
                context.go('/watchlist');
                break;
              case 3:
                context.go('/favorites');
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: AppColors.textPrimary,
          unselectedItemColor: AppColors.textSecondary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppString.homePage,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: AppString.searchPage,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: AppString.myListPage,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: AppString.favoritePage,
            ),
          ],
        );
      },
    );
  }
}
