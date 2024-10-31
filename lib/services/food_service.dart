// lib/services/food_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food.dart';

class FoodService {
  final String baseUrl = 'https://world.openfoodfacts.org/api/v0/product/';

  Future<List<Food?>> fetchFoods(List<String> barcodes) async {
    List<Food?> foods = [];
    for (String barcode in barcodes) {
      final response = await http.get(Uri.parse('$baseUrl$barcode.json'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // Pastikan produk ada sebelum memanggil Food.fromJson
        if (jsonData['product'] != null) {
          foods.add(Food.fromJson(jsonData));
        } else {
          foods.add(null); // Jika tidak ada produk, tambahkan null
        }
      } else {
        foods.add(null); // Jika gagal, tambahkan null
      }
    }
    return foods;
  }
}
