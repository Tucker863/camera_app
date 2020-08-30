import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  int id;
  String name;
  String description;

  Product(int id, String name, String description) {
    this.id = id;
    this.name = name;
    this.description = description;
  }

  Product.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        description = json['description'];

  Map toJson() {
    return {'id': id, 'title': name, 'author': description};
  }
}
