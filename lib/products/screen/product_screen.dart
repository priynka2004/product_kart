import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_kart/products/model/product_model.dart';
import 'package:product_kart/products/screen/add_product_screen.dart';
import 'package:product_kart/products/screen/product_detail_screen.dart';
import 'package:product_kart/products/screen/update_product_screen.dart';
import 'package:product_kart/products/service/product_service.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductService productService;
  List<ProductModel> productList = [];
  String? error;
  bool isLoading = false;


  Future getProducts() async {
    try {
      isLoading = true;
      setState(() {});

      productService = ProductService();
      productList = await productService.getProduct();
    } catch (e) {

      error = e.toString();
      if (kDebugMode) {
        print(error);
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    productService = ProductService();
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductKart'),
        actions: [
          IconButton(onPressed: ()async{
            await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AddProductScreen();
                        },
                      ),
                    );
                    getProducts();
                  },
           icon: const Icon(Icons.add)),
        ],
      ),
      body:isLoading?
      const Center(
        child: CircularProgressIndicator(),
      ):
      ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        ProductModel productModel = productList[index];
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
                        getProducts();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await productService
                              .deleteProduct(productModel.sId.toString());
                          await getProducts();
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
                Image.network(
                  productModel.imgUrl.toString(),
                  fit: BoxFit.fill,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.15,
                ),
                ListTile(
                  title: Text('Name : ${productModel.name}'),
                  subtitle: Text("Price : ${productModel.price.toString()}"),
                ),
              ],
            ),
          ),
        );
      }
    ),
    );
  }
}