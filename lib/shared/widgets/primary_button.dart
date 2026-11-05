import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum ButtonVariant { primary, secondary, text }

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry padding;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.variant == ButtonVariant.primary;
    final isSecondary = widget.variant == ButtonVariant.secondary;

    // Glassmorphic styling for primary CTA
    final decoration = isPrimary
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [
                      const Color(0x4AE8C99D), // 29% champagne gold
                      const Color(0x28B77A45), // 16% antique gold
                    ]
                  : [
                      const Color(0x2EE8C99D), // 18% champagne gold
                      const Color(0x14B77A45), // 8% antique gold
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? AppColors.champagneGold.withValues(alpha: 0.8)
                  : AppColors.champagneGold.withValues(alpha: 0.4),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.champagneGold.withValues(
                  alpha: _isHovered ? 0.20 : 0.08,
                ),
                blurRadius: _isHovered ? 24 : 14,
                spreadRadius: _isHovered ? 1 : 0,
                offset: const Offset(0, 4),
              ),
              // Subtle inner glow simulation
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          )
        : BoxDecoration(
            color: isSecondary
                ? (_isHovered
                    ? AppColors.antiqueGold.withValues(alpha: 0.14)
                    : const Color(0x0AFFFFFF))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSecondary
                ? Border.all(
                    color: _isHovered
                        ? AppColors.champagneGold.withValues(alpha: 0.8)
                        : AppColors.antiqueGold.withValues(alpha: 0.45),
                    width: 1.0,
                  )
                : null,
          );

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      width: widget.width,
      padding: widget.padding,
      decoration: decoration,
      child: Center(
        child: widget.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.champagneGold),
                ),
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: 16,
                        color: AppColors.champagneGold,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: AppTypography.buttonText.copyWith(
                        color: _isHovered
                            ? AppColors.warmIvory
                            : (isPrimary ? AppColors.warmIvory : AppColors.champagneGold),
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );

    // Apply BackdropFilter blur for true glassmorphism
    final glassWidget = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: isPrimary
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: content,
            )
          : content,
    );

    return MouseRegion(
      cursor: widget.onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedScale(
          scale: _isPressed ? 0.98 : (_isHovered ? 1.01 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: glassWidget,
        ),
      ),
    );
  }
}
