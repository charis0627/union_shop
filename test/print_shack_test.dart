import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/print_shack_page.dart';

void main() {
  Widget createTestWidget() {
    return const MaterialApp(home: PrintShackPage());
  }

  group('Print Shack Page', () {
    testWidgets('renders title, preview and form', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Personalisation'), findsOneWidget);
      expect(find.text('£3.00'), findsOneWidget);
      expect(find.text('Tax included.'), findsOneWidget);
      expect(find.text('ADD TO CART'), findsOneWidget);
    });

    testWidgets('per-line dropdown shows second line when selected',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initially only line 1 field is present
      expect(find.text('Personalisation Line 1:'), findsOneWidget);
      expect(find.text('Personalisation Line 2:'), findsNothing);

      // Open per-line dropdown and select 'Two Lines of Text'
      await tester.tap(find.byType(DropdownButton<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Two Lines of Text').last);
      await tester.pumpAndSettle();

      expect(find.text('Personalisation Line 2:'), findsOneWidget);
    });

    testWidgets('entering text and tapping add to cart shows snackbar',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter valid text
      await tester.enterText(find.byType(TextFormField).first, 'Alice');
      await tester.pumpAndSettle();

      // Tap Add to Cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.textContaining('Added'), findsOneWidget);
    });

    testWidgets('thumbnails are tappable', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // There should be multiple thumbnail images (ListView)
      final thumbnails = find.byType(GestureDetector);
      expect(thumbnails, findsWidgets);

      // Tap the second thumbnail (if present)
      if (tester.widgetList(thumbnails).length > 1) {
        await tester.tap(thumbnails.at(1));
        await tester.pumpAndSettle();
      }

      // Tapping shouldn't throw and page remains
      expect(find.text('Personalisation'), findsOneWidget);
    });
  });
}
