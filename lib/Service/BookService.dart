import 'dart:convert';
import 'package:camreatest/Models/Book.dart';
import 'package:camreatest/Models/Book_insert.dart';
import 'package:camreatest/Models/api_response.dart';
import 'package:http/http.dart' as http;

class BookService {
  static const API = 'http://bigpicturepal.com/lumen-api/books';

  Future<APIResponse<List<Book>>> getBooksList() {
    return http.get(API).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final books = <Book>[];
        for (var item in jsonData) {
          books.add(Book.fromJson(item));
        }
        return APIResponse<List<Book>>(data: books);
      }
      return APIResponse<List<Book>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<List<Book>>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Book>> getBook(String bookID) {
    return http.get(API + bookID).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Book>(data: Book.fromJson(jsonData));
      }
      return APIResponse<Book>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Book>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createNote(Book_insert item) {
    return http.post(API, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}
