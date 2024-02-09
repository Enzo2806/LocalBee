import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:local_bee/Model/LocalShop.dart';

class LocalShopController {
  final String firebaseDatabaseURL = dotenv.env['FIREBASE_DATABASE_URL']!;

  /*
  * Fetches all local shops from the Firebase Realtime Database
  */
  Future<Map<String, List<LocalShop>>> fetchLocalShopsGroupedByType() async {
    final url = Uri.https(firebaseDatabaseURL, 'localShops.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final shopsMap = json.decode(response.body) as Map<String, dynamic>;
      Map<String, List<LocalShop>> groupedShops = {};

      // Assuming each shop has a 'type' property
      shopsMap.forEach((key, value) {
        final shop = LocalShop.fromMap(Map<String, dynamic>.from(value));
        if (!groupedShops.containsKey(shop.serviceType)) {
          groupedShops[shop.serviceType] = [];
        }
        groupedShops[shop.serviceType]!.add(shop);
      });

      return groupedShops;
    } else {
      throw Exception('Failed to fetch local shops.');
    }
  }

  /*
  * Saves a local shop to the Firebase Realtime Database
  */
  Future<void> saveLocalShop(LocalShop localShop) async {
    final url = Uri.https(firebaseDatabaseURL, '/localShops.json');

    try {
      // Convert the LocalShop to a map
      final shopData = localShop.toMap();

      // Send a POST request to save the local shop
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(shopData),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to save local shop.');
      }
    } catch (e) {
      print(e);
      // Handle exceptions by rethrowing or logging
      throw Exception('Failed to save local shop: $e');
    }
  }
}
