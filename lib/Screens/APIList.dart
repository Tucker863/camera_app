import 'dart:convert';
import 'package:camreatest/Screens/ListItem.dart';
import 'package:camreatest/Utils/API.dart';
import 'package:flutter/material.dart';

class APIList extends StatefulWidget {
  @override
  _APIListState createState() => _APIListState();
}

class _APIListState extends State<APIList> {
  var products = new List<ProductMax>();

  _getUsers() {
    API.getProductsFromApi().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        products = list.map((model) => ProductMax.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  String _value = 'Hello World';

  void _onPressed(ProductMax product, String appBarTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListItem(product, appBarTitle);
    }));
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("API List"),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: RaisedButton(
                    onPressed: () =>
                        _onPressed(products[index], products[index].name),
                    child: new Text(products[index].name)));
          },
        ));
  }
}

class ProductMax {
  int id;
  String name;
  String description;
  double price;
  int category_id;
  String category_name;

  ProductMax(int id, String name, String description, double price,
      int category_id, String category_name) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.price = price;
    this.category_id = category_id;
    this.category_name = category_name;
  }

  ProductMax.fromJson(Map json)
      : id = int.parse(json['id']),
        name = json['name'],
        description = json['description'],
        price = double.parse(json['price']),
        category_id = int.parse(json['category_id']),
        category_name = json['category_name'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category_id': category_id,
      'category_name': category_name
    };
  }
}
