import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/product_page.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: ProductPage(
          title: 'Test Product',
          price: '£9.99',
          asset: 'assets/images/notebook.png',
        ),
      );
    }

    testWidgets('displays product title, price and description',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£9.99'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('has three dropdowns and two action buttons', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Three DropdownButton<String> widgets: Color, Size, Quantity
      expect(find.byType(DropdownButton<String>), findsNWidgets(3));

      // Action buttons
      expect(find.text('ADD TO CART'), findsOneWidget);
      expect(find.text('Buy with shop'), findsOneWidget);
    });

    testWidgets(
        'selecting options updates state and add to cart shows snackbar',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Open Color dropdown and select 'Green'
      await tester.tap(find.byType(DropdownButton<String>).at(0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Green').last);
      await tester.pumpAndSettle();

      // Open Size dropdown and select 'M'
      await tester.tap(find.byType(DropdownButton<String>).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.text('M').last);
      await tester.pumpAndSettle();

      // Open Quantity dropdown and select '2'
      await tester.tap(find.byType(DropdownButton<String>).at(2));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      // Tap Add to Cart and expect a SnackBar with chosen values
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.textContaining('Added 2 x'), findsOneWidget);
    });
  });
}
