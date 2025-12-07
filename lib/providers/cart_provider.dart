import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stgen_test/models/cart_item.dart';
import 'package:stgen_test/models/menu_item.dart';
import 'package:stgen_test/services/discount_service.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  final _discountService = DiscountService();

  String? addItem(MenuItem menuItem) {
    final existingItem = state.firstWhere(
      (item) => item.menuItem.name == menuItem.name,
      orElse: () => CartItem(menuItem: menuItem),
    );

    if (state.contains(existingItem)) {
      return 'Item already in cart. Each order can only contain one of each item.';
    }

    if (menuItem.type == MenuItemType.sandwich) {
      final hasSandwich = state.any(
        (item) => item.menuItem.type == MenuItemType.sandwich,
      );
      if (hasSandwich) {
        return 'A sandwich cannot be added to the cart. Only one sandwich can be added per order.';
      }
    }

    if (menuItem.type == MenuItemType.fries) {
      final hasFries = state.any(
        (item) => item.menuItem.type == MenuItemType.fries,
      );
      if (hasFries) {
        return 'Fries cannot be added to the cart. Only one fries can be added per order.';
      }
    }

    if (menuItem.type == MenuItemType.drink) {
      final hasDrink = state.any(
        (item) => item.menuItem.type == MenuItemType.drink,
      );
      if (hasDrink) {
        return 'A drink cannot be added to the cart. Only one drink can be added per order.';
      }
    }

    state = [...state, existingItem];
    return null;
  }

  void removeItem(CartItem cartItem) {
    state = state.where((item) => item != cartItem).toList();
  }

  void clear() {
    state = [];
  }

  double getSubtotal() {
    return state.fold(0.0, (sum, item) => sum + item.menuItem.price);
  }

  Map<String, dynamic> getDiscount() {
    return _discountService.calculateDiscount(state);
  }

  double getTotal() {
    final subtotal = getSubtotal();
    final discount = getDiscount()['amount'] as double;
    return subtotal - discount;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
