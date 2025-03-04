// bottom_nav_bar.dart
import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:cinemate_app/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:cinemate_app/presentation/cubit/navigation/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          // Hangi sayfa aktif?
          currentIndex: state.currentIndex,

          // Tıklanınca ne olacak?
          onTap: (index) => context.read<NavigationCubit>().changeIndex(index),

          // Menü öğeleri
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
          ],
        );
      },
    );
  }
}
