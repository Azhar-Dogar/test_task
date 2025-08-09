import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/dashboard/products/products_by_category.dart';
import 'package:test_task/extras/app_colors.dart';
import 'package:test_task/extras/app_text_styles.dart';
import 'package:test_task/models/category_model.dart';
import 'package:test_task/models/product_model.dart';
import 'package:test_task/providers/categories_provider.dart';
import 'package:test_task/providers/products_provider.dart';
import 'package:test_task/widgets/app_bar_widget.dart';
import 'package:test_task/widgets/margin_widget.dart';
import 'package:test_task/widgets/text_field_widget.dart';
import 'package:utility_extensions/extensions/color_utilities.dart';
import 'package:utility_extensions/utility_extensions.dart';

import '../generated/assets.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController searchController = TextEditingController();
  late ProductsProvider productsProvider;
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
      body: Consumer2<CategoriesProvider, ProductsProvider>(
        builder: (BuildContext context, value, value2, Widget? child) {
          productsProvider = value2;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                MarginWidget(factor: 3),
                AppBarWidget(title: "Categories"),
                MarginWidget(),
                TextFieldWidget(controller: searchController),
                MarginWidget(),
                categoriesList(value, value2),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget categoriesList(CategoriesProvider value, ProductsProvider value2) {
    List<CategoryModel> catList = value.categories;
    ;
    if (searchText != "") {
      catList = [];
      catList = value.categories
          .where(
            (product) =>
            product.name.toLowerCase().contains(searchText.toLowerCase()),
      )
          .toList();
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (searchText.isNotEmpty) ...[
            Text(
              "${catList.length} results found",
              style: AppTextStyles.poppinsRegular(
                fontSize: 10,
                color: AppColors.primary.applyOpacity(0.25),
              ),
            ),
            MarginWidget(),
          ],
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // ✅ two items per row
                crossAxisSpacing: 10, // horizontal spacing
                mainAxisSpacing: 10, // vertical spacing
                childAspectRatio: 0.75, // adjust height vs width
              ),
              itemCount: catList.length,
              itemBuilder: (context, index) {
                CategoryModel category = catList[index];
                ProductModel? product = value2.totalProducts
                    .where((e) => e.category == category.slug.toLowerCase())
                    .firstOrNull;
                return categoryBox(product, category);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryBox(ProductModel? product, CategoryModel category) {
    return GestureDetector(
      onTap: () {
        productsProvider.getCategoryProducts(category.slug);
        context.push(child: ProductsByCategory(categoryName: category.name));
      },
      child: Container(
        width: 147,
        height: 147,
        color: AppColors.primary.applyOpacity(0.25),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (product != null) ...[
              Image(
                image: NetworkImage(product.thumbnail),
                width: 132,
                height: 124,
                fit: BoxFit.cover,
              ),
            ] else ...[
              Image(image: AssetImage(Assets.iconsNoImage)),
            ],
            Positioned(
              bottom: 30,
              left: 20,
              child: Text(
                category.name,
                style: AppTextStyles.poppinsSemiBold(
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
