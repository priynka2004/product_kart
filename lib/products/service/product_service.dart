import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:product_kart/api_endpoint.dart';
import 'package:product_kart/products/model/product_model.dart';
import 'package:product_kart/products/screen/product_response.dart';


class ProductService {
  Future<List<ProductModel>> getProduct() async {
    String url = ApiEndpoints.product;
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(body);
      ProductResponse productResponse = ProductResponse.fromJson(data);
      return productResponse.products;
    } else {
      throw 'Something went wrong';
    }
  }

  Future<void> addProduct(ProductModel product) async {
    String url = ApiEndpoints.addProductUrl();

    final map = product.toJson();
    String productStr = jsonEncode(map);

    Response response = await http.post(
      Uri.parse(url),
      body: productStr,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
    }
    if (kDebugMode) {
      print('Response Body: ${response.body}');
    }

    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(body);
      print(data);
    } else {
      // Error handling here
      print('Something went wrong');
      // You can throw an exception or handle the error as needed.
    }
  }

  Future<void> deleteProduct(String id) async {
    String url = ApiEndpoints.getProductUrl(id);

    Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(body);
      print(data);
    } else {
      throw 'Something went wrong';
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    String url = ApiEndpoints.getProductUrl(product.sId!);

    final map = product.toJson();
    String productStr = jsonEncode(map);

    Response response = await http.put(
      Uri.parse(url),
      body: productStr,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(body);
      print(data);
    } else {
      throw 'Something went wrong';
    }
  }

  Future<ProductModel> getSingeProduct(String id) async {
    String url = ApiEndpoints.getProductUrl(id);

    Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(
        body,
      );
      ProductModel product = ProductModel.fromJson(data);
      return product;
    }

    throw 'Something went wrong';
  }
}