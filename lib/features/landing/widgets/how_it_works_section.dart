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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Widget _buildStackedSteps(BuildContext context) {
    return Column(
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(32),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: AppTypography.cardHeading.copyWith(
                fontSize: 20,
                color: AppColors.warmIvory,
              ),
            ),
            const SizedBox(height: 12),
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

