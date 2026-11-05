import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:astromett/app.dart';

void main() {
  testWidgets('Astromett early access landing smoke test', (WidgetTester tester) async {
    // Set a desktop surface size for the test
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const AstromettApp());
    await tester.pumpAndSettle();

    // Verify brand title is displayed
    expect(find.text('ASTROMETT'), findsWidgets);

    // Verify tagline
    expect(
      find.text('Some Connections Are Written in the Stars.'),
      findsWidgets,
    );

    // Verify early access CTAs
    expect(find.text('Join Early Access'), findsWidgets);
    expect(find.text('Discover How It Works'), findsWidgets);
  });
}
