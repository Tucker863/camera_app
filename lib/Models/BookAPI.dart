import 'package:http/http.dart' as http;
import 'dart:convert';

class BookAPI {
  String kind;
  String id;
  String subject;
  String isbn;
  String publishedDate;
  String description;

  BookAPI(String kind, String id, String subject, String isbn,
      String publishedDate, String description) {
    this.kind = kind;
    this.id = id;
    this.subject = subject;
    this.isbn = isbn;
    this.publishedDate = publishedDate;
    this.description = description;
  }

  BookAPI.fromJson(Map json)
      : kind = json['kind'],
        id = json['id'],
        subject = json['subject'],
        isbn = json['isbn'],
        publishedDate = json['publishedDate'],
        description = json['description'];
  Map toJson() {
    return {
      'kind': kind,
      'id': id,
      'subject': subject,
      'isbn': isbn,
      'publishedDate': publishedDate,
      'description': description
    };
  }
}
