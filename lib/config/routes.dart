import 'package:flutter/material.dart';
import 'package:pie_task/cart/screen/cart_screen.dart';
import 'package:pie_task/home/model/product_model.dart';
import 'package:pie_task/home/screens/home_screen.dart';
import 'package:pie_task/home/screens/product_details_screen.dart';

class Routes {
  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(), settings: settings);
      case CartScreen.route:
        return MaterialPageRoute(
            builder: (_) => const CartScreen(), settings: settings);
      case ProductDetailsScreen.route:
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
                productModel: settings.arguments as ProductModel),
            settings: settings);
    }
    return null;
  }
}
