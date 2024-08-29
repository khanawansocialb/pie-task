import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pie_task/home/service/product_service.dart';

import '../model/product_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductService productService;
  ProductsCubit({required this.productService}) : super(ProductsInitial());

  getProducts() async {
    try {
      List<ProductModel> newProducts = await productService.getProducts();
      if (state is ProductsSuccess) {
        final currentProducts = (state as ProductsSuccess).products;
        emit(ProductsSuccess(products: List.from(currentProducts)..addAll(newProducts)));
      } else {
        emit(ProductsSuccess(products: newProducts));
      }
    } catch (e) {
      emit(ProductsFailed());
    }
  }
}
