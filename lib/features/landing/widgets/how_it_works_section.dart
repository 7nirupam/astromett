import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/responsive_container.dart';
import '../../../shared/widgets/section_heading.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveContainer.isMobile(context);
    final isTablet = ResponsiveContainer.isTablet(context);

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
        vertical: isMobile ? 64.0 : 100.0,
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const SectionHeading(
              eyebrow: 'The Astromett Journey',
              title: AppConstants.howItWorksHeading,
              subtitle:
                  'Three guided steps uniting celestial charting with intentional relationship discovery.',
            ),
            SizedBox(height: isMobile ? 48.0 : 64.0),
            if (isMobile || isTablet)
              _buildStackedSteps(context)
            else
              _buildDesktopSteps(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopSteps(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _StepCard(
              stepNumber: '01',
              icon: Icons.edit_calendar_outlined,
              title: AppConstants.step1Title,
              description: AppConstants.step1Desc,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _StepCard(
              stepNumber: '02',
              icon: Icons.hub_outlined,
              title: AppConstants.step2Title,
              description: AppConstants.step2Desc,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _StepCard(
              stepNumber: '03',
              icon: Icons.favorite_outline_rounded,
              title: AppConstants.step3Title,
              description: AppConstants.step3Desc,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedSteps(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepCard(
          stepNumber: '01',
          icon: Icons.edit_calendar_outlined,
          title: AppConstants.step1Title,
          description: AppConstants.step1Desc,
        ),
        const SizedBox(height: 20),
        _StepCard(
          stepNumber: '02',
          icon: Icons.hub_outlined,
          title: AppConstants.step2Title,
          description: AppConstants.step2Desc,
        ),
        const SizedBox(height: 20),
        _StepCard(
          stepNumber: '03',
          icon: Icons.favorite_outline_rounded,
          title: AppConstants.step3Title,
          description: AppConstants.step3Desc,
        ),
      ],
    );
  }
}

class _StepCard extends StatefulWidget {
  final String stepNumber;
  final IconData icon;
  final String title;
  final String description;

  const _StepCard({
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveContainer.isMobile(context);
    final isTablet = ResponsiveContainer.isTablet(context);

    // Consistent internal padding
    final cardPadding = EdgeInsets.all(isMobile ? 24.0 : 32.0);

    // Consistent target height for stacked viewports so all 3 cards share identical dimensions
    final double? targetStackedHeight = isMobile ? 320.0 : (isTablet ? 275.0 : null);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: double.infinity,
        constraints: targetStackedHeight != null
            ? BoxConstraints(minHeight: targetStackedHeight)
            : const BoxConstraints(minHeight: 270.0),
        padding: cardPadding,
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.royalPlum.withValues(alpha: 0.35)
              : AppColors.midnightNavy.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppColors.champagneGold.withValues(alpha: 0.7)
                : AppColors.antiqueGold.withValues(alpha: 0.25),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.antiqueGold.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Step Number and Icon row with consistent cross-axis centering
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.stepNumber,
                  style: AppTypography.brandLogo.copyWith(
                    fontSize: 28,
                    color: _isHovered
                        ? AppColors.champagneGold
                        : AppColors.antiqueGold.withValues(alpha: 0.7),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.deepCosmicPurple,
                    border: Border.all(
                      color: AppColors.antiqueGold.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 20,
                    color: AppColors.champagneGold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 20.0 : 24.0),

            // Heading with consistent height slot so subsequent descriptions align across cards
            SizedBox(
              height: isMobile ? 52.0 : 56.0,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.title,
                  style: AppTypography.cardHeading.copyWith(
                    fontSize: 20,
                    color: AppColors.warmIvory,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Description with natural line height and consistent alignment
            Text(
              widget.description,
              style: AppTypography.bodyMedium.copyWith(
                height: 1.6,
                color: AppColors.mutedLavender,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
