import 'package:cinemate_app/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.myListPage),
      ),
      body: const Center(
        child: Text('Kaydeymek İstediğiniz Filmler'),
      ),
    );
  }
}
