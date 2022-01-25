import 'package:flutter/material.dart';

extension ScreenDetails on BuildContext {
  /// returns screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// returns screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// returns screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  double responsive(double size, {Axis axis = Axis.vertical}) {
    final currentSize =
        axis == Axis.horizontal ? screenSize.width : screenSize.height;
    final designSize = axis == Axis.horizontal
        ? AppConstants.designScreenSize.width
        : AppConstants.designScreenSize.height;

    return size * currentSize / designSize;
  }
}

class AppConstants {
  static const Size designScreenSize = Size(375, 754);
}
