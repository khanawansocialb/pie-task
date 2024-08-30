import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pie_task/home/model/product_model.dart';
import 'package:pie_task/cart/cubit/cart_cubit.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([HydratedStorage])
void main() {
  late CartCubit cartCubit;
  late MockHydratedStorage mockStorage;

  setUp(() {
    mockStorage = MockHydratedStorage();
    HydratedBloc.storage = mockStorage;
    cartCubit = CartCubit();
  });

  tearDown(() {
    cartCubit.close();
  });

  group('CartCubit', () {
    ProductModel product1 = const ProductModel(
        id: 1,
        title: "dummy 1",
        price: 10,
        description: "dymmy descripiion",
        category: "beauty",
        images: [],
        imageUrl: "https://example.com/image",
        rating: 4.0);
    ProductModel product2 = const ProductModel(
        id: 2,
        title: "dummy 2",
        price: 30,
        description: "dymmy descripiion 2",
        category: "food",
        images: [],
        imageUrl: "https://example.com/image2",
        rating: 3.0);

    blocTest<CartCubit, List<ProductModel>>(
      'emits [] when nothing is added',
      build: () => cartCubit,
      expect: () => [],
    );

    blocTest<CartCubit, List<ProductModel>>(
      'addProduct adds a new product to the cart',
      build: () => cartCubit,
      act: (cubit) => cubit.addProduct(product1),
      expect: () => [
        [product1]
      ],
    );

    blocTest<CartCubit, List<ProductModel>>(
      'addProduct increments the count if product already exists',
      build: () => cartCubit,
      seed: () => [product1],
      act: (cubit) => cubit.addProduct(product1),
      expect: () => [
        [product1.copyWith(count: 2)]
      ],
    );

    blocTest<CartCubit, List<ProductModel>>(
      'incrementProduct increases the count of the product',
      build: () => cartCubit,
      seed: () => [product1],
      act: (cubit) => cubit.incrementProduct(1),
      expect: () => [
        [product1.copyWith(count: 2)]
      ],
    );

    blocTest<CartCubit, List<ProductModel>>(
      'decrementProduct decreases the count of the product',
      build: () => cartCubit,
      seed: () => [product1.copyWith(count: 2)],
      act: (cubit) => cubit.decrementProduct(1),
      expect: () => [
        [product1]
      ],
    );

    blocTest<CartCubit, List<ProductModel>>(
      'decrementProduct removes the product when count is 1',
      build: () => cartCubit,
      seed: () => [product1],
      act: (cubit) => cubit.decrementProduct(1),
      expect: () => [[]],
    );

    blocTest<CartCubit, List<ProductModel>>(
      'removeProduct removes the product from the cart',
      build: () => cartCubit,
      seed: () => [product1, product2],
      act: (cubit) => cubit.removeProduct(1),
      expect: () => [
        [product2]
      ],
    );

    blocTest<CartCubit, List<ProductModel>>(
      'fromJson restores the state from json',
      build: () => CartCubit(),
      act: (cubit) => cubit.fromJson({
        'cart': [
          product1.toJson(),
          product2.toJson(),
        ],
      }),
      expect: () => [
        [product1, product2]
      ],
    );

    blocTest<CartCubit, List<ProductModel>>(
      'toJson converts the state to json',
      build: () => cartCubit,
      seed: () => [product1, product2],
      verify: (cubit) {
        final json = cubit.toJson([product1, product2]);
        expect(json, {
          'cart': [product1.toJson(), product2.toJson()],
        });
      },
    );
  });
}
