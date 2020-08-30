import 'package:http/http.dart' as http;
import 'dart:convert';

class Book {
  int id;
  String title;
  String author;
  String subject;
  String isbn;
  String year;
  String origRetail;
  String storage;

  Book(int id, String title, String author, String subject, String isbn,
      String year, String origRetail, String storage) {
    this.id = id;
    this.title = title;
    this.author = author;
    this.subject = subject;
    this.isbn = isbn;
    this.year = year;
    this.origRetail = origRetail;
    this.storage = storage;
  }

  Book.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        subject = json['subject'],
        isbn = json['isbn'],
        year = json['year'],
        origRetail = json['origRetail'],
        storage = json['storage'];

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'subject': subject,
      'isbn': isbn,
      'year': year,
      'origRetail': origRetail,
      'storage': storage
    };
  }
}
