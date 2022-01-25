import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:scanner/core/provider.camera.dart';
import 'package:scanner/core/provider.gallery.dart';
import 'package:scanner/screens/camera/camera.dart';
import 'package:scanner/screens/gallery/gallery.dart';
import 'package:scanner/extensions/ext.navigate.dart';

class Tools extends StatelessWidget {
  const Tools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      width: double.maxFinite,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            child: const Text(
              "Tools",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: data
                .map((data) => ToolsChip(
                      chipData: data,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class ToolsChip extends StatelessWidget {
  const ToolsChip({Key? key, required this.chipData}) : super(key: key);

  final ToolsChipData chipData;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      // duration: longAnimationTime,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          context.read<CustomCameraPageHandler>().emptyAllImages();
          context.read<CustomGalleryPageHandler>().emptyAllImages();

          context.navigateTo(chipData.toolScreen);
        },
        child: Container(
          height: 50,
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                chipData.toolPrefixIcon,
                color: chipData.toolPrimaryColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(chipData.toolName)
            ],
          ),
        ),
      ),
    );
  }
}

class ToolsChipData {
  final String toolName;
  final Color toolPrimaryColor;
  final IconData toolPrefixIcon;
  final Widget toolScreen;

  ToolsChipData(
      {required this.toolName,
      required this.toolScreen,
      required this.toolPrimaryColor,
      required this.toolPrefixIcon});
}

List<ToolsChipData> data = [
  ToolsChipData(
      toolName: "Camera",
      toolScreen: const CameraPage(),
      toolPrimaryColor: Colors.purple,
      toolPrefixIcon: Iconsax.camera),
  ToolsChipData(
      toolName: "Gallery",
      toolScreen: const Gallery(),
      toolPrimaryColor: Colors.redAccent,
      toolPrefixIcon: Iconsax.gallery),
  // ToolsChipData(
  //     toolName: "Merge PDFs",
  //     toolScreen: const MergePdf(),
  //     toolPrimaryColor: Colors.orange,
  //     toolPrefixIcon: Iconsax.add),
  // ToolsChipData(
  //     toolName: "PDF to Image",
  //     toolScreen: const PdfToImage(),
  //     toolPrimaryColor: Colors.green,
  //     toolPrefixIcon: Iconsax.activity),
];
