import 'package:camreatest/Models/Book.dart';
import 'package:camreatest/Screens/APIListProduct.dart';
import 'package:camreatest/Screens/ListItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:camreatest/Utils/API.dart';
import 'package:camreatest/Screens/APIListSearch.dart';

/// This Widget is the main application widget.
class MainList extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _titleOptions = <Widget>[
    Text(
      'List of Books',
      style: optionStyle,
    ),
    Text(
      'List of Products',
      style: optionStyle,
    ),
    Text(
      'List of Boxes',
      style: optionStyle,
    ),
  ];

  static List<StatefulWidget> _stateOptions = <StatefulWidget>[
    APIList(),
    APIListSearch(),
    APIListProduct(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logov1.jpg',
              fit: BoxFit.contain,
              height: 56,
            ),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: _titleOptions.elementAt(_selectedIndex))
          ],
        ),
      ),
      body: Center(
        child: _stateOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('List of Books'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Search Books'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('List of Boxes'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class APIList extends StatefulWidget {
  @override
  _APIListState createState() => _APIListState();
}

class _APIListState extends State<APIList> {
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
