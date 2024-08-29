import 'package:flutter/material.dart';
import 'package:pie_task/config/app_size.dart';
import 'package:pie_task/home/model/product_model.dart';
import 'package:pie_task/home/widgets/add_to_cart_btn.dart';
import 'package:pie_task/home/widgets/text_row.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const route = "/productDetails";
  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(productModel.imageUrl, 
          height: AppSize.appHeight / 4,
          width: double.infinity,
          ),
          const SizedBox(height: 30),
          TextRow(leading: "Category", traling: productModel.category),
          const SizedBox(height: 30),
          TextRow(leading: "Price", traling: productModel.price.toString()),
          const SizedBox(height: 30),
          TextRow(leading: "Rating", traling: productModel.rating.toString()),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(productModel.description),
          )
        ],
      ),
      bottomNavigationBar:  AddToCartBtn (productModel: productModel),
    );
  }
}