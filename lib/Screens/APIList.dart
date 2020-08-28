import 'dart:convert';
import 'package:camreatest/Models/Book.dart';
import 'package:camreatest/Screens/ListItem.dart';
import 'package:camreatest/Utils/API.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';

class APIList extends StatefulWidget {
  @override
  _APIListState createState() => _APIListState();
}

class _APIListState extends State<APIList> {
  var products = new List<Book>();

  _getUsers() {
    API.getAllBooksFromApi().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        products = list.map((model) => Book.fromJson(model)).toList();
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

  void _onPressed(Book book, String appBarTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListItem(book, appBarTitle);
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
                        _onPressed(products[index], products[index].title),
                    child: new Text(products[index].title)));
          },
        ));
  }
}
