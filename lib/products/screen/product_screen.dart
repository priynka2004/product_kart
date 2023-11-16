import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:product_kart/products/model/product_model.dart';
import 'package:product_kart/products/screen/add_product_screen.dart';
import 'package:product_kart/products/screen/product_detail_screen.dart';
import 'package:product_kart/products/screen/update_product_screen.dart';
import 'package:product_kart/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductProvider productProvider;

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      productProvider.fetchProduct();
    });
    super.initState();
  }

  Future<void> fetchProducts() async {
    await productProvider.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (BuildContext context, ProductProvider provider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('ProductKart'),
            actions: [
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AddProductScreen();
                      },
                    ),
                  );
                  provider.fetchProduct();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) {
                    ProductModel productModel = provider.productList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailScreen(
                                productModel: productModel,
                              );
                            },
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UpdateProduct(
                                            productModel: productModel,
                                          );
                                        },
                                      ),
                                    );
                                    provider.fetchProduct();
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    provider.isLoading = true;
                                    try {
                                      await productProvider.productService
                                          .deleteProduct(
                                              productModel.sId.toString());
                                      await provider.fetchProduct();
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                    } finally {
                                      provider.isLoading = false;
                                    }
                                  },
                                  icon: const Icon(Icons.delete),
                                )
                              ],
                            ),
                            Image.network(
                              productModel.imgUrl.toString(),
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                            ListTile(
                              title: Text('Name : ${productModel.name}'),
                              subtitle: Text(
                                "Price : ${productModel.price.toString()}",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
