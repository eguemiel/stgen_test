import 'package:stgen_test/models/cart_item.dart';

class Order {
  final String id;
  final String customerName;
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double total;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.customerName,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.createdAt,
  });

  double get discountPercentage =>
      discount > 0 ? (discount / subtotal) * 100 : 0;
}
