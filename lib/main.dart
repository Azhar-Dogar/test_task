import 'package:flutter/material.dart';
import 'package:test_task/providers/categories_provider.dart';
import 'package:test_task/providers/products_provider.dart';
import 'package:test_task/splash_screen.dart';
import 'package:utility_extensions/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

late double width, height;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    width = context.width;
    height = context.height;
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider())
      ],
      child: MaterialApp(title: 'Flutter Demo', home: SplashScreen()),
    );
  }
}
