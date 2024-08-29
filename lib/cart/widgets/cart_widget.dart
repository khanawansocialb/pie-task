import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_task/home/model/product_model.dart';

import '../../config/app_size.dart';
import '../cubit/cart_cubit.dart';

class CartWidget extends StatelessWidget {
  final ProductModel productModel;
  const CartWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            height: AppSize.appHeight / 6,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey, // Set the color of the bottom border
                  width: 0.5, // Set the thickness of the bottom border
                ),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      decoration:  BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey, Colors.grey.shade100],
                        ),
                      ),
                      child: Image.network(
                        productModel.imageUrl,
                        height: AppSize.appHeight / 5.0375,
                        width: AppSize.appWidth /3.2727,
                        fit: BoxFit.fitHeight,
                      )),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(productModel.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                    Text((productModel.price * productModel.count).toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.brown)),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 233, 229, 229),
                          borderRadius: BorderRadius.circular(3)),
                      height: 40,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                context.read<CartCubit>().decrementProduct(productModel.id);
                              },
                              icon: const Icon(Icons.remove)),
                          Text(productModel.count.toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400)),
                          IconButton(
                              onPressed: () {
                                context.read<CartCubit>().incrementProduct(productModel.id);
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                context.read<CartCubit>().removeProduct(productModel.id);
              },
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.close, size: 22),
              ))
        ],
      ),
    );

  }
}