import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> makePostRequest(String title, String author) async {
  final uri = 'http://httpbin.org/post';
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {'title': title, 'author': author};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  String responseBody = response.body;
}

class Album {
  final int id;
  final String title;
  final String author;

  Album({this.id, this.title, this.author});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      author: json['author'],
    );
  }
}

class FormField extends StatefulWidget {
  FormField({Key key}) : super(key: key);

  @override
  _FormFieldState createState() {
    return _FormFieldState();
  }
}

class _FormFieldState extends State<FormField> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerAuthor = TextEditingController();
  Future<Album> _futureAlbum;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _controllerTitle,
                      decoration: InputDecoration(hintText: 'Enter Title'),
                    ),
                    TextField(
                      controller: _controllerAuthor,
                      decoration: InputDecoration(hintText: 'Enter Author'),
                    ),
                    RaisedButton(
                      child: Text('Create Data'),
                      onPressed: () {
                        setState(() {
                          _futureAlbum = makePostRequest(
                              _controllerTitle.text, _controllerAuthor.text);
                        });
                      },
                    ),
                  ],
                )
              : FutureBuilder<Album>(
                  future: _futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.title);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
        ),
      ),
    );
  }
}
