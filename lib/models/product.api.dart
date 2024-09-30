import 'dart:convert';
import 'product.dart';
import 'package:http/http.dart' as http;

class ProductApi{

  static Future<List<Product>> getProduct() async{

    var uri = Uri.https('fakestoreapi.com','/products');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body); // El JSON devuelto es una lista
      return Product.productsFromSnapshot(data); // Pasas la lista directamente
    } else {
      throw Exception('Failed to load products');
    }
  }
}