import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/cart_page.dart';

void main() {
  group('CartService Tests', () {
    setUp(() {
      // Clear the cart before each test
      CartService().clearCart();
    });

    test('CartService is a singleton', () {
      final service1 = CartService();
      final service2 = CartService();
      expect(identical(service1, service2), true);
    });

    test('subtotal calculates correctly', () {
      final service = CartService();
      final item1 = CartItem(
        id: 'item1',
        title: 'Product 1',
        price: '£10.00',
        asset: 'asset1.png',
        quantity: 2,
      );
      final item2 = CartItem(
        id: 'item2',
        title: 'Product 2',
        price: '£5.00',
        asset: 'asset2.png',
        quantity: 1,
      );

      service.addItem(item1);
      service.addItem(item2);

      expect(service.subtotal, 25.0);
    });

    test('tax calculates at 20%', () {
      final service = CartService();
      final item = CartItem(
        id: 'item1',
        title: 'Product',
        price: '£10.00',
        asset: 'asset.png',
        quantity: 1,
      );

      service.addItem(item);

      expect(service.tax, 2.0);
    });

    test('total includes subtotal and tax', () {
      final service = CartService();
      final item = CartItem(
        id: 'item1',
        title: 'Product',
        price: '£10.00',
        asset: 'asset.png',
        quantity: 1,
      );

      service.addItem(item);

      expect(service.total, 12.0);
    });
  });

  group('CartPage Widget Tests', () {
    testWidgets('CartPage shows empty state when cart is empty',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1024, 900));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });

      CartService().clearCart();
      await tester.pumpWidget(const MaterialApp(home: CartPage()));

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Continue Shopping'), findsOneWidget);
    });

    testWidgets('CartPage shows items when cart has items',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });

      CartService().clearCart();
      final cartService = CartService();
      cartService.addItem(CartItem(
        id: 'item1',
        title: 'Test Product',
        price: '£10.00',
        asset: 'assets/images/notebook.png',
        quantity: 1,
      ));

      await tester.pumpWidget(const MaterialApp(home: CartPage()));

      expect(find.text('Shopping Cart'), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.textContaining('£10.00'), findsWidgets);
    });

    testWidgets('CartPage shows order summary with calculations',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });

      CartService().clearCart();
      final cartService = CartService();
      cartService.addItem(CartItem(
        id: 'item1',
        title: 'Test Product',
        price: '£10.00',
        asset: 'assets/images/notebook.png',
        quantity: 1,
      ));

      await tester.pumpWidget(const MaterialApp(home: CartPage()));

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.textContaining('Subtotal'), findsWidgets);
      expect(find.textContaining('Tax (20%)'), findsWidgets);
      expect(find.text('Place Order'), findsOneWidget);
    });

    testWidgets('CartPage remove item button removes item from cart',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() async {
        await tester.binding.setSurfaceSize(null);
      });

      CartService().clearCart();
      final cartService = CartService();
      cartService.addItem(CartItem(
        id: 'item1',
        title: 'Test Product',
        price: '£10.00',
        asset: 'assets/images/notebook.png',
        quantity: 1,
      ));

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      expect(find.text('Test Product'), findsOneWidget);

      final deleteButton = find.byIcon(Icons.delete_outline);
      expect(deleteButton, findsOneWidget);

      await tester.tap(deleteButton);
      await tester.pumpWidget(const MaterialApp(home: CartPage()));

      expect(find.text('Your cart is empty'), findsOneWidget);
    });
  });
}
