import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/product_page.dart';

void main() {
  testWidgets('SalePage shows header and promo text',
      (WidgetTester tester) async {
    // ensure a wide test window so the header filter row doesn't overflow
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: SalePage()));

    // The page uses a custom header; assert the body heading is present
    expect(find.text('SALE'), findsOneWidget);
    expect(find.textContaining("Don't miss out"), findsOneWidget);
    expect(find.text('All prices shown are inclusive of the discount'),
        findsOneWidget);
  });

  testWidgets('SalePage shows dropdowns and product cards',
      (WidgetTester tester) async {
    // run tests using a wide window to avoid RenderFlex overflow in the test environment
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: SalePage()));

    // Dropdown labels
    expect(find.text('All products'), findsOneWidget);
    expect(find.text('Best selling'), findsOneWidget);

    // Product cards by key
    expect(find.byKey(const Key('sale_card_0')), findsOneWidget);
    expect(find.byKey(const Key('sale_card_1')), findsOneWidget);
    expect(find.byKey(const Key('sale_card_2')), findsOneWidget);
  });

  testWidgets('Tapping a product navigates to ProductPage',
      (WidgetTester tester) async {
    // widen the test window to avoid layout overflows in the test environment
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: SalePage()));

    // Tap first product card
    final firstCard = find.byKey(const Key('sale_card_0'));
    expect(firstCard, findsOneWidget);
    await tester.tap(firstCard);

    // Wait for navigation
    await tester.pumpAndSettle();

    // Should navigate to ProductPage
    expect(find.byType(ProductPage), findsOneWidget);
    expect(find.text('Classic Sweatshirt'), findsOneWidget);
  });
}
