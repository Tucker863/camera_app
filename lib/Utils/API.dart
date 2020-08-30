import 'dart:async';
import 'package:http/http.dart' as http;

const bookUrl = "http://bigpicturepal.com/lumen-api/books/";
const productUrl = "http://bigpicturepal.com/lumen-api/products/";
const bookAPIUrl = "https://www.googleapis.com/books/v1/volumes?q=isbn:";

class API {
  static Future getAllBooksFromApi() {
    var url = bookUrl;
    return http.get(url);
  }

  static Future getBookFromApi(String id) {
    var urlBook = bookUrl;
    return http.get(urlBook + id);
  }

  static Future getAllProductsFromApi() {
    var url = productUrl;
    return http.get(url);
  }

  static Future getProductFromApi(String id) {
    var urlProduct = productUrl;
    return http.get(urlProduct + id);
  }

  static Future getGoogleBookFromApi(String id) {
    var book = bookAPIUrl;
    return http.get(book + id);
  }
}
