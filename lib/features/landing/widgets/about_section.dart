import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/responsive_container.dart';
import '../../../shared/widgets/section_heading.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.midnightNavy,
      ),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 104.0 : 68.0,
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const SectionHeading(
              eyebrow: 'About Astromett',
              title: AppConstants.aboutHeading,
              subtitle: AppConstants.aboutDescription,
            ),
            SizedBox(height: isDesktop ? 64.0 : 48.0),
            isDesktop
                ? _buildDesktopEditorial(context)
                : _buildMobileEditorial(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopEditorial(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildEditorialColumn(
            icon: Icons.temple_hindu_outlined,
            title: 'Ancient Wisdom, Modern Intent',
            content:
                'Traditional matchmaking often relied on broad strokes. Astromett refines this heritage through granular Vedic Kundali analysis, respecting the subtleties of planetary doshas, gunas, and natural affinities.',
          ),
        ),
        const SizedBox(width: 32),
        Container(
          width: 1,
          height: 180,
          color: AppColors.antiqueGold.withValues(alpha: 0.2),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: _buildEditorialColumn(
            icon: Icons.all_inclusive,
            title: 'Dual-Astrology Synergy',
            content:
                'We harmonize Eastern Vedic chart alignments with Western psychological zodiac archetypes. This blended perspective offers a richer, multidimensional lens into temperament, communication styles, and emotional resilience.',
          ),
        ),
        const SizedBox(width: 32),
        Container(
          width: 1,
          height: 180,
          color: AppColors.antiqueGold.withValues(alpha: 0.2),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: _buildEditorialColumn(
            icon: Icons.favorite_border,
            title: 'Purpose-Driven Relationships',
            content:
                'Astromett is created strictly for those seeking genuine life partnership and marriage. By filtering for shared values and cosmic resonance from the start, we eliminate the superficiality of modern swipe culture.',
          ),
        ),
      ],
    );
  }

  Widget _buildMobileEditorial(BuildContext context) {
    return Column(
      children: [
        _buildEditorialColumn(
          icon: Icons.temple_hindu_outlined,
          title: 'Ancient Wisdom, Modern Intent',
          content:
              'Traditional matchmaking often relied on broad strokes. Astromett refines this heritage through granular Vedic Kundali analysis, respecting the subtleties of planetary doshas, gunas, and natural affinities.',
        ),
        const SizedBox(height: 36),
        Divider(color: AppColors.antiqueGold.withValues(alpha: 0.2)),
        const SizedBox(height: 36),
        _buildEditorialColumn(
          icon: Icons.all_inclusive,
          title: 'Dual-Astrology Synergy',
          content:
              'We harmonize Eastern Vedic chart alignments with Western psychological zodiac archetypes. This blended perspective offers a richer, multidimensional lens into temperament, communication styles, and emotional resilience.',
        ),
        const SizedBox(height: 36),
        Divider(color: AppColors.antiqueGold.withValues(alpha: 0.2)),
        const SizedBox(height: 36),
        _buildEditorialColumn(
          icon: Icons.favorite_border,
          title: 'Purpose-Driven Relationships',
          content:
              'Astromett is created strictly for those seeking genuine life partnership and marriage. By filtering for shared values and cosmic resonance from the start, we eliminate the superficiality of modern swipe culture.',
        ),
      ],
    );
  }

  Widget _buildEditorialColumn({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.deepCosmicPurple.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.antiqueGold.withValues(alpha: 0.35),
            ),
          ),
          child: Icon(
            icon,
            color: AppColors.champagneGold,
            size: 24,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: AppTypography.cardHeading.copyWith(
            fontSize: 20,
            color: AppColors.warmIvory,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: AppTypography.bodyMedium.copyWith(
            height: 1.65,
            color: AppColors.mutedLavender,
          ),
        ),
      ],
    );
  }
}

