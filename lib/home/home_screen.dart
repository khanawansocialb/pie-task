import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_task/config/app_size.dart';
import 'package:pie_task/home/cubit/products_cubit.dart';
import 'package:pie_task/home/widgets/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductsCubit>().getProducts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<ProductsCubit>().getProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog Home Screen'),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsSuccess) {
            return SizedBox(
              height: AppSize.appHeight / 2,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5, 
                  mainAxisSpacing: 5.0,  
                ),
                controller: _scrollController,
                itemCount: state.products.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.products.length) {
                    return ProductWidget(productModel: state.products[index]);
                  } else {
                    return const Padding(
                      padding:  EdgeInsets.only(left: 160),
                      child:  Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
