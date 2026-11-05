import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/primary_button.dart';

class AstromettMobileDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onHowItWorksTap;
  final VoidCallback onApproachTap;
  final VoidCallback onJoinTap;

  const AstromettMobileDrawer({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onHowItWorksTap,
    required this.onApproachTap,
    required this.onJoinTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.midnightNavy,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: AppColors.antiqueGold.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            gradient: const LinearGradient(
              colors: [AppColors.midnightNavy, AppColors.deepCosmicPurple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: AppColors.champagneGold,
                        size: 19,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppConstants.appName,
                        style: AppTypography.brandLogo.copyWith(
                          fontSize: 22,
                          height: 1.0,
                          letterSpacing: 3.5,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.champagneGold,
                      size: 24,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(
                color: AppColors.antiqueGold.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 24),

              // Navigation Links
              _MobileNavItem(
                icon: Icons.home_outlined,
                title: 'Home',
                onTap: () {
                  Navigator.of(context).pop();
                  onHomeTap();
                },
              ),
              _MobileNavItem(
                icon: Icons.auto_stories_outlined,
                title: 'About',
                onTap: () {
                  Navigator.of(context).pop();
                  onAboutTap();
                },
              ),
              _MobileNavItem(
                icon: Icons.timeline_outlined,
                title: 'How It Works',
                onTap: () {
                  Navigator.of(context).pop();
                  onHowItWorksTap();
                },
              ),
              _MobileNavItem(
                icon: Icons.flare_outlined,
                title: 'Our Approach',
                onTap: () {
                  Navigator.of(context).pop();
                  onApproachTap();
                },
              ),

              const Spacer(),

              // CTA Button
              PrimaryButton(
                text: 'Join Early Access',
                width: double.infinity,
                onPressed: () {
                  Navigator.of(context).pop();
                  onJoinTap();
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Some Connections Are Written in the Stars.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.champagneGold.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: AppColors.midnightNavySurface.withValues(alpha: 0.5),
        leading: Icon(icon, color: AppColors.champagneGold, size: 20),
        title: Text(
          title,
          style: AppTypography.navLink.copyWith(fontSize: 16),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.antiqueGold,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}

