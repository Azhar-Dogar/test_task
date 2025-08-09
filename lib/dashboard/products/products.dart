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
import 'package:test_task/widgets/products_box.dart';
import 'package:test_task/widgets/text_field_widget.dart';
import 'package:utility_extensions/extensions/color_utilities.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      searchText = searchController.text;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Consumer<ProductsProvider>(
        builder: (BuildContext context, value, Widget? child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarginWidget(factor: 3),
              AppBarWidget(title: "Products"),
              MarginWidget(),
              TextFieldWidget(controller: searchController),
              MarginWidget(factor: 1.3),
              if (value.isLoading) ...[
                Expanded(child: Center(child: CircularProgressIndicator())),
              ] else if (value.totalProducts.isEmpty)
                ...[Expanded(child: Center(child: Text("No Product Found"),))]
              else ...[
                productsList(value),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget productsList(ProductsProvider value) {
    List<ProductModel> products = value.totalProducts;
    if (searchText != "") {
      products = [];
      products = value.totalProducts
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
                return ProductBox(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
