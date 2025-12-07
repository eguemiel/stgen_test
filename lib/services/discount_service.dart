import 'package:stgen_test/models/cart_item.dart';
import 'package:stgen_test/models/menu_item.dart';

class DiscountService {
  Map<String, dynamic> calculateDiscount(List<CartItem> items) {
    if (items.isEmpty) {
      return {'amount': 0.0, 'description': ''};
    }

    final hasSandwich = items.any(
      (item) => item.menuItem.type == MenuItemType.sandwich,
    );
    final hasFries = items.any(
      (item) => item.menuItem.type == MenuItemType.fries,
    );
    final hasDrink = items.any(
      (item) => item.menuItem.type == MenuItemType.drink,
    );

    final subtotal = items.fold(0.0, (sum, item) => sum + item.menuItem.price);

    if (hasSandwich && hasFries && hasDrink) {
      return {
        'amount': subtotal * 0.20,
        'description': '20% discount on all items',
      };
    }

    if (hasSandwich && hasDrink) {
      return {
        'amount': subtotal * 0.15,
        'description': '15% discount on sandwich and drink',
      };
    }

    if (hasSandwich && hasFries) {
      return {
        'amount': subtotal * 0.10,
        'description': '10% discount on sandwich and fries',
      };
    }

    return {'amount': 0.0, 'description': ''};
  }
}
