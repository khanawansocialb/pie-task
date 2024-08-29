import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../home/model/product_model.dart';

class CartCubit extends HydratedCubit<List<ProductModel>> {
  CartCubit() : super([]);


  void addProduct(ProductModel product) {
    final currentCart = List<ProductModel>.from(state);

    final index = currentCart.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      final existingProduct = currentCart[index];
      final updatedProduct = existingProduct.copyWith(count: existingProduct.count + 1);
      currentCart[index] = updatedProduct;
    } else {
      currentCart.add(product);
    }

    emit(currentCart);
  }

  void incrementProduct(int productId) {
    final currentCart = List<ProductModel>.from(state);

    final index = currentCart.indexWhere((p) => p.id == productId);

    if (index != -1) {
      final existingProduct = currentCart[index];
      final updatedProduct = existingProduct.copyWith(count: existingProduct.count + 1);
      currentCart[index] = updatedProduct;
      emit(currentCart);
    }
  }

  void decrementProduct(int productId) {
    final currentCart = List<ProductModel>.from(state);

    final index = currentCart.indexWhere((p) => p.id == productId);

    if (index != -1) {
      final existingProduct = currentCart[index];
      if (existingProduct.count > 1) {
        final updatedProduct = existingProduct.copyWith(count: existingProduct.count - 1);
        currentCart[index] = updatedProduct;
      } else {
        currentCart.removeAt(index);
      }
      emit(currentCart);
    }
  }

  void removeProduct(int productId) {
    final currentCart = List<ProductModel>.from(state);
    currentCart.removeWhere((p) => p.id == productId);
    emit(currentCart);
  }

  @override
  List<ProductModel>? fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      return List<ProductModel>.from(
        (json['cart'] as List).map((item) => ProductModel.fromJson(item)),
      );
    }
    return [];
  }

  @override
  Map<String, dynamic>? toJson(List<ProductModel> state) {
    return {
      'cart': state.map((product) => product.toJson()).toList(),
    };
  }
}
