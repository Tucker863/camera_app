import 'package:camreatest/Screens/ListItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:camreatest/Screens/APIList.dart';
import 'package:camreatest/Utils/API.dart';

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

  static List<StatefulWidget> _stateOptions = <StatefulWidget>[
    APIList(),
    APIList(),
    APIList(),
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
        title: const Text('List Home Screen'),
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
            title: Text('List of Cars'),
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

  void _onPressed(ProductMax product, String appBarTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ListItem(product, appBarTitle);
    }));
  }

  @override
  build(context) {
    return Scaffold(
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
