import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections_page.dart';

void main() {
  testWidgets('Collections page shows grid and navigates to detail',
      (WidgetTester tester) async {
    // ensure a wider surface so the header doesn't overflow in tests
    await tester.binding.setSurfaceSize(const Size(1024, 900));
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));

    // The page title 'Collections' is a Text with fontSize 28 in the body.
    final titleFinder = find.byWidgetPredicate((w) {
      return w is Text && w.data == 'Collections' && (w.style?.fontSize == 28);
    });
    expect(titleFinder, findsOneWidget);

    expect(find.byKey(const Key('collection_card_0')), findsOneWidget);
    expect(find.byKey(const Key('collection_card_5')), findsOneWidget);

    await tester.tap(find.byKey(const Key('collection_card_0')));
    await tester.pumpAndSettle();

    expect(find.text('Hoodies'), findsOneWidget);

    expect(find.byType(DropdownButton<String>), findsNWidgets(2));

    expect(find.text('Classic Hoodie'), findsOneWidget);
  });

  testWidgets('Collection detail shows items for Hats',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1024, 900));
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));

    await tester.tap(find.byKey(const Key('collection_card_4')));
    await tester.pumpAndSettle();

    expect(find.text('Hats'), findsOneWidget);
    expect(find.text('University Hat'), findsOneWidget);
  });
}
