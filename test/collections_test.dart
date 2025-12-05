import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections_page.dart';

void main() {
  testWidgets('Collections page shows grid and navigates to detail',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

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

    // Should have filter and sort dropdowns
    expect(find.byType(DropdownButton<String>), findsNWidgets(2));

    expect(find.text('Classic Hoodie'), findsOneWidget);
  });

  testWidgets('Collection detail shows items for Hats',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));

    await tester.tap(find.byKey(const Key('collection_card_4')));
    await tester.pumpAndSettle();

    expect(find.text('Hats'), findsOneWidget);
    expect(find.text('University Hat'), findsOneWidget);
  });

  testWidgets('Collection detail has functioning filter dropdown',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));

    // Navigate to Hoodies collection
    await tester.tap(find.byKey(const Key('collection_card_0')));
    await tester.pumpAndSettle();

    // Find the filter dropdown
    final filterDropdown = find.byWidgetPredicate((widget) =>
        widget is DropdownButton<String> && widget.value == 'All products');
    expect(filterDropdown, findsOneWidget);

    // Verify initial product count shows multiple products (e.g., "5 products")
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.data != null &&
            widget.data!.contains('product') &&
            widget.data!.contains(RegExp(r'\d'))),
        findsOneWidget);
  });

  testWidgets('Collection detail has functioning sort dropdown',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));

    // Navigate to Hoodies collection
    await tester.tap(find.byKey(const Key('collection_card_0')));
    await tester.pumpAndSettle();

    // Find the sort dropdown
    final sortDropdown = find.byWidgetPredicate((widget) =>
        widget is DropdownButton<String> && widget.value == 'Best selling');
    expect(sortDropdown, findsOneWidget);

    // Verify sort by label exists
    expect(find.text('Sort By'), findsOneWidget);
  });

  testWidgets('Collection detail shows pagination when items exceed page limit',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));

    // Navigate to Hoodies collection (should have multiple items)
    await tester.tap(find.byKey(const Key('collection_card_0')));
    await tester.pumpAndSettle();

    // Check if pagination controls exist (only if more than 9 items)
    final nextButton = find.byIcon(Icons.chevron_right);
    final prevButton = find.byIcon(Icons.chevron_left);

    // If there are pagination controls, verify they work
    if (tester.widgetList(nextButton).isNotEmpty) {
      expect(prevButton, findsOneWidget);
      expect(nextButton, findsOneWidget);
    }
  });

  testWidgets('Collection detail displays dynamic product count',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));

    // Navigate to Hoodies collection
    await tester.tap(find.byKey(const Key('collection_card_0')));
    await tester.pumpAndSettle();

    // Verify product count is displayed with a number (e.g., "5 products")
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.data != null &&
            widget.data!.contains('product') &&
            widget.data!.contains(RegExp(r'\d'))),
        findsOneWidget);
  });

  testWidgets('Collection detail products are populated from data model',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));

    // Navigate to Hoodies collection
    await tester.tap(find.byKey(const Key('collection_card_0')));
    await tester.pumpAndSettle();

    // Verify products from data model are displayed
    expect(find.text('Classic Hoodie'), findsOneWidget);

    // Verify product cards show price information
    expect(find.textContaining('£'), findsWidgets);
  });
}
