import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/responsive_container.dart';
import '../../../shared/widgets/section_heading.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 900;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.midnightNavy,
        border: Border(
          top: BorderSide(color: AppColors.darkBorder, width: 1),
          bottom: BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 100.0 : 64.0,
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const SectionHeading(
              eyebrow: 'Core Capabilities',
              title: AppConstants.featuresHeading,
              subtitle:
                  'A thoughtfully curated synthesis of ancient astrological sciences and modern compatibility exploration.',
            ),
            SizedBox(height: isDesktop ? 64.0 : 48.0),

            // Feature 1: Vedic Kundali Matching (Editorial Split Layout)
            _buildVedicShowcase(context, isDesktop),

            SizedBox(height: isDesktop ? 48.0 : 32.0),

            // Feature 2 & 3 in complementary responsive grid
            isDesktop ? _buildDesktopGrid(context) : _buildMobileGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVedicShowcase(BuildContext context, bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 40 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.deepCosmicPurple.withValues(alpha: 0.8),
            AppColors.royalPlum.withValues(alpha: 0.3),
            AppColors.midnightNavy.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.antiqueGold.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              children: [
                Expanded(flex: 6, child: _buildVedicText(context)),
                const SizedBox(width: 48),
                Expanded(flex: 5, child: _buildVedicVisual()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVedicText(context),
                const SizedBox(height: 28),
                _buildVedicVisual(),
              ],
            ),
    );
  }

  Widget _buildVedicText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 14,
                color: AppColors.champagneGold,
              ),
              const SizedBox(width: 8),
              Text(
                'FOUNDATIONAL HERITAGE',
                style: AppTypography.eyebrow.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppConstants.feature1Title,
          style: AppTypography.sectionHeading(context).copyWith(
            fontSize: 28,
            color: AppColors.warmIvory,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          AppConstants.feature1Desc,
          style: AppTypography.bodyMedium.copyWith(
            fontSize: 15.5,
            height: 1.65,
            color: AppColors.softIvory,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildTag('Ashtakoota (8 Kootas)'),
            _buildTag('36 Guna Milap'),
            _buildTag('Nadi & Bhakoot Harmony'),
            _buildTag('Manglik & Dosha Insights'),
          ],
        ),
      ],
    );
  }

  Widget _buildVedicVisual() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.midnightNavy.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.antiqueGold.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildChartMetric('Varna', 'Spiritual Affinity')),
              Expanded(child: _buildChartMetric('Vashya', 'Mutual Dominance')),
              Expanded(child: _buildChartMetric('Tara', 'Destiny & Health')),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.antiqueGold.withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildChartMetric('Yoni', 'Biological Bond')),
              Expanded(child: _buildChartMetric('Maitri', 'Intellectual Rapport')),
              Expanded(child: _buildChartMetric('Nadi', 'Genetic Concord')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartMetric(String label, String detail) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.cardHeading.copyWith(
            fontSize: 16,
            color: AppColors.champagneGold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: AppTypography.bodySmall.copyWith(
            fontSize: 11,
            color: AppColors.mutedLavender,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.royalPlum.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.antiqueGold.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        text,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.champagneGold,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDesktopGrid(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildZodiacCard(context),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: _buildAstrologerFeatureCard(context),
        ),
      ],
    );
  }

  Widget _buildMobileGrid(BuildContext context) {
    return Column(
      children: [
        _buildZodiacCard(context),
        const SizedBox(height: 24),
        _buildAstrologerFeatureCard(context),
      ],
    );
  }

  Widget _buildZodiacCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.midnightNavySurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.antiqueGold.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.deepCosmicPurple,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.champagneGold.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.wb_sunny_outlined,
                    color: AppColors.champagneGold,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'WESTERN SYNERGY',
                  style: AppTypography.eyebrow.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppConstants.feature2Title,
            style: AppTypography.cardHeading.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 12),
          Text(
            AppConstants.feature2Desc,
            style: AppTypography.bodyMedium.copyWith(height: 1.6),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: [
              _buildElementBadge('Fire & Air', 'Inspiration & Spark'),
              _buildElementBadge('Earth & Water', 'Nurturance & Grounding'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAstrologerFeatureCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.midnightNavySurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.antiqueGold.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.deepCosmicPurple,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.champagneGold.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.psychology_outlined,
                    color: AppColors.champagneGold,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'HUMAN INTELLECT',
                  style: AppTypography.eyebrow.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppConstants.feature3Title,
            style: AppTypography.cardHeading.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 12),
          Text(
            AppConstants.feature3Desc,
            style: AppTypography.bodyMedium.copyWith(height: 1.6),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: [
              _buildElementBadge('Holistic Analysis', 'Beyond automated scores'),
              _buildElementBadge('Dignified Privacy', 'Respectful consultation'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildElementBadge(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.champagneGold,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.mutedLavender,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

