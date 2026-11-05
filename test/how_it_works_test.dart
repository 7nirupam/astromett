import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:astromett/app.dart';
import 'package:astromett/features/landing/widgets/how_it_works_section.dart';

void main() {
  group('How It Works Section Card Dimension Tests', () {
    testWidgets('Desktop: All three step cards have exactly identical widths and heights',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1366, 768);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const AstromettApp());
      await tester.pumpAndSettle();

      // Find the three step numbers '01', '02', '03'
      final step1Finder = find.text('01');
      final step2Finder = find.text('02');
      final step3Finder = find.text('03');

      expect(step1Finder, findsOneWidget);
      expect(step2Finder, findsOneWidget);
      expect(step3Finder, findsOneWidget);

      // Find the AnimatedContainers representing each card
      final cardFinders = find.descendant(
        of: find.byType(HowItWorksSection),
        matching: find.byType(AnimatedContainer),
      );

      expect(cardFinders, findsNWidgets(3));

      final size0 = tester.getSize(cardFinders.at(0));
      final size1 = tester.getSize(cardFinders.at(1));
      final size2 = tester.getSize(cardFinders.at(2));

      // 1. Identical Widths on Desktop
      expect(size0.width, equals(size1.width),
          reason: 'Card 0 and Card 1 width must be identical');
      expect(size1.width, equals(size2.width),
          reason: 'Card 1 and Card 2 width must be identical');

      // 2. Identical Heights on Desktop
      expect(size0.height, equals(size1.height),
          reason: 'Card 0 and Card 1 height must be identical');
      expect(size1.height, equals(size2.height),
          reason: 'Card 1 and Card 2 height must be identical');
    });

    testWidgets('Large Desktop (1920x1080): All three step cards have identical dimensions',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const AstromettApp());
      await tester.pumpAndSettle();

      final cardFinders = find.descendant(
        of: find.byType(HowItWorksSection),
        matching: find.byType(AnimatedContainer),
      );

      expect(cardFinders, findsNWidgets(3));

      final size0 = tester.getSize(cardFinders.at(0));
      final size1 = tester.getSize(cardFinders.at(1));
      final size2 = tester.getSize(cardFinders.at(2));

      expect(size0.width, equals(size1.width));
      expect(size1.width, equals(size2.width));

      expect(size0.height, equals(size1.height));
      expect(size1.height, equals(size2.height));
    });

    testWidgets('Tablet (768x1024): All three step cards have identical widths and heights',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const AstromettApp());
      await tester.pumpAndSettle();

      final cardFinders = find.descendant(
        of: find.byType(HowItWorksSection),
        matching: find.byType(AnimatedContainer),
      );

      expect(cardFinders, findsNWidgets(3));

      final size0 = tester.getSize(cardFinders.at(0));
      final size1 = tester.getSize(cardFinders.at(1));
      final size2 = tester.getSize(cardFinders.at(2));

      expect(size0.width, equals(size1.width));
      expect(size1.width, equals(size2.width));

      expect(size0.height, equals(size1.height));
      expect(size1.height, equals(size2.height));
    });

    testWidgets('Small Mobile (360x800): All three step cards have identical widths and heights',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const AstromettApp());
      await tester.pumpAndSettle();

      final cardFinders = find.descendant(
        of: find.byType(HowItWorksSection),
        matching: find.byType(AnimatedContainer),
      );

      expect(cardFinders, findsNWidgets(3));

      final size0 = tester.getSize(cardFinders.at(0));
      final size1 = tester.getSize(cardFinders.at(1));
      final size2 = tester.getSize(cardFinders.at(2));

      expect(size0.width, equals(size1.width));
      expect(size1.width, equals(size2.width));

      expect(size0.height, equals(size1.height));
      expect(size1.height, equals(size2.height));
    });

    testWidgets('Mobile (390x844): All three step cards have identical widths and heights',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const AstromettApp());
      await tester.pumpAndSettle();

      final cardFinders = find.descendant(
        of: find.byType(HowItWorksSection),
        matching: find.byType(AnimatedContainer),
      );

      expect(cardFinders, findsNWidgets(3));

      final size0 = tester.getSize(cardFinders.at(0));
      final size1 = tester.getSize(cardFinders.at(1));
      final size2 = tester.getSize(cardFinders.at(2));

      expect(size0.width, equals(size1.width));
      expect(size1.width, equals(size2.width));

      expect(size0.height, equals(size1.height));
      expect(size1.height, equals(size2.height));
    });
  });
}

