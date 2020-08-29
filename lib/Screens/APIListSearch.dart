import 'dart:convert';
import 'package:camreatest/Models/Book.dart';
import 'package:camreatest/Screens/ListItem.dart';
import 'package:camreatest/Utils/API.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';

class APIListSearch extends StatefulWidget {
  @override
  _APIListSearchState createState() => _APIListSearchState();
}

class _APIListSearchState extends State<APIListSearch> {
  var books = new List<Book>();
  var products = new List<String>();

  _getUsers() {
    API.getAllBooksFromApi().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        books = list.map((model) => Book.fromJson(model)).toList();
        products = books.map((e) => e.title).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(products));
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('Search Book by Title'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            products[index],
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
