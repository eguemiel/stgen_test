import 'package:flutter/services.dart';
import 'package:stgen_test/models/menu_item.dart';
import 'dart:convert';

class MenuService {
  Future<List<MenuItem>> fetchMenu() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await rootBundle.loadString('assets/menu_items.json');
      final data = jsonDecode(response);
      return (data['items'] as List)
          .map(
            (item) => MenuItem(
              name: item['name'],
              price: item['price'],
              type: MenuItemType.values.byName(item['type']),
              imageUrl: item['imageUrl'],
              description: item['description'],
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to load menu: $e');
    }
  }
}
