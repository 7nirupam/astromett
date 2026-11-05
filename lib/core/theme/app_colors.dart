import 'package:flutter/material.dart';

/// Astromett Brand Color Palette
///
/// Refined, cinematic palette combining deep celestial tones with warm antique gold.
class AppColors {
  AppColors._();

  // Primary Celestial Palette
  static const Color midnightNavy = Color(0xFF090D20);
  static const Color deepCosmicPurple = Color(0xFF17152D);
  static const Color royalPlum = Color(0xFF352044);
  static const Color midnightNavySurface = Color(0xFF0D122B);
  static const Color cosmicCardBg = Color(0x9917152D);

  // Gold Accents
  static const Color antiqueGold = Color(0xFFB77A45);
  static const Color champagneGold = Color(0xFFE8C99D);
  static const Color brightGold = Color(0xFFD4AF37);
  static const Color mutedGold = Color(0x66B77A45);

  // Typography & Neutrals
  static const Color warmIvory = Color(0xFFF3E8D7);
  static const Color softIvory = Color(0xFFDDD2C1);
  static const Color mutedLavender = Color(0xFFA09CBD);
  static const Color darkBorder = Color(0x33B77A45);
  static const Color goldGlow = Color(0x26E8C99D);

  // Feedback & States
  static const Color success = Color(0xFF5CA377);
  static const Color error = Color(0xFFE06C75);
  static const Color inputBg = Color(0x6610142D);
  static const Color inputBorder = Color(0x44B77A45);
  static const Color inputFocusBorder = Color(0xFFE8C99D);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [antiqueGold, champagneGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cosmicGradient = LinearGradient(
    colors: [midnightNavy, deepCosmicPurple, royalPlum],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xCC17152D), Color(0xCC090D20)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldBorderGradient = LinearGradient(
    colors: [Color(0x99E8C99D), Color(0x22B77A45), Color(0x66E8C99D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroOverlayGradient = LinearGradient(
    colors: [
      Color(0xE6090D20), // 90% opacity
      Color(0x99090D20), // 60% opacity
      Color(0xF0090D20), // 94% opacity
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

