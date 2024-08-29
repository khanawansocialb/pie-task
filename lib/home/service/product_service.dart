import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_task/config/constants.dart';
import 'package:pie_task/home/model/product_model.dart';

final class ProductService {
  int _skip = 0;
  Future<List<ProductModel>> getProducts() async {
    
    debugPrint("skip numer is: $_skip");
    var res = await http.get(
        Uri.parse("${Constants.baseUrl}/products?limit=10&skip=$_skip"));
    List<ProductModel> products = List.from(jsonDecode(res.body)["products"])
        .map((json) => ProductModel.fromJson(json))
        .toList();
   _skip += 10;     
    return products;
  }
}
