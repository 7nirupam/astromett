import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:astromett/app.dart';
import 'package:astromett/core/constants/app_constants.dart';
import 'package:astromett/features/landing/widgets/navigation_bar.dart';

void main() {
  const viewports = [
    Size(320, 568),   // Smallest mobile (iPhone SE 1st gen)
    Size(360, 800),   // Small / Standard mobile
    Size(375, 667),   // Standard mobile (iPhone SE 2nd gen)
    Size(390, 844),   // Standard modern mobile (iPhone 12/13/14)
    Size(414, 896),   // Large mobile (iPhone 11/XR/Plus)
    Size(430, 932),   // Max mobile (iPhone Pro Max)
    Size(768, 1024),  // Tablet portrait (iPad)
    Size(820, 1180),  // iPad Air
    Size(1024, 768),  // Small desktop / Tablet landscape
    Size(1280, 600),  // Crucial short laptop
    Size(1366, 768),  // Standard laptop
    Size(1440, 900),  // Desktop standard
    Size(1920, 1080), // Large desktop Full HD
  ];

  for (final size in viewports) {
    testWidgets(
      'Renders cleanly without overflow and clears navbar on ${size.width.toInt()}x${size.height.toInt()}',
      (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(const AstromettApp());
        await tester.pumpAndSettle();

        // 1. Complete Hero Eyebrow Tagline must be rendered in full (no truncation)
        final eyebrowFinder = find.text(AppConstants.heroEyebrow);
        expect(
          eyebrowFinder,
          findsOneWidget,
          reason: 'The complete tagline pill text "${AppConstants.heroEyebrow}" must be fully rendered without ellipsis on ${size.width}x${size.height}',
        );

        // 2. Brand title should always be present
        expect(find.text('ASTROMETT'), findsWidgets);

        // 3. Header non-overlap check on mobile
        if (size.width < 900) {
          final menuFinder = find.byIcon(Icons.menu);
          expect(menuFinder, findsOneWidget);

          final logoFinder = find.descendant(
            of: find.byType(AstromettNavigationBar),
            matching: find.text('ASTROMETT'),
          );
          final logoRect = tester.getRect(logoFinder);
          final menuRect = tester.getRect(menuFinder);

          // Verify brand logo right edge does NOT exceed hamburger menu left edge
          expect(
            logoRect.right,
            lessThan(menuRect.left),
            reason: 'ASTROMETT logo (right: ${logoRect.right}) must not overlap hamburger menu (left: ${menuRect.left}) on ${size.width}x${size.height}',
          );
        }

        // 4. Headline verification & Navbar clearance verification
        final headlineFinder = find.text('Some Connections Are Written in the Stars.').first;
        expect(headlineFinder, findsOneWidget);

        final headlineTopY = tester.getTopLeft(headlineFinder).dy;
        // Verify that headline is strictly below the navigation bar
        expect(
          headlineTopY,
          greaterThan(AstromettNavigationBar.navHeight),
          reason: 'Headline top ($headlineTopY) must be strictly below navbar (${AstromettNavigationBar.navHeight}) on ${size.width}x${size.height}',
        );

        // 5. Verify key sections are present
        expect(find.text('Beyond Ordinary Connections.'), findsOneWidget);
        expect(find.text('Your Journey, Written in the Stars.'), findsOneWidget);
        expect(find.text('Where Astrology Meets Connection.'), findsOneWidget);
        expect(find.text('Guidance Beyond the Stars.'), findsOneWidget);
        expect(find.text('Your Journey Begins Here.'), findsOneWidget);

        // 6. Verify both CTA buttons exist
        expect(find.text('Join Early Access'), findsWidgets);
        expect(find.text('Discover How It Works'), findsWidgets);

        // 7. Verify navigation visibility by breakpoint
        if (size.width < 900) {
          expect(find.byIcon(Icons.menu), findsOneWidget);
        } else {
          expect(find.text('Home'), findsWidgets);
          expect(find.text('About'), findsWidgets);
          expect(find.text('How It Works'), findsWidgets);
          expect(find.text('Our Approach'), findsWidgets);
        }
      },
    );
  }
}
