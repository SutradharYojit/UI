import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../../model/product_inventory.dart';
import '../../resources/color_manager.dart';
import '../../service/api_services.dart';
import '../../service/status_code.dart';
import '../add_expense/add_expense.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  ValueNotifier<List<ProductInventory>> productData = ValueNotifier([]);

  Future<void> getData() async {
    http.Response response = await http.get(
      Uri.parse("https://product-inventory-one.vercel.app/productInventory"),
    );
    if (response.statusCode == ServerStatusCodes.SUCESS) {
      var jsonData = jsonDecode(response.body);
      productData.value.add(ProductInventory.fromJson(jsonData));
      _loading.value = false;
    } else if (response.statusCode == ServerStatusCodes.PAGENOTFOUND) {
      _loading.value = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Product Inventory"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: ColorManager.whiteColor,
                context: context,
                builder: (ctx) {
                  return const AddNewExpense();
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _loading,
          builder: (context, value, child) {
            return value
                ? const Center(
                    child: SpinKitFoldingCube(
                      color: Colors.black,
                      size: 50.0,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: getData,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                        itemCount: productData.value.first.productList!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Title: ${productData.value.first.productList![index].title}"),
                                      Text("Price: ₹${productData.value.first.productList![index].price}"),
                                      Text("Quantity: ${productData.value.first.productList![index].quantity}"),
                                      Text("Description: ${productData.value.first.productList![index].description}"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await ApiServices()
                                              .deleteProduct(productData.value.first.productList![index].productId!);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Deleted Sucessfully"),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
