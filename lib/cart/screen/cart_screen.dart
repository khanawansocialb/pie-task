import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_task/cart/cubit/cart_cubit.dart';
import 'package:pie_task/cart/widgets/cart_widget.dart';
import 'package:pie_task/home/model/product_model.dart';

class CartScreen extends StatelessWidget {
  static const route = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CartCubit, List <ProductModel>>(
        listener: (context, state) {
          if (state.isEmpty) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
              itemBuilder: (_, idx) => CartWidget(productModel: state[idx]));
        },
      ),
    );
  }
}
