import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/responsive_container.dart';

class AstromettNavigationBar extends StatelessWidget {
  static const double navHeight = 76.0;

  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onHowItWorksTap;
  final VoidCallback onApproachTap;
  final VoidCallback? onJoinTap;
  final VoidCallback onMenuOpen;

  const AstromettNavigationBar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onHowItWorksTap,
    required this.onApproachTap,
    this.onJoinTap,
    required this.onMenuOpen,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktopNav = width >= 900;
    final isSmallMobile = width < 360;
    final isMobile = width < 600;

    final double brandFontSize = isSmallMobile ? 18.5 : (isMobile ? 20.5 : 22.0);
    final double brandLetterSpacing = isSmallMobile ? 2.2 : (isMobile ? 2.8 : 3.5);
    final double brandIconSize = isSmallMobile ? 16.5 : 19.0;
    final double brandGap = isSmallMobile ? 8.0 : 10.0;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: navHeight,
          decoration: BoxDecoration(
            color: AppColors.midnightNavy.withValues(alpha: 0.82),
            border: Border(
              bottom: BorderSide(
                color: AppColors.antiqueGold.withValues(alpha: 0.18),
                width: 1,
              ),
            ),
          ),
          child: ResponsiveContainer(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveContainer.horizontalPadding(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Brand Logo & Wordmark (Fully visible, responsive scaling, never overlaps hamburger)
                Flexible(
                  child: InkWell(
                    onTap: onHomeTap,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: AppColors.champagneGold,
                              size: brandIconSize,
                            ),
                            SizedBox(width: brandGap),
                            Text(
                              AppConstants.appName,
                              style: AppTypography.brandLogo.copyWith(
                                fontSize: brandFontSize,
                                height: 1.0,
                                letterSpacing: brandLetterSpacing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Desktop Navigation Links (No redundant Early Access CTA)
                if (isDesktopNav) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _NavLink(title: 'Home', onTap: onHomeTap),
                      const SizedBox(width: 32),
                      _NavLink(title: 'About', onTap: onAboutTap),
                      const SizedBox(width: 32),
                      _NavLink(title: 'How It Works', onTap: onHowItWorksTap),
                      const SizedBox(width: 32),
                      _NavLink(title: 'Our Approach', onTap: onApproachTap),
                    ],
                  ),
                ] else ...[
                  // Mobile / Tablet Hamburger Menu Button
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: AppColors.champagneGold,
                        size: 26,
                      ),
                      onPressed: onMenuOpen,
                      tooltip: 'Open Navigation Menu',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavLink({required this.title, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: AppTypography.navLink.copyWith(
                  color: _isHovered
                      ? AppColors.champagneGold
                      : AppColors.warmIvory.withValues(alpha: 0.9),
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14.5,
                  letterSpacing: 0.6,
                ),
                child: Text(widget.title),
              ),
              const SizedBox(height: 4),
              // Subtle animated underline indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isHovered ? 20 : 0,
                height: 1.5,
                decoration: BoxDecoration(
                  color: AppColors.champagneGold,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
