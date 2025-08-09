import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/providers/products_provider.dart';
import 'package:test_task/widgets/app_bar_widget.dart';
import 'package:test_task/widgets/margin_widget.dart';
import 'package:test_task/widgets/text_field_widget.dart';
import 'package:utility_extensions/extensions/color_utilities.dart';

import '../../extras/app_colors.dart';
import '../../extras/app_text_styles.dart';
import '../../models/product_model.dart';
import '../../widgets/products_box.dart';

class ProductsByCategory extends StatefulWidget {
  const ProductsByCategory({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      searchText = searchController.text;
      setState(() {

      });
      // context.read<ProductsProvider>().filterByBrand(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductsProvider>(
        builder: (BuildContext context, value, Widget? child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              MarginWidget(factor: 3),
              AppBarWidget(title: widget.categoryName, isPop: true),
              MarginWidget(),
              TextFieldWidget(controller: searchController),
              MarginWidget(factor: 1.3,),
              productsList(value),
            ],
          ),
        ),
      ),
    );
  }

  Widget productsList(ProductsProvider value) {
    List<ProductModel> products = value.categoryProducts;
    ;
    if (searchText != "") {
      products = [];
      products = value.categoryProducts
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
            MarginWidget()
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
