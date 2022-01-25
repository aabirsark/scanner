import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/core/provider.gallery.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanner/screens/gallery/widgets/add_more.dart';
import 'package:scanner/screens/gallery/widgets/gallery_bottom_navbar.dart';
import 'package:scanner/screens/make_pdf/make_pdf.dart';
import 'package:scanner/tools/xfiles_to_paths.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<XFile> files = [];
  final PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    fetchImages();
    super.initState();
  }

  fetchImages() async {
    ImagePicker picker = ImagePicker();
    List<XFile>? temporaryFile = await picker.pickMultiImage();
    if (temporaryFile == null || temporaryFile.isEmpty) {
      context.navigateBack();
    } else {
      files.addAll(temporaryFile);
      context.read<CustomGalleryPageHandler>().setImages(files);

      setState(() {});
    }
  }

  addImages() async {
    ImagePicker picker = ImagePicker();
    List<XFile>? temporaryFile = await picker.pickMultiImage();
    if (temporaryFile == null || temporaryFile.isEmpty) {
    } else {
      files.addAll(temporaryFile);
      context.read<CustomGalleryPageHandler>().setImages(files);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              List<String> paths = await compute(
                  XFileToPathsConverter.xfilesToPath,
                  context.read<CustomGalleryPageHandler>().galleryImages);
              context.navigateTo(MakePDF(
                color: Colors.red,
                method: "Gallery",
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
      bottomNavigationBar: const GalleryBottomNavBar(),
      body: Center(
        child: files.isNotEmpty
            ? PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  context.read<CustomGalleryPageHandler>().setPageNo(value);
                },
                physics: const BouncingScrollPhysics(),
                itemCount: context
                        .watch<CustomGalleryPageHandler>()
                        .galleryImages
                        .length +
                    1,
                itemBuilder: (context, index) {
                  if (index ==
                      context
                          .watch<CustomGalleryPageHandler>()
                          .galleryImages
                          .length) {
                    return AddMoreGalleryWidget(
                      onTap: addImages,
                    );
                  }
                  var data = context
                      .watch<CustomGalleryPageHandler>()
                      .galleryImages
                      .elementAt(index);
                  return Image.file(File(data.path));
                },
              )
            : const Text("No Item selected at the very moment !"),
      ),
    );
  }
}
