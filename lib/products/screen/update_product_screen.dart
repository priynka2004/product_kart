import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_kart/products/model/product_model.dart';
import 'package:product_kart/provider/product_provider.dart';
import 'package:provider/provider.dart';

class UpdateProduct extends StatefulWidget {
  final ProductModel productModel;

  const UpdateProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController imageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    ProductModel product = widget.productModel;
    imageController.text = product.imgUrl ?? '';
    nameController.text = product.name ?? '';
    priceController.text = product.price?.toString() ?? '';
    descriptionController.text = product.description ?? '';
    super.initState();
  }

  Future update() async {
    ProductModel productModel = ProductModel(
        sId: widget.productModel.sId,
        name: nameController.text,
        imgUrl: imageController.text,
        price: int.parse(priceController.text),
        description: descriptionController.text);

    try {
      ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
      await productProvider.updateProduct(productModel);
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
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: imageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Image',
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () async {
                  await update();
                  Navigator.pop(context);
                },
                child: const Text('Update Product'),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}