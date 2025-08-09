import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_task/dashboard/dashboard.dart';
import 'package:test_task/extras/app_colors.dart';
import 'package:test_task/extras/app_text_styles.dart';
import 'package:test_task/widgets/margin_widget.dart';
import 'package:utility_extensions/extensions/context_extensions.dart';

import 'generated/assets.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(image: AssetImage(Assets.imagesSplashImage)),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(gradient: AppColors.blackGradient),
          ),
          Column(
            children: [
              MarginWidget(factor: 4),
              Text(
                "My Store",
                style: AppTextStyles.regular(
                  fontSize: 50,
                  color: AppColors.primary,
                ),
              ),
              Expanded(child: SizedBox()),
              Text("Valkommen", style: AppTextStyles.semiBold()),
              MarginWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.",
                  style: AppTextStyles.poppinsRegular(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              MarginWidget(factor: 8,)
            ],
          ),
        ],
      ),
    );
  }

  navigate() async {
  await Future.delayed(Duration(seconds: 3));
  context.pushAndRemoveUntil(child: Dashboard());
  }

}
