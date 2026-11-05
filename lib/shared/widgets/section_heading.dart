import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class SectionHeading extends StatelessWidget {
  final String? eyebrow;
  final String title;
  final String? subtitle;
  final bool centered;
  final double maxWidth;

  const SectionHeading({
    super.key,
    this.eyebrow,
    required this.title,
    this.subtitle,
    this.centered = true,
    this.maxWidth = 720.0,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (eyebrow != null) ...[
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (centered) ...[
                    Container(
                      width: 24,
                      height: 1,
                      color: AppColors.antiqueGold.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 10),
                  ],
                  const Icon(
                    Icons.auto_awesome,
                    size: 13,
                    color: AppColors.champagneGold,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    eyebrow!.toUpperCase(),
                    style: AppTypography.eyebrow,
                  ),
                  if (centered) ...[
                    const SizedBox(width: 10),
                    Container(
                      width: 24,
                      height: 1,
                      color: AppColors.antiqueGold.withValues(alpha: 0.6),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            title,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: AppTypography.sectionHeading(context),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 16),
            Text(
              subtitle!,
              textAlign: centered ? TextAlign.center : TextAlign.start,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.mutedLavender,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

