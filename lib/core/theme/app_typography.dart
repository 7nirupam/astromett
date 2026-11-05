import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Astromett Typography Hierarchy
///
/// Headings: Cormorant Garamond (Editorial, Classic, Celestial)
/// Body & UI: DM Sans (Clean, Modern, Highly Legible)
class AppTypography {
  AppTypography._();

  // Headings (Cormorant Garamond)
  static TextStyle heroHeading(BuildContext context, {double? fontSizeOverride}) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;

    double defaultSize;
    if (width < 600) {
      defaultSize = 34.0;
    } else if (width < 900) {
      defaultSize = 44.0;
    } else if (height < 720) {
      // Shorter desktop / laptop viewports (e.g. 1280x600, 1366x768)
      defaultSize = 42.0;
    } else if (height < 850) {
      defaultSize = 50.0;
    } else {
      defaultSize = 58.0;
    }

    final fontSize = fontSizeOverride ?? defaultSize;
    final lineHeight = width < 600 ? 1.18 : 1.12;

    return GoogleFonts.cormorantGaramond(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.warmIvory,
      height: lineHeight,
      letterSpacing: -0.5,
    );
  }

  static TextStyle sectionHeading(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final fontSize = width < 600
        ? 28.0
        : width < 900
            ? 36.0
            : 44.0;

    return GoogleFonts.cormorantGaramond(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.warmIvory,
      height: 1.2,
      letterSpacing: -0.3,
    );
  }

  static TextStyle subHeading(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final fontSize = width < 600 ? 20.0 : 24.0;

    return GoogleFonts.cormorantGaramond(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: AppColors.champagneGold,
      height: 1.3,
    );
  }

  static TextStyle cardHeading = GoogleFonts.cormorantGaramond(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: AppColors.warmIvory,
    height: 1.3,
  );

  // Subtitle / Label
  static TextStyle eyebrow = GoogleFonts.dmSans(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors.champagneGold,
    letterSpacing: 2.5,
  );

  // Body text (DM Sans)
  static TextStyle bodyLarge = GoogleFonts.dmSans(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors.softIvory,
    height: 1.6,
  );

  static TextStyle bodyMedium = GoogleFonts.dmSans(
    fontSize: 14.5,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedLavender,
    height: 1.6,
  );

  static TextStyle bodySmall = GoogleFonts.dmSans(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedLavender,
    height: 1.5,
  );

  // Navigation & Buttons
  static TextStyle navLink = GoogleFonts.dmSans(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.warmIvory,
    letterSpacing: 0.5,
  );

  static TextStyle buttonText = GoogleFonts.dmSans(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    color: AppColors.warmIvory,
    letterSpacing: 1.0,
  );

  static TextStyle buttonSecondary = GoogleFonts.dmSans(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    color: AppColors.champagneGold,
    letterSpacing: 0.8,
  );

  static TextStyle brandLogo = GoogleFonts.cormorantGaramond(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: AppColors.champagneGold,
    letterSpacing: 4.0,
  );
}
