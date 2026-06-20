import 'package:flutter/material.dart';

extension ResponsiveSize on BuildContext {
  /// Total width of the screen.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Total height of the screen.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Returns a width proportionate to the standard base width (e.g. 390.0 for iPhone 12/13/14).
  /// Use this for horizontal padding, width, etc.
  double w(double pixels) {
    return (pixels / 390.0) * screenWidth;
  }

  /// Returns a height proportionate to the standard base height (e.g. 844.0 for iPhone 12/13/14).
  /// Use this for vertical padding, height, sized boxes, font sizes, etc.
  double h(double pixels) {
    return (pixels / 844.0) * screenHeight;
  }
}
