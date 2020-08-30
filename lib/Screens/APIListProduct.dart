import 'dart:convert';
import 'package:camreatest/Models/Product.dart';
import 'package:camreatest/Screens/ListItem.dart';
import 'package:camreatest/Screens/ListItemProduct.dart';
import 'package:camreatest/Utils/API.dart';
import 'package:flutter/material.dart';

class APIListProduct extends StatefulWidget {
  @override
  _APIListState createState() => _APIListState();
}

class _APIListState extends State<APIListProduct> {
  var products = new List<Product>();

  _getProducts() {
    API.getAllProductsFromApi().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        products = list.map((model) => Product.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getProducts();
  }

  dispose() {
    super.dispose();
  }

  void _onPressed(Product product, String appBarTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListItemProduct(product, appBarTitle);
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
