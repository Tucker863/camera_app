import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://bigpicturepal.com/Tucker_api/product/read.php";

class API {
  static Future getProductsFromApi() {
    var url = baseUrl;
    return http.get(url);
  }
}