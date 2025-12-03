import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/about_print_shack.dart';
import 'package:flutter/foundation.dart';

Future<void> _drainAsyncExceptions(WidgetTester tester) async {
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

void main() {
  late FlutterExceptionHandler? _origOnError;

  setUpAll(() {
    _origOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      final msg = details.exceptionAsString();
      if (msg.contains('NetworkImageLoadException') ||
          msg.contains('HTTP request failed')) {
        // swallow expected network image failures in tests
        return;
      }
      _origOnError?.call(details);
    };
  });

  tearDownAll(() {
    FlutterError.onError = _origOnError;
  });

  group('About Print Shack page', () {
    testWidgets('renders title, images, sections and footer',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() async => await tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const MaterialApp(home: AboutPrintShack()));
      await tester.pumpAndSettle();
      await _drainAsyncExceptions(tester);

      // Title
      expect(find.text('The Union Print Shack'), findsOneWidget);

      // Images (we use asset images; expect one or more Image widgets)
      expect(find.byType(Image), findsWidgets);

      // Section headings
      expect(
          find.text('Make It Yours at The Union Print Shack'), findsOneWidget);
      expect(find.text('Uni Gear or Your Gear - We\'ll Personalise It'),
          findsOneWidget);
      expect(find.text('Simple Pricing, No Surprises'), findsOneWidget);

      // Footer presence
      expect(find.text('Opening hours'), findsWidgets);
    });
  });
}
