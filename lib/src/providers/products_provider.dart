import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_form_validation/src/models/product_model.dart';

class ProductsProvider {
  final String _url = "https://practica-4480e.firebaseio.com";

  Future<bool> createProduct(ProductModel product) async {
    final url = Uri.parse('$_url/products.json');

    final resp = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print("decodedData $decodedData");

    return true;
  }

  Future<List<ProductModel>> loadProducts() async {
    final url = Uri.parse('$_url/products.json');

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductModel> products = [];

    if (decodedData == null) return [];

    decodedData.forEach((id, product) {
      final productTemp = ProductModel.fromJson(product);
      productTemp.id = id;

      products.add(productTemp);
    });

    return products;
  }

  Future<int> deleteProduct(String id) async {
    final url = Uri.parse('$_url/products/$id.json');

    final resp = await http.delete(url);

    return 1;
  }
}
