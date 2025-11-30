import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/authentication_page.dart';

void main() {
  testWidgets('AuthenticationPage shows expected widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AuthenticationPage()));
    await tester.pumpAndSettle();

    expect(find.text('The UNION'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.byKey(const Key('auth_email')), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Sign in with shop'),
        findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Continue'), findsOneWidget);

    // Enter sample email and verify it appears in the widget tree
    await tester.enterText(
        find.byKey(const Key('auth_email')), 'test@example.com');
    await tester.pump();
    expect(find.text('test@example.com'), findsOneWidget);
  });

  testWidgets('Create an account button is present',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AuthenticationPage()));
    await tester.pumpAndSettle();

    expect(find.text('Create an account'), findsOneWidget);
  });
}
