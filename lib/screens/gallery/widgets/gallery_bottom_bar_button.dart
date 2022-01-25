import 'package:flutter/material.dart';
import 'package:scanner/screens/gallery/utils/gallery_tools.dart';


class GalleryBottomBar extends StatelessWidget {
  const GalleryBottomBar({
    Key? key,
    required this.e,
  }) : super(key: key);

  final GalleryImagesTools e;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 50,
        // width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                e.toolPrefixIcon,
                color: e.toolPrimaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(e.toolSynopsis)
            ],
          ),
        ),
      ),
    );
  }
}