import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String description;

  Product({this.id, this.name, this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

Future<Product> fetchProduct() async {
  final response =
  await http.get('http://bigpicturepal.com/api/product/read_one.php?id=60');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Product.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Product>> getProducts() async {
  final response = await http
      .get('http://bigpicturepal.com/api/product/read.php');

  if (response.statusCode == 200) {
    var parsedProductList = json.decode(response.body);
    List<Product> products = List<Product>();
    parsedProductList.forEach((product) {
      products.add(Product.fromJson(product));
    });
    return products;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load ');
  }
}




