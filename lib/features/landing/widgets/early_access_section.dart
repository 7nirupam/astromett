import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/responsive_container.dart';
import '../../../shared/widgets/section_heading.dart';
import 'registration_form.dart';

class EarlyAccessSection extends StatelessWidget {
  const EarlyAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveContainer.isMobile(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.midnightNavy,
        border: Border(
          top: BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 64.0 : 100.0,
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const SectionHeading(
              eyebrow: 'Exclusive Early Access',
              title: AppConstants.earlyAccessHeading,
              subtitle: AppConstants.earlyAccessSub,
            ),
            SizedBox(height: isMobile ? 40.0 : 56.0),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Container(
                  padding: EdgeInsets.all(isMobile ? 24 : 40),
                  decoration: BoxDecoration(
                    color: AppColors.deepCosmicPurple.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.antiqueGold.withValues(alpha: 0.4),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 32,
                        spreadRadius: 2,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.lock_clock_outlined,
                              size: 16,
                              color: AppColors.champagneGold,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'LIMITED COHORT INVITATION',
                              style: AppTypography.eyebrow.copyWith(
                                fontSize: 11,
                                color: AppColors.champagneGold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      const RegistrationForm(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

