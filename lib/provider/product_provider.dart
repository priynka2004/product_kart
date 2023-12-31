import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:product_kart/products/model/product_model.dart';
import 'package:product_kart/products/service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  late ProductService productService;
  late bool isLoading;
  late ProductModel productModel;

  ProductProvider() {
    productService = ProductService();
    isLoading = false;
  }

  Future<void> fetchProduct() async {
    try {
      isLoading = true;
      notifyListeners();
      productList = await productService.getProduct();

      print(productList);
    } catch (error) {
      print('Error fetching products: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> updateProduct(ProductModel product) async {
    try {
      ProductService productService = ProductService();
      await productService.updateProduct(product);
      notifyListeners();
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      ProductService productService = ProductService();
      await productService.addProduct(product);
      await fetchProduct();
    } catch (e) {
      print('Error adding product: $e');
    }
  }
}



