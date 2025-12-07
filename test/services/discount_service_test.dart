import 'package:flutter_test/flutter_test.dart';
import 'package:stgen_test/models/cart_item.dart';
import 'package:stgen_test/models/menu_item.dart';
import 'package:stgen_test/services/discount_service.dart';

void main() {
  group('DiscountService', () {
    late DiscountService discountService;

    setUp(() {
      discountService = DiscountService();
    });

    test(
      'Should calculate 20% discount when there is sandwich, fries and drink',
      () {
        final sandwich = MenuItem(
          name: 'Burger',
          price: 5.0,
          type: MenuItemType.sandwich,
          imageUrl: '',
          description: '',
        );
        final fries = MenuItem(
          name: 'Fries',
          price: 2.0,
          type: MenuItemType.fries,
          imageUrl: '',
          description: '',
        );
        final drink = MenuItem(
          name: 'Drink',
          price: 2.50,
          type: MenuItemType.drink,
          imageUrl: '',
          description: '',
        );

        final cartItems = [
          CartItem(menuItem: sandwich),
          CartItem(menuItem: fries),
          CartItem(menuItem: drink),
        ];

        final result = discountService.calculateDiscount(cartItems);
        final subtotal = 5.0 + 2.0 + 2.50;
        final expectedDiscount = subtotal * 0.20;

        expect(result['amount'], equals(expectedDiscount));
        expect(result['description'], equals('20% discount on all items'));
      },
    );

    test(
      'Should not apply discount when there are no eligible combinations',
      () {
        final sandwich = MenuItem(
          name: 'Burger',
          price: 5.0,
          type: MenuItemType.sandwich,
          imageUrl: '',
          description: '',
        );

        final cartItems = [CartItem(menuItem: sandwich)];

        final result = discountService.calculateDiscount(cartItems);

        expect(result['amount'], equals(0.0));
        expect(result['description'], equals(''));
      },
    );

    test('Should not apply discount when the cart is empty', () {
      final cartItems = <CartItem>[];

      final result = discountService.calculateDiscount(cartItems);

      expect(result['amount'], equals(0.0));
      expect(result['description'], equals(''));
    });
  });
}
