import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 130,
            width: 100,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 5),
          Container(
            width: 50,
            height: 10,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 15),
          Container(
            width: 50,
            height: 10,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}

