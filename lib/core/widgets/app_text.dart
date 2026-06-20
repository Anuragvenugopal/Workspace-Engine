import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

/// A common text widget used throughout the app.
/// Merges [TextStyle] defaults with explicit overrides, all backed by [AppColors].
class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;
  final bool softWrap;

  const AppText(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.decoration,
    this.maxLines,
    this.overflow,
    this.style,
    this.softWrap = true,
  });

  // ─── Convenience constructors ───────────────────────────────────────────

  /// Large heading, e.g. screen titles
  const AppText.heading(
    this.text, {
    super.key,
    this.color = AppColors.black87,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  })  : fontSize = 22,
        fontWeight = FontWeight.bold,
        decoration = null,
        style = null;

  /// Sub-heading, e.g. section labels
  const AppText.subheading(
    this.text, {
    super.key,
    this.color = AppColors.black87,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  })  : fontSize = 16,
        fontWeight = FontWeight.w600,
        decoration = null,
        style = null;

  /// Standard body text
  const AppText.body(
    this.text, {
    super.key,
    this.color = AppColors.black54,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  })  : fontSize = 14,
        fontWeight = FontWeight.normal,
        decoration = null,
        style = null;

  /// Small caption / helper text
  const AppText.caption(
    this.text, {
    super.key,
    this.color = AppColors.secondaryText,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  })  : fontSize = 12,
        fontWeight = FontWeight.w400,
        decoration = null,
        style = null;

  /// Label text, e.g. button labels, tags
  const AppText.label(
    this.text, {
    super.key,
    this.color = AppColors.primaryText,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap = true,
  })  : fontSize = 13,
        fontWeight = FontWeight.w500,
        decoration = null,
        style = null;

  @override
  Widget build(BuildContext context) {
    final resolved = (style ?? const TextStyle()).copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
    );

    return Text(
      text,
      style: resolved,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
