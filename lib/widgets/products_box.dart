import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_task/dashboard/products/product_details.dart';
import 'package:test_task/models/product_model.dart';
import 'package:utility_extensions/extensions/color_utilities.dart';
import 'package:utility_extensions/extensions/context_extensions.dart';

import '../extras/app_colors.dart';
import '../extras/app_text_styles.dart';
import '../main.dart';
import 'margin_widget.dart';

class ProductBox extends StatefulWidget {
  const ProductBox({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductBox> createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(child: ProductDetails(product: widget.product));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        // spacing between items
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.black.applyOpacity(0.5),
            ), // optional background
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(widget.product.thumbnail),
                fit: BoxFit.cover,
                width: double.infinity,
                height: height * 0.5,
                // you can adjust this
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.product.title,
                      style: AppTextStyles.semiBold(
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  MarginWidget(isHorizontal: true, factor: 0.4),
                  Text(
                    "\$${widget.product.price}",
                    style: AppTextStyles.semiBold(
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              MarginWidget(factor: 0.5),
              Row(
                children: [
                  Text(
                    widget.product.rating.toString(),
                    style: AppTextStyles.poppinsSemiBold(
                      fontSize: 10,
                      color: AppColors.primary,
                    ),
                  ),
                  MarginWidget(isHorizontal: true, factor: 0.3),
                  RatingBarIndicator(
                    rating: widget.product.rating,
                    // make sure Product has rating
                    itemBuilder: (context, index) =>
                        const Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              MarginWidget(factor: 0.3),
              if (widget.product.brand != null)
                Text(
                  "By ${widget.product.brand!}",
                  style: AppTextStyles.poppinsRegular(
                    fontSize: 10,
                    color: AppColors.primary.applyOpacity(0.5),
                  ),
                ),
              Text(
                "In ${widget.product.category}",
                style: AppTextStyles.poppinsRegular(
                  fontSize: 10,
                  color: AppColors.primary.applyOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
