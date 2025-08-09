import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utility_extensions/extensions/context_extensions.dart';

import '../extras/app_colors.dart';
import '../extras/app_text_styles.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key,required this.title, this.isPop = false});
final String title;
final bool? isPop;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if(isPop!)...[
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(Icons.arrow_back_ios),
        )],
          Spacer(),
        Text(
          title,
          style: AppTextStyles.semiBold(fontSize: 24, color: AppColors.primary),
        ),
        Spacer(),
        if(isPop!)...[
          Icon(Icons.arrow_back_ios,color: AppColors.white,)]
      ],
    );
  }
}
