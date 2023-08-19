import 'dart:convert';
import 'dart:developer';
import 'package:assignment_2/model/product_inventory.dart';
import 'package:assignment_2/service/status_code.dart';
import 'package:http/http.dart' as http;

import 'api_constants.dart';

class ApiServices {
  Future data(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == ServerStatusCodes.SUCESS) {
      var jsonData = jsonDecode(response.body);
      return ProductInventory.fromJson(jsonData);
    }
    else {
      log(response.statusCode.toString());
    }
  }

  Future<void> deleteProduct(String productId) async {
    final String apiUrl = '${APIConstants.baseURL}/$productId';

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers:APIConstants.header,
    );

    if (response.statusCode == 200) {
      print('Product with ID $productId has been deleted.');
    } else {
      print('Failed to delete product. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> addProduct(Map<String,String> product) async {
    const String apiUrl = APIConstants.baseURL;

    final response = await http.post(
      Uri.parse(apiUrl),
      body: product
    );

    if (response.statusCode == 201) {
      print('Product with ID has been add.');
    } else {
      print('Failed to delete product. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}