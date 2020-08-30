import 'dart:convert';

import 'package:camreatest/Models/BookAPI.dart';
import 'package:camreatest/Models/Book.dart';
import 'package:camreatest/Utils/API.dart';
import 'package:flutter/material.dart';

class ListItemBookAPI extends StatefulWidget {
  final String appBarTitle;
  final Book book;

  ListItemBookAPI(this.book, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return ListItemBookAPIState(this.book, this.appBarTitle);
  }
}

class ListItemBookAPIState extends State<ListItemBookAPI> {
  String appBarTitle;
  Book book;
  _getBookDetail() {
    API.getGoogleBookFromApi(book.isbn).then((response) {
      setState(() {
        Map<String, dynamic> detail = json.decode(response.body);
        var bookAPI = detail['kind']['ind']['subject']['isbn'][''];
      });
    });
  }

  initState() {
    super.initState();
    _getBookDetail();
  }

  dispose() {
    super.dispose();
  }

  ListItemBookAPIState(this.book, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    book.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  book.storage,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text(book.year.toString()),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        book.origRetail,
        softWrap: true,
      ),
    );
    return MaterialApp(
        title: appBarTitle,
        home: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Write some code to control things, when user press back button in AppBar
                  moveToLastScreen();
                }),
          ),
          body: ListView(
            children: [
              titleSection,
              Image.asset(
                'assets/logov1.jpg',
                width: 240,
                height: 240,
                fit: BoxFit.contain,
              ),
              buttonSection,
              textSection,
            ],
          ),
        ));
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
