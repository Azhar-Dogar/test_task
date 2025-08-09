import 'package:flutter/material.dart';
import 'package:test_task/extras/app_colors.dart';
import 'package:test_task/extras/app_text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, this.hint,required this.controller});

  final String? hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.primary)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.search, color: AppColors.primary),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyles.poppinsRegular(fontSize: 12,),
              decoration: InputDecoration(
                // hint: Text(hint ?? ""),
                hintText: hint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                // removes underline when not focused
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
