import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:scanner/core/provider.camera.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:scanner/screens/camera/camera_repick.dart';
import 'package:scanner/screens/make_pdf/make_pdf.dart';

class CameraPreviewImages extends StatefulWidget {
  const CameraPreviewImages({Key? key}) : super(key: key);

  @override
  State<CameraPreviewImages> createState() => _CameraPreviewImagesState();
}

class _CameraPreviewImagesState extends State<CameraPreviewImages> {
  onTap(CameraImagesTools e) async {
    if (e.toolSynopsis == "Remove") {
      context
          .read<CustomCameraPageHandler>()
          .removeDataAt(context.read<CustomCameraPageHandler>().pageCount);
    } else if (e.toolSynopsis == "Re-pick") {
      XFile? file = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CameraRepickPage(),
          ));
      if (file != null) {
        context.read<CustomCameraPageHandler>().exchangeCurrentPage(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("can't pop");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.navigateBack();
              },
              icon: const Icon(CupertinoIcons.left_chevron)),
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () async {
                List<String> paths = await compute(xfilesToPath,
                    context.read<CustomCameraPageHandler>().cameraImages);
                context.navigateTo(MakePDF(
                  color: Colors.purple,
                  method: "Camera",
                  paths: paths,
                ));
              },
              child: SizedBox(
                width: 120,
                // color: Colors.black,
                child: Center(
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade200,
                    ),
                    child: const Center(
                        child: Text(
                      "Make PDF",
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          // color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tools
                .map((e) => InkWell(
                      onTap: () {
                        onTap(e);
                      },
                      child: CameraBottomBar(
                        e: e,
                      ),
                    ))
                .toList(),
          ),
        ),
        body: PageView.builder(
          onPageChanged: (value) {
            context.read<CustomCameraPageHandler>().changePageCount(value);
          },
          physics: const BouncingScrollPhysics(),
          itemCount:
              context.watch<CustomCameraPageHandler>().cameraImages.length,
          itemBuilder: (context, index) {
            var data =
                context.watch<CustomCameraPageHandler>().cameraImages[index];
            return Image.file(File(data.path));
          },
        ),
      ),
    );
  }
}

class CameraBottomBar extends StatelessWidget {
  const CameraBottomBar({
    Key? key,
    required this.e,
  }) : super(key: key);

  final CameraImagesTools e;

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

class CameraImagesTools {
  String toolSynopsis;
  IconData toolPrefixIcon;
  Color toolPrimaryColor;
  VoidCallback callback;

  CameraImagesTools(
      {required this.toolSynopsis,
      required this.toolPrefixIcon,
      required this.callback,
      required this.toolPrimaryColor});
}

List<CameraImagesTools> tools = [
  CameraImagesTools(
      toolSynopsis: "Re-pick",
      toolPrefixIcon: Iconsax.repeat,
      callback: () {},
      toolPrimaryColor: Colors.green),
  CameraImagesTools(
      toolSynopsis: "Remove",
      toolPrefixIcon: Iconsax.gallery_remove,
      callback: () {},
      toolPrimaryColor: Colors.red),
];

List<String> xfilesToPath(List<XFile> files) {
  List<String> paths = [];
  for (var item in files) {
    paths.add(item.path);
  }

  return paths;
}
