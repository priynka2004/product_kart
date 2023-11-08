import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_kart/products_products/model/product_model.dart';
import 'package:product_kart/products_products/service/product_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController imageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ratingController = TextEditingController();

  Future addProduct() async {
    ProductModel productModel = ProductModel(
        name: nameController.text,
        imgUrl: imageController.text,
        price: int.parse(priceController.text),
        description: descriptionController.text);
    try {
      ProductService productApi = ProductService();
      await productApi.addProduct(productModel);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image',
              ),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                addProduct();
                Navigator.pop(context);
              },
              child: const Text('Add Product'),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
