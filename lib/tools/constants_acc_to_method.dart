import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Color getMethodsColor(String method) {
  Color color = Colors.black;

  switch (method) {
    case "Camera":
      color = Colors.purple;
      break;
    case "Gallery":
      color = Colors.redAccent;
      break;
  }

  return color;
}

IconData getMethodIcon(String method) {
  IconData icon = Iconsax.camera;

  switch (method) {
    case "Camera":
      icon = Iconsax.camera;
      break;
    case "Gallery":
      icon = Iconsax.gallery;
      break;
  }

  return icon;
}
