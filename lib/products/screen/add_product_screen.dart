import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_kart/products/model/product_model.dart';
import 'package:product_kart/products/service/product_service.dart';
import 'package:product_kart/products/validators.dart';


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


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
      body:  Form(
    key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: imageController,
                  validator: (String? value) {
                    return Validators.imageValidator(value);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Image',
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: nameController,
                  validator: (String? value) {
                    return Validators.nameValidator(value);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: priceController,
                  validator: (String? value) {
                    return Validators.priceValidator(value);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: descriptionController,
                  validator: (String? value) {
                    return Validators.descriptionValidator(value);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(height: 16,),
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
        ),
      ),
    );
  }
}
