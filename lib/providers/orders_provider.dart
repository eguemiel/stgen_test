import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stgen_test/models/cart_item.dart';
import 'package:stgen_test/models/order.dart';
import 'package:uuid/uuid.dart';

class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier() : super([]);

  void addOrder({
    required String customerName,
    required List<CartItem> items,
    required double subtotal,
    required double discount,
    required double total,
  }) {
    const uuid = Uuid();
    final order = Order(
      id: uuid.v4(),
      customerName: customerName,
      items: List.from(items),
      subtotal: subtotal,
      discount: discount,
      total: total,
      createdAt: DateTime.now(),
    );

    state = [...state, order];
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<Order>>((
  ref,
) {
  return OrdersNotifier();
});
