import 'package:flutter/material.dart';
import 'package:pie_task/home/model/product_model.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;
  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          height: 130,
          width: 100,
          productModel.images[0], 
          fit: BoxFit.fill,
          ),
          SizedBox(
            width: 50,
            child: Text(productModel.title, style: const TextStyle(overflow: TextOverflow.ellipsis))),
          const SizedBox(height: 20),
          Text(productModel.price.toString(), style: const TextStyle(overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
