import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/responsive_container.dart';
import 'navigation_bar.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onJoinEarlyAccess;
  final VoidCallback onDiscoverHowItWorks;

  const HeroSection({
    super.key,
    required this.onJoinEarlyAccess,
    required this.onDiscoverHowItWorks,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;

    final isMobile = width < 768;
    final isTablet = width >= 768 && width < 1100;
    final isShortDesktop = !isMobile && !isTablet && height < 720;
    final isMidDesktop = !isMobile && !isTablet && height >= 720 && height < 850;

    // Guaranteed top clearance so content never renders underneath the sticky navbar
    final double navHeight = AstromettNavigationBar.navHeight;
    final double topSpacing = isMobile
        ? 20.0
        : (isTablet
            ? 24.0
            : (isShortDesktop
                ? 16.0
                : (isMidDesktop ? 28.0 : 44.0)));

    final double topPadding = navHeight + topSpacing;
    final double bottomPadding = isMobile
        ? 48.0
        : (isShortDesktop ? 28.0 : 48.0);

    return Stack(
      children: [
        // 1. Cinematic Background Image
        Positioned.fill(
          child: Image.asset(
            AppConstants.cosmicBackground,
            fit: BoxFit.cover,
            alignment: isMobile
                ? const Alignment(0.20, -0.3)
                : const Alignment(0.38, 0.0),
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.cosmicGradient,
                ),
              );
            },
          ),
        ),

        // 2. Vertical Ambient Gradient (Smooth transition into midnight navy)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isMobile
                    ? [
                        AppColors.midnightNavy.withValues(alpha: 0.90),
                        AppColors.midnightNavy.withValues(alpha: 0.75),
                        AppColors.midnightNavy.withValues(alpha: 0.98),
                      ]
                    : [
                        AppColors.midnightNavy.withValues(alpha: 0.84),
                        AppColors.midnightNavy.withValues(alpha: 0.50),
                        AppColors.midnightNavy,
                      ],
                stops: const [0.0, 0.60, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // 3. Horizontal Atmospheric Gradient on Desktop (Guarantees left-side text legibility while revealing celestial sky on right)
        if (!isMobile && !isTablet)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.midnightNavy.withValues(alpha: 0.94),
                    AppColors.midnightNavy.withValues(alpha: 0.72),
                    AppColors.midnightNavy.withValues(alpha: 0.20),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 0.72, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),

        // 4. Hero Content with predictable top clearance
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: ResponsiveContainer.horizontalPadding(context),
            right: ResponsiveContainer.horizontalPadding(context),
            top: topPadding,
            bottom: bottomPadding,
          ),
          child: ResponsiveContainer(
            padding: EdgeInsets.zero,
            child: isMobile || isTablet
                ? _buildStackedHero(context, isMobile: isMobile)
                : _buildDesktopHero(
                    context,
                    isShort: isShortDesktop,
                    isMid: isMidDesktop,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHero(
    BuildContext context, {
    required bool isShort,
    required bool isMid,
  }) {
    final double gapEyebrow = isShort ? 12.0 : (isMid ? 16.0 : 20.0);
    final double gapHeadline = isShort ? 12.0 : (isMid ? 16.0 : 20.0);
    final double gapPara = isShort ? 20.0 : (isMid ? 26.0 : 32.0);
    final double gapCTA = isShort ? 22.0 : (isMid ? 28.0 : 36.0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column (56% proportion): Editorial Content Group
        Expanded(
          flex: 56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEyebrowBadge(),
              SizedBox(height: gapEyebrow),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Text(
                  AppConstants.tagline,
                  style: AppTypography.heroHeading(context),
                ),
              ),
              SizedBox(height: gapHeadline),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Text(
                  AppConstants.subTagline,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.softIvory.withValues(alpha: 0.92),
                    fontSize: isShort ? 15.5 : (isMid ? 16.5 : 17.5),
                    height: isShort ? 1.5 : 1.65,
                  ),
                ),
              ),
              SizedBox(height: gapPara),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  PrimaryButton(
                    text: 'Join Early Access',
                    onPressed: onJoinEarlyAccess,
                    icon: Icons.auto_awesome,
                    padding: EdgeInsets.symmetric(
                      horizontal: isShort ? 24 : 28,
                      vertical: isShort ? 13 : 16,
                    ),
                  ),
                  PrimaryButton(
                    text: 'Discover How It Works',
                    variant: ButtonVariant.secondary,
                    onPressed: onDiscoverHowItWorks,
                    icon: Icons.arrow_downward,
                    padding: EdgeInsets.symmetric(
                      horizontal: isShort ? 24 : 28,
                      vertical: isShort ? 13 : 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: gapCTA),
              _buildFeaturePills(isCompact: isShort),
            ],
          ),
        ),

        const SizedBox(width: 48),

        // Right Column (44% proportion): Negative Space & Translucent Celestial Accent
        Expanded(
          flex: 44,
          child: Align(
            alignment: Alignment.centerRight,
            child: _buildCelestialAccent(context, isCompact: isShort),
          ),
        ),
      ],
    );
  }

  Widget _buildStackedHero(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildEyebrowBadge(),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? 380 : 580),
          child: Text(
            AppConstants.tagline,
            textAlign: TextAlign.center,
            style: AppTypography.heroHeading(context),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            AppConstants.subTagline,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.softIvory.withValues(alpha: 0.9),
              fontSize: isMobile ? 15.0 : 16.5,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            PrimaryButton(
              text: 'Join Early Access',
              onPressed: onJoinEarlyAccess,
              icon: Icons.auto_awesome,
              width: isMobile ? double.infinity : null,
            ),
            PrimaryButton(
              text: 'Discover How It Works',
              variant: ButtonVariant.secondary,
              onPressed: onDiscoverHowItWorks,
              icon: Icons.arrow_downward,
              width: isMobile ? double.infinity : null,
            ),
          ],
        ),
        const SizedBox(height: 32),
        _buildFeaturePills(isCompact: true),
        const SizedBox(height: 36),
        // Position celestial card naturally in stacked flow on tablet & mobile
        _buildCelestialAccent(context, isCompact: true),
      ],
    );
  }

  Widget _buildEyebrowBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6.5),
      decoration: BoxDecoration(
        color: AppColors.deepCosmicPurple.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.antiqueGold.withValues(alpha: 0.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.antiqueGold.withValues(alpha: 0.08),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.auto_awesome,
            size: 13,
            color: AppColors.champagneGold,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              AppConstants.heroEyebrow,
              style: AppTypography.eyebrow.copyWith(
                fontSize: 10.5,
                letterSpacing: 2.0,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePills({bool isCompact = false}) {
    final items = [
      'Vedic Kundali Matching',
      'Western Zodiac Insights',
      'Astrologer Guidance',
    ];

    return Wrap(
      spacing: isCompact ? 12 : 18,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: items.map((item) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.stars_rounded,
                size: 13,
                color: AppColors.champagneGold,
              ),
              const SizedBox(width: 6),
              Text(
                item,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.champagneGold.withValues(alpha: 0.95),
                  fontWeight: FontWeight.w500,
                  fontSize: isCompact ? 12.0 : 13.0,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCelestialAccent(BuildContext context, {bool isCompact = false}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isCompact ? 340 : 370),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: EdgeInsets.all(isCompact ? 20 : 26),
            decoration: BoxDecoration(
              color: AppColors.deepCosmicPurple.withValues(alpha: 0.30),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.champagneGold.withValues(alpha: 0.28),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 28,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.champagneGold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'CELESTIAL HARMONY',
                      style: AppTypography.eyebrow.copyWith(
                        fontSize: 10.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isCompact ? 10 : 14),
                Text(
                  'Two Charts, One Alignment',
                  style: AppTypography.cardHeading.copyWith(
                    fontSize: isCompact ? 18 : 20,
                    color: AppColors.warmIvory,
                  ),
                ),
                SizedBox(height: isCompact ? 6 : 8),
                Text(
                  'Synthesizing 8 Kootas & 36 Gunas with planetary harmonies to uncover profound connection.',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.softIvory.withValues(alpha: 0.88),
                    fontSize: isCompact ? 12.0 : 13.0,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
