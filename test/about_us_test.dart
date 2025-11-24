import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/about_us_page.dart';

void main() {
  group('About Us Page Test', () {
    Widget createTestWidget() {
      return const MaterialApp(home: AboutUsPage());
    }

    testWidgets('About Us Page shows title and content', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // AppBar title should be present
      expect(find.widgetWithText(AppBar, 'About Us'), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('Tapping About Us button navigates to AboutUsPage', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/about': (c) => const AboutUsPage(),
        },
        home: Builder(builder: (context) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                child: const Text('About Us'),
              ),
            ),
          );
        }),
      ));

      // Find the header About button by its TextButton text
      final aboutButton = find.widgetWithText(TextButton, 'About Us');
      expect(aboutButton, findsOneWidget);
      await tester.tap(aboutButton);
      await tester.pumpAndSettle();

      expect(find.byType(AboutUsPage), findsOneWidget);
    });

    testWidgets('Back button returns to previous screen', (tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {'/about': (c) => const AboutUsPage()},
        home: Builder(builder: (context) {
          return Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                child: const Text('About Us'),
              ),
            ),
          );
        }),
      ));

      await tester.tap(find.text('About Us'));
      await tester.pumpAndSettle();
      expect(find.byType(AboutUsPage), findsOneWidget);

      // simulate back
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(AboutUsPage), findsNothing);
    });
  });
}
