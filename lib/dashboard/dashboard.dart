import 'package:flutter/material.dart';
import 'package:test_task/dashboard/categories.dart';
import 'package:test_task/extras/app_colors.dart';
import 'package:test_task/extras/app_text_styles.dart';
import 'package:test_task/dashboard/favourites.dart';
import 'package:test_task/dashboard/products/products.dart';
import 'package:test_task/dashboard/profile.dart';

import '../generated/assets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  List pages = [
    Products(),
    Categories(),
    Favourites(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: BottomNavigationBar(
          onTap: (index){
            print("here is index:$index");
            setState(() {
              selectedIndex = index;
            });
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: AppColors.primary,
          items: [
            _buildNavItem(Assets.iconsProducts, "Products"),
            _buildNavItem(Assets.iconsCategories, "Categories"),
            _buildNavItem(Assets.iconsFavourite, "Favourites"),
            _buildNavItem(Assets.iconsPerson, "Mitt Konto"),
           ],
        ),
      ),

      body: pages[selectedIndex],
    );
  }

  BottomNavigationBarItem _buildNavItem(String assetPath, String label) {
    return BottomNavigationBarItem(
      backgroundColor: AppColors.primary,
      label: '',
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: AssetImage(assetPath), width: 21),
            const SizedBox(height: 4), // padding between icon and label
            Text(
              label,
              style: AppTextStyles.poppinsRegular(fontSize: 10,color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

}
