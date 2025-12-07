import 'package:stgen_test/models/menu_item.dart';

class CartItem {
  final MenuItem menuItem;

  const CartItem({required this.menuItem});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          menuItem == other.menuItem;

  @override
  int get hashCode => menuItem.hashCode;
}
