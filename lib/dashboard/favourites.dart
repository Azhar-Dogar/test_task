import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:test_task/dashboard/products/product_details.dart';
import 'package:test_task/extras/app_colors.dart';
import 'package:test_task/extras/app_text_styles.dart';
import 'package:test_task/providers/products_provider.dart';
import 'package:test_task/widgets/app_bar_widget.dart';
import 'package:test_task/widgets/margin_widget.dart';
import 'package:test_task/widgets/text_field_widget.dart';
import 'package:utility_extensions/extensions/color_utilities.dart';
import 'package:utility_extensions/extensions/context_extensions.dart';

import '../generated/assets.dart';
import '../models/product_model.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  TextEditingController controller = TextEditingController();
  String searchText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      searchText = controller.text;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<ProductsProvider>(
          builder: (BuildContext context, value, Widget? child) => Column(
            children: [
              MarginWidget(factor: 3),
              AppBarWidget(title: "Favourites"),
              MarginWidget(),
              TextFieldWidget(controller: controller),
              MarginWidget(),
              if (value.favourites.isEmpty) ...[
                Expanded(child: Center(child: Text("No Product found"))),
              ] else ...[
                favouritesList(value),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget favouritesList(ProductsProvider value) {
    List<ProductModel> products = value.favourites;
    if (searchText != "") {
      products = [];
      products = value.favourites
          .where(
            (product) =>
            product.title.toLowerCase().contains(searchText.toLowerCase()),
      )
          .toList();
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (searchText.isNotEmpty) ...[
            Text(
              "${products.length} results found",
              style: AppTextStyles.poppinsRegular(
                fontSize: 10,
                color: AppColors.primary.applyOpacity(0.25),
              ),
            ),
            MarginWidget(),
          ],
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: products.length,
              itemBuilder: (context, index) {
                ProductModel product = products[index];
                return favouriteBox(product, value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget favouriteBox(ProductModel product, ProductsProvider value) {
    return GestureDetector(
      onTap: () {
        context.push(child: ProductDetails(product: product));
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            right: BorderSide(color: AppColors.primary.applyOpacity(0.1)),
            bottom: BorderSide(color: AppColors.primary.applyOpacity(0.1)),
            left: BorderSide(color: AppColors.primary.applyOpacity(0.1)),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(product.thumbnail),
              radius: 30,
            ),
            MarginWidget(isHorizontal: true, factor: 0.6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: AppTextStyles.poppinsSemiBold(
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    "\$${product.price}",
                    style: AppTextStyles.poppinsSemiBold(
                      fontSize: 11,
                      color: AppColors.primary,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        product.rating.toString(),
                        style: AppTextStyles.poppinsSemiBold(
                          fontSize: 11,
                          color: AppColors.primary,
                        ),
                      ),
                      RatingBarIndicator(
                        rating: product.rating,
                        // make sure Product has rating
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 16.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                value.updateFavourites(product);
              },
              child: Image(
                image: AssetImage(Assets.iconsFavouriteFill),
                width: 27,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
