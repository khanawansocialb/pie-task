import 'package:flutter/material.dart';
import 'package:pie_task/home/widgets/product_shimmer.dart';

import '../model/product_model.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel productModel;
  const ProductWidget({super.key, required this.productModel});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
    bool _isProductImageLoading = true;

  Future<void> _preloadImage() async {
    try {
      final imageProvider = NetworkImage(widget.productModel.imageUrl);
      await precacheImage(imageProvider, context);
    } catch (e) {}
    if (mounted) {
      setState(() => _isProductImageLoading = false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImage();
  }

  @override
  Widget build(BuildContext context) {
    return !_isProductImageLoading ? Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          height: 130,
          width: 100,
          widget.productModel.imageUrl,
          fit: BoxFit.fill,
        ),
        SizedBox(
            width: 50,
            child: Text(widget.productModel.title,
                style: const TextStyle(overflow: TextOverflow.ellipsis))),
        const SizedBox(height: 20),
        Text(widget.productModel.price.toString(),
            style: const TextStyle(overflow: TextOverflow.ellipsis)),
      ],
    ) : const ProductShimmer();
  }
}
