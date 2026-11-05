import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:astromett/app.dart';
import 'package:astromett/features/landing/widgets/navigation_bar.dart';

void main() {
  const viewports = [
    Size(360, 800),   // Small mobile
    Size(375, 667),   // iPhone-sized mobile
    Size(390, 844),   // Standard mobile
    Size(430, 932),   // Large mobile
    Size(768, 1024),  // Tablet portrait
    Size(820, 1180),  // iPad Air
    Size(1024, 768),  // Tablet landscape
    Size(1280, 600),  // Crucial short desktop / laptop
    Size(1366, 768),  // Crucial standard laptop
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

        // 1. Brand title should always be present
        expect(find.text('ASTROMETT'), findsWidgets);

        // 2. Headline verification & Navbar clearance verification
        final headlineFinder = find.text('Some Connections Are Written in the Stars.').first;
        expect(headlineFinder, findsOneWidget);

        final headlineTopY = tester.getTopLeft(headlineFinder).dy;
        // Verify that headline is strictly below the navigation bar
        expect(
          headlineTopY,
          greaterThan(AstromettNavigationBar.navHeight),
          reason: 'Headline top ($headlineTopY) must be strictly below navbar (${AstromettNavigationBar.navHeight}) on ${size.width}x${size.height}',
        );

        // 3. Verify key sections are present
        expect(find.text('Beyond Ordinary Connections.'), findsOneWidget);
        expect(find.text('Your Journey, Written in the Stars.'), findsOneWidget);
        expect(find.text('Where Astrology Meets Connection.'), findsOneWidget);
        expect(find.text('Guidance Beyond the Stars.'), findsOneWidget);
        expect(find.text('Your Journey Begins Here.'), findsOneWidget);

        // 4. Verify both CTA buttons exist
        expect(find.text('Join Early Access'), findsWidgets);
        expect(find.text('Discover How It Works'), findsWidgets);

        // 5. Verify navigation visibility by breakpoint
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
