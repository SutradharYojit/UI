import 'dart:convert';

class APIConstants {
  static const String baseURL = "https://product-inventory-one.vercel.app/productInventory";
  static Map<String, String>? header = {
    'Authorization': 'Basic ${base64Encode(utf8.encode('Yojit:78945'))}',
  };
}
