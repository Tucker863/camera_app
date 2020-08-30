import 'package:flutter/foundation.dart';

class Book_insert {
  String title;
  String author;

  Book_insert({
    @required this.title,
    @required this.author,
  });

  Map<String, dynamic> toJson() {
    return {"title": title, "author": author};
  }
}
