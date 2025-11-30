import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/sale_page.dart';

void main() {
  testWidgets('SalePage shows header and promo text',
      (WidgetTester tester) async {
    // ensure a wide test window so the header filter row doesn't overflow
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: SalePage()));

    // Find the AppBar title specifically (there is also a body heading with 'SALE')
    expect(find.widgetWithText(AppBar, 'SALE'), findsOneWidget);
    expect(find.textContaining("Don't miss out"), findsOneWidget);
    expect(find.text('All prices shown are inclusive of the discount'),
        findsOneWidget);
  });

  testWidgets('SalePage shows dropdowns and product cards',
      (WidgetTester tester) async {
    // run tests using a wide window to avoid RenderFlex overflow in the test environment
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
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

  testWidgets('Tapping a product shows a SnackBar (dummy)',
      (WidgetTester tester) async {
    // widen the test window to avoid layout overflows in the test environment
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: SalePage()));

    // Tap first product card
    final firstCard = find.byKey(const Key('sale_card_0'));
    expect(firstCard, findsOneWidget);
    await tester.tap(firstCard);

    // Let SnackBar animation run
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.textContaining('Classic Sweatshirt (dummy)'), findsOneWidget);
  });
}
