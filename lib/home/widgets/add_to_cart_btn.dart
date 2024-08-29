import 'package:flutter/material.dart';

import '../../config/app_size.dart';

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        width: AppSize.appWidth / 2,
        height: 50,
        child: const Center(
          child: Text("ADD TO CART"),
        ),
      );
  }
}