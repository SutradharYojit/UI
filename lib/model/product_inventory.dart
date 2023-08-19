class ProductInventory {
  int? count;
  List<ProductList>? productList;
  Request? request;

  ProductInventory({this.count, this.productList, this.request});

  ProductInventory.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
    request =
    json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.productList != null) {
      data['productList'] = this.productList!.map((v) => v.toJson()).toList();
    }
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    return data;
  }
}

class ProductList {
  String? productId;
  String? title;
  String? price;
  String? quantity;
  String? description;

  ProductList(
      {this.productId,
        this.title,
        this.price,
        this.quantity,
        this.description});

  ProductList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    return data;
  }
}

class Request {
  String? type;

  Request({this.type});

  Request.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}
