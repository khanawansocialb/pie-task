import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_task/config/app_size.dart';
import 'package:pie_task/home/cubit/products_cubit.dart';
import 'package:pie_task/home/screens/product_details_screen.dart';
import 'package:pie_task/home/widgets/product_widget.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/";
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final crossAxisCount = isLandscape ? 4 : 2; 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsSuccess) {
              return SizedBox(
                height: AppSize.appHeight,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 5, 
                    mainAxisSpacing: 5.0,  
                  ),
                  controller: _scrollController,
                  itemCount: state.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.products.length) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductDetailsScreen.route, arguments: state.products[index]);
                        },
                        child: ProductWidget(productModel: state.products[index]));
                    } else {
                      return  Padding(
                        padding:  EdgeInsets.only(left: AppSize.appWidth / 2.5),
                        child: const Center(
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
      ),
    );
  }
}
