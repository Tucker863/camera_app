import 'package:flutter/material.dart';
import 'package:camreatest/Screens/todo_list.dart';
import 'Screens/ImageScreen.dart';
import 'dart:convert';
import 'package:camreatest/Utils/API.dart';
import 'package:camreatest/Screens/APIList.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/second': (context) => ImageScreen(),
      '/third': (context) => APIList(),
      '/todoapp': (context) => TodoApp(),
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
              child: Text('Take a video'),
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

class TodoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'TodoList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: TodoList(),
    );
  }
}
