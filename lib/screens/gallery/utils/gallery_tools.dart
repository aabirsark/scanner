import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GalleryImagesTools {
  String toolSynopsis;
  IconData toolPrefixIcon;
  Color toolPrimaryColor;
  VoidCallback callback;

  GalleryImagesTools(
      {required this.toolSynopsis,
      required this.toolPrefixIcon,
      required this.callback,
      required this.toolPrimaryColor});
}

List<GalleryImagesTools> tools = [
  GalleryImagesTools(
      toolSynopsis: "Re-pick",
      toolPrefixIcon: Iconsax.repeat,
      callback: () {},
      toolPrimaryColor: Colors.green),
  GalleryImagesTools(
      toolSynopsis: "Remove",
      toolPrefixIcon: Iconsax.gallery_remove,
      callback: () {},
      toolPrimaryColor: Colors.red),
];
