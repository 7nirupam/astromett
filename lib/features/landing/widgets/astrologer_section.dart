import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/responsive_container.dart';
import '../../../shared/widgets/section_heading.dart';

class AstrologerSection extends StatelessWidget {
  const AstrologerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.deepCosmicPurple,
        gradient: LinearGradient(
          colors: [
            AppColors.midnightNavy,
            AppColors.deepCosmicPurple,
            AppColors.midnightNavy,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 100.0 : 64.0,
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const SectionHeading(
              eyebrow: 'Experienced Counsel',
              title: AppConstants.astrologerHeading,
              subtitle: AppConstants.astrologerDesc,
            ),
            SizedBox(height: isDesktop ? 64.0 : 48.0),
            Container(
              padding: EdgeInsets.all(isDesktop ? 48 : 24),
              decoration: BoxDecoration(
                color: AppColors.midnightNavy.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.antiqueGold.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: isDesktop
                  ? _buildDesktopEditorial(context)
                  : _buildMobileEditorial(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopEditorial(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Human Wisdom Behind Algorithmic Precision',
                style: AppTypography.cardHeading.copyWith(
                  fontSize: 26,
                  color: AppColors.champagneGold,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'While automated calculations map planetary positions accurately, relationship dynamics are nuanced and deeply personal. Astromett bridges mathematical birth-chart calculations with the discerning eye of seasoned astrology practitioners.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.softIvory,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Our forthcoming platform allows you to request personalized synthesis sessions, clarifying complex placements such as Sade Sati, Manglik considerations, and Dasha transitions with sensitivity and maturity.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.mutedLavender,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 4,
          child: _buildEditorialPillars(),
        ),
      ],
    );
  }

  Widget _buildMobileEditorial(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Human Wisdom Behind Algorithmic Precision',
          style: AppTypography.cardHeading.copyWith(
            fontSize: 22,
            color: AppColors.champagneGold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'While automated calculations map planetary positions accurately, relationship dynamics are nuanced and deeply personal. Astromett bridges mathematical birth-chart calculations with the discerning eye of seasoned astrology practitioners.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.softIvory,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 28),
        _buildEditorialPillars(),
      ],
    );
  }

  Widget _buildEditorialPillars() {
    return Column(
      children: [
        _buildPillarItem(
          icon: Icons.verified_user_outlined,
          title: 'Ethical & Dignified Approach',
          desc:
              'No superstition or fear-based predictions. Only constructive, growth-oriented counsel.',
        ),
        const SizedBox(height: 18),
        _buildPillarItem(
          icon: Icons.menu_book_outlined,
          title: 'Classical Lineage',
          desc:
              'Rooted in Brihat Parashara Hora Shastra, Jaimini principles, and Western psychological archetypes.',
        ),
        const SizedBox(height: 18),
        _buildPillarItem(
          icon: Icons.lock_outline,
          title: 'Uncompromised Confidentiality',
          desc:
              'Your birth specifics and personal consultations are kept strictly private and secure.',
        ),
      ],
    );
  }

  Widget _buildPillarItem({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.deepCosmicPurple,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.antiqueGold.withValues(alpha: 0.3),
            ),
          ),
          child: Icon(icon, size: 18, color: AppColors.champagneGold),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.warmIvory,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.mutedLavender,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

