import 'package:flutter/material.dart';
import 'package:test_task/extras/app_colors.dart';
import 'package:test_task/extras/app_text_styles.dart';
import 'package:test_task/widgets/app_bar_widget.dart';
import 'package:test_task/widgets/margin_widget.dart';

import '../generated/assets.dart';
import '../main.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            MarginWidget(factor: 3),
            AppBarWidget(title: "Mitt Konto"),
            MarginWidget(),
            userInfo(),
            MarginWidget(factor: 2),
            buttonRow("Kontoinstallningar",Assets.iconsSettings),
            MarginWidget(),
            buttonRow("Mina betalmetoder", Assets.iconsCopy),
            MarginWidget(),
            buttonRow("Suport", Assets.iconsSupport)
          ],
        ),
      ),
    );
  }

  Widget buttonRow(String title, String iconPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Image(image: AssetImage(iconPath), width: 18),
          MarginWidget(isHorizontal: true),
          Text(
            title,
            style: AppTextStyles.regular(fontSize: 14, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Container userInfo() {
    return Container(
      width: width,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primary,
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundColor: AppColors.white),
          MarginWidget(isHorizontal: true),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Muhammad Azhar", style: AppTextStyles.poppinsSemiBold()),
              Text(
                "Azharabid00@gmail.com",
                style: AppTextStyles.poppinsRegular(
                  fontSize: 10,
                  color: AppColors.white,
                ),
              ),
              Text(
                "03244419793",
                style: AppTextStyles.poppinsRegular(
                  fontSize: 10,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
