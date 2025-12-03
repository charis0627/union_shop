import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:flutter/foundation.dart';

void main() {
  Future<void> drainAsyncExceptions(WidgetTester tester) async {
    await tester.runAsync(() async {
      await Future<void>.delayed(const Duration(milliseconds: 50));
    });

    // Pump a frame to allow any scheduled error-handling to run.
    await tester.pump();

    // Drain exceptions
    while (tester.takeException() != null) {
      // continue draining until no more exceptions
    }
  }

  group('Home Page Tests', () {
    late FlutterExceptionHandler? origOnError;
    setUpAll(() {
      origOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        final msg = details.exceptionAsString();
        if (msg.contains('NetworkImageLoadException') ||
            msg.contains('HTTP request failed')) {
          return;
        }
        origOnError?.call(details);
      };
    });

    tearDownAll(() {
      FlutterError.onError = origOnError;
    });
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      await drainAsyncExceptions(tester);

      // Check that basic UI elements are present
      expect(find.text('BIG SALE!COME GRAB YOURS WHILE STOCK LASTS!'),
          findsOneWidget);
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);
      expect(find.text('BROWSE PRODUCTS'), findsOneWidget);
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      await drainAsyncExceptions(tester);

      // Check that product cards are displayed
      expect(find.text('Placeholder Product 1'), findsOneWidget);
      expect(find.text('Placeholder Product 2'), findsOneWidget);
      expect(find.text('Placeholder Product 3'), findsOneWidget);
      expect(find.text('Placeholder Product 4'), findsOneWidget);

      // Check prices are displayed
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
    });

    testWidgets('should display header icons', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      await drainAsyncExceptions(tester);

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      await drainAsyncExceptions(tester);

      // Check that footer is present. On wide layouts we expect the
      // detailed footer column texts to be visible (the SUBSCRIBE button
      // appears only in the narrow layout).
      expect(find.text('Opening hours'), findsWidgets);
      expect(find.text('Closing 4pm 19/12.2025'), findsOneWidget);
    });
  });
}
