import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/responsive_container.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onHowItWorksTap;
  final VoidCallback onApproachTap;
  final VoidCallback onJoinTap;

  const FooterSection({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onHowItWorksTap,
    required this.onApproachTap,
    required this.onJoinTap,
  });

  void _showPolicyDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.midnightNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.antiqueGold, width: 1),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTypography.cardHeading.copyWith(
                          color: AppColors.champagneGold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.warmIvory),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: AppColors.antiqueGold.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    body,
                    style: AppTypography.bodyMedium.copyWith(
                      height: 1.6,
                      color: AppColors.softIvory,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Close',
                        style: AppTypography.buttonSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF060917), // Deepest celestial midnight
        border: Border(
          top: BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
      padding: EdgeInsets.only(
        top: isDesktop ? 72 : 48,
        bottom: 36,
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            isDesktop ? _buildDesktopLayout(context) : _buildMobileLayout(context),
            const SizedBox(height: 48),
            Divider(color: AppColors.antiqueGold.withValues(alpha: 0.15)),
            const SizedBox(height: 28),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand Column
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.champagneGold,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppConstants.appName,
                    style: AppTypography.brandLogo,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: Text(
                  'Astromett unites timeless Vedic wisdom and Western astrological compatibility to help intentional individuals discover meaningful life connections.',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.mutedLavender,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Navigation Links
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EXPLORE',
                style: AppTypography.eyebrow.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 16),
              _FooterLink(text: 'Home', onTap: onHomeTap),
              const SizedBox(height: 10),
              _FooterLink(text: 'About Astromett', onTap: onAboutTap),
              const SizedBox(height: 10),
              _FooterLink(text: 'How It Works', onTap: onHowItWorksTap),
              const SizedBox(height: 10),
              _FooterLink(text: 'Our Approach', onTap: onApproachTap),
            ],
          ),
        ),

        // Legal & Early Access
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMMITMENT & PRIVACY',
                style: AppTypography.eyebrow.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 16),
              _FooterLink(
                text: 'Privacy Policy',
                onTap: () => _showPolicyDialog(
                  context,
                  'Privacy Policy',
                  'At Astromett, we take your privacy with the utmost seriousness. Your astrological birth details and personal profile parameters are never sold, rented, or distributed to third parties. We strictly utilize encrypted protocols and adhere to global data protection standards.',
                ),
              ),
              const SizedBox(height: 10),
              _FooterLink(
                text: 'Terms & Conditions',
                onTap: () => _showPolicyDialog(
                  context,
                  'Terms & Conditions',
                  'Astromett provides astrological compatibility insights and relationship exploration as a tool for personal reflection and intentional matchmaking. Astrological consultations are non-deterministic and intended to enrich personal judgment and mutual understanding.',
                ),
              ),
              const SizedBox(height: 10),
              _FooterLink(
                text: 'Join Early Access Cohort',
                onTap: onJoinTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.auto_awesome,
              color: AppColors.champagneGold,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              AppConstants.appName,
              style: AppTypography.brandLogo,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Astromett unites timeless Vedic wisdom and Western astrological compatibility to help intentional individuals discover meaningful life connections.',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.mutedLavender,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'EXPLORE',
          style: AppTypography.eyebrow.copyWith(fontSize: 11),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            _FooterLink(text: 'Home', onTap: onHomeTap),
            _FooterLink(text: 'About', onTap: onAboutTap),
            _FooterLink(text: 'How It Works', onTap: onHowItWorksTap),
            _FooterLink(text: 'Our Approach', onTap: onApproachTap),
            _FooterLink(text: 'Join Early Access', onTap: onJoinTap),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'LEGAL',
          style: AppTypography.eyebrow.copyWith(fontSize: 11),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            _FooterLink(
              text: 'Privacy Policy',
              onTap: () => _showPolicyDialog(
                context,
                'Privacy Policy',
                'At Astromett, we take your privacy with the utmost seriousness. Your astrological birth details and personal profile parameters are never sold, rented, or distributed to third parties. We strictly utilize encrypted protocols and adhere to global data protection standards.',
              ),
            ),
            _FooterLink(
              text: 'Terms & Conditions',
              onTap: () => _showPolicyDialog(
                context,
                'Terms & Conditions',
                'Astromett provides astrological compatibility insights and relationship exploration as a tool for personal reflection and intentional matchmaking. Astrological consultations are non-deterministic and intended to enrich personal judgment and mutual understanding.',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        runSpacing: 10,
        children: [
          Text(
            '© 2026 Astromett. All rights reserved.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.mutedLavender.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
          Text(
            'Some Connections Are Written in the Stars.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.champagneGold.withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({required this.text, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: AppTypography.bodyMedium.copyWith(
            color: _isHovered ? AppColors.champagneGold : AppColors.softIvory,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

