import 'package:flutter/material.dart';
import 'package:camreatest/Screens/todo_list.dart';
import 'Screens/GalleryImage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'Screens/ImageScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'Screens/MainList.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/second': (context) => ImageScreen(),
      '/third': (context) => MainList(),
      '/todoapp': (context) => TodoList(),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera utilization'),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image(image: new AssetImage("assets/logo.gif")),
            new RaisedButton(
              child: Text('Take a picture'),
              elevation: 5.0,
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/second');
              },
            ),
            new RaisedButton(
              child: Text('List App'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/third');
              },
            ),
            new RaisedButton(
              child: Text('List App'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/todoapp');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://bigpicturepal.com/Tucker_api/product/read.php"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      data = json.decode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data[index]["description"]),
          );
        },
      ),
    );
  }
}
