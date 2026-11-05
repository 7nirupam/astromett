import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/landing/screens/landing_screen.dart';

class AstromettApp extends StatelessWidget {
  const AstromettApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astromett — Some Connections Are Written in the Stars',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      home: const LandingScreen(),
    );
  }
}

