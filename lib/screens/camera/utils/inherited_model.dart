import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraInheritedWidget extends InheritedWidget {
  const CameraInheritedWidget(
      {required this.controller, Key? key, required this.child})
      : super(key: key, child: child);

  
  // ignore: annotate_overrides
  final Widget child;
  final CameraController controller;

  static CameraInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CameraInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CameraInheritedWidget oldWidget) {
    return true;
  }
}