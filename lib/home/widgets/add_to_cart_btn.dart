import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_task/cart/cubit/cart_cubit.dart';
import 'package:pie_task/cart/screen/cart_screen.dart';
import 'package:pie_task/home/model/product_model.dart';

import '../../config/app_size.dart';

class AddToCartBtn extends StatelessWidget {
  final ProductModel productModel;
  const AddToCartBtn({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read <CartCubit> ().addProduct(productModel);
        Navigator.pushNamed(context, CartScreen.route);
      },
      child: Container(
          color: Colors.grey,
          width: AppSize.appWidth / 2,
          height: 50,
          child: const Center(
            child: Text("ADD TO CART", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
    );
  }
}