import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pie_task/config/constants.dart';
import 'package:pie_task/home/model/product_model.dart';
import 'package:pie_task/home/service/product_service.dart';

import 'product_service_test.mocks.dart';

// Generate the mock class for http.Client
@GenerateMocks([http.Client])
void main() {
  group('ProductService', () {
    late ProductService productService;
    late MockClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockClient();
      productService = ProductService();
    });

    test('getProducts returns a list of products when the http call completes successfully', () async {
      // Arrange
      final jsonResponse = {
        "products": [
          {
            "id": 1,
            "title": "Product 1",
            "price": 29.99,
            "description": "Description 1",
            "category": "Category 1",
            "imageUrl": "https://example.com/image1.jpg",
            "rating": 4.5
          },
          {
            "id": 2,
            "title": "Product 2",
            "price": 39.99,
            "description": "Description 2",
            "category": "Category 2",
            "imageUrl": "https://example.com/image2.jpg",
            "rating": 4.0
          }
        ]
      };

      when(mockHttpClient.get(
        Uri.parse("${Constants.baseUrl}/products?limit=10&skip=0"),
      )).thenAnswer(
        (_) async => http.Response(jsonEncode(jsonResponse), 200),
      );

      // Act
      final products = await productService.getProducts();

      // Assert
      expect(products, isA<List<ProductModel>>());
      expect(products.length, 2);
      expect(products[0].title, 'Product 1');
      expect(products[1].title, 'Product 2');
    });

    test('getProducts throws an exception when the http call completes with an error', () async {
      // Arrange
      when(mockHttpClient.get(
        Uri.parse("${Constants.baseUrl}/products?limit=10&skip=0"),
      )).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      // Act & Assert
      expect(productService.getProducts(), throwsException);
    });

    test('getProducts increments skip value correctly', () async {
      // Arrange
      final jsonResponse = {
        "products": [
          {
            "id": 1,
            "title": "Product 1",
            "price": 29.99,
            "description": "Description 1",
            "category": "Category 1",
            "imageUrl": "https://example.com/image1.jpg",
            "rating": 4.5
          }
        ]
      };

      when(mockHttpClient.get(
        Uri.parse("${Constants.baseUrl}/products?limit=10&skip=0"),
      )).thenAnswer(
        (_) async => http.Response(jsonEncode(jsonResponse), 200),
      );

      // Act
      await productService.getProducts();
      // The skip value should now be 10
      await productService.getProducts();

      // Assert
      verify(mockHttpClient.get(
        Uri.parse("${Constants.baseUrl}/products?limit=10&skip=0"),
      )).called(1);

      verify(mockHttpClient.get(
        Uri.parse("${Constants.baseUrl}/products?limit=10&skip=10"),
      )).called(1);
    });
  });
}
