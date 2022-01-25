import 'package:flutter/material.dart';

extension RxNavigation on BuildContext {
  //  ? to Navigate to a particular screen
  void navigateTo(Widget child) => Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => child,
      ));

  // ? Navigate back
  void navigateBack() => Navigator.pop(this);

  void replaceScreen({required Widget child}) => Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => child,
      ));
}
