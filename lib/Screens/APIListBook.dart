import 'dart:convert';
import 'package:camreatest/Models/Book.dart';
import 'package:camreatest/Models/BookAPI.dart';
import 'package:camreatest/Screens/ListItem.dart';
import 'package:camreatest/Utils/API.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';

class APIListBook extends StatefulWidget {
  @override
  _APIListState createState() => _APIListState();
}

class _APIListState extends State<APIListBook> {
  var books = new List<Book>();

  _getBooks() {
    API.getAllBooksFromApi().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        books = list.map((model) => Book.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getBooks();
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
        body: ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: RaisedButton(
                onPressed: () => _onPressed(books[index], books[index].title),
                child: new Text(books[index].title)));
      },
    ));
  }
}
