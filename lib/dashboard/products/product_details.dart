import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:test_task/extras/app_colors.dart';
import 'package:test_task/extras/app_text_styles.dart';
import 'package:test_task/main.dart';
import 'package:test_task/models/product_model.dart';
import 'package:test_task/providers/products_provider.dart';
import 'package:test_task/widgets/app_bar_widget.dart';
import 'package:test_task/widgets/margin_widget.dart';

import '../../generated/assets.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    ProductModel product = widget.product;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            MarginWidget(factor: 3),
            AppBarWidget(title: "Product Details", isPop: true),
            MarginWidget(),
            Image(
              image: NetworkImage(product.thumbnail),
              height: 209,
              width: width,
            ),
            MarginWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Consumer<ProductsProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        bool isFavourite = false;
                        if (value.favourites.contains(product)) {
                          isFavourite = true;
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Details",
                              style: AppTextStyles.poppinsSemiBold(
                                fontSize: 18,
                                color: AppColors.primary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                value.updateFavourites(product);
                              },
                              child: Image(
                                image: AssetImage(
                                  (isFavourite)
                                      ? Assets.iconsFavouriteFill
                                      : Assets.iconsFavourite2,
                                ),
                                width: 27,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    MarginWidget(factor: 0.4),
                    infoRow("Name", product.title),
                    MarginWidget(factor: 0.4),
                    infoRow("Price", product.price.toString()),
                    MarginWidget(factor: 0.4),
                    infoRow("Category", product.category),
                    MarginWidget(factor: 0.4),
                    if (product.brand != null) ...[
                      infoRow("Brand", product.brand!),
                      MarginWidget(factor: 0.4),
                    ],
                    Row(
                      children: [
                        infoRow("Rating", product.rating.toString()),
                        MarginWidget(isHorizontal: true, factor: 0.4),
                        RatingBarIndicator(
                          rating: widget.product.rating,
                          // make sure Product has rating
                          itemBuilder: (context, index) =>
                              const Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 16.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    infoRow("Stock", product.stock.toString()),
                    MarginWidget(factor: 0.4),
                    infoRow("Description", ""),
                    MarginWidget(factor: 0.4),
                    Text(
                      product.description,
                      style: AppTextStyles.poppinsRegular(fontSize: 10),
                    ),
                    MarginWidget(),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // ✅ two items per row
                              crossAxisSpacing: 10, // horizontal spacing
                              mainAxisSpacing: 10, // vertical spacing
                              childAspectRatio: 0.75, // adjust height vs width
                            ),
                        itemCount: product.images.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (index == 0) ...[
                                Text(
                                  "Product Gallery:",
                                  style: AppTextStyles.poppinsSemiBold(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                              Image(
                                image: NetworkImage(product.images[index]),
                                height: 109,
                                width: 154,
                                fit: BoxFit.contain,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String name, String value) {
    return Row(
      children: [
        Text(
          "$name:",
          style: AppTextStyles.poppinsSemiBold(
            fontSize: 12,
            color: AppColors.primary,
          ),
        ),
        MarginWidget(isHorizontal: true, factor: 0.8),
        Text(value, style: AppTextStyles.poppinsRegular(fontSize: 10)),
      ],
    );
  }
}
