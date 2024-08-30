import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_task/cart/cubit/cart_cubit.dart';
import 'package:pie_task/home/model/product_model.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return BlocBuilder<CartCubit, List<ProductModel>>(
      builder: (context, state) {
        num total = 0;
        for (var p in state) {
          total += p.price * p.count;
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: !isLandscape ? 10 : 130, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total: ", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Text(total.toStringAsFixed(2), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ],
          ),
        );
      },
    );
  }
}
