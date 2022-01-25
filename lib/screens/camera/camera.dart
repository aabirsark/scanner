import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner/constants.dart';
import 'package:scanner/core/provider.camera.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:scanner/screens/camera/camera_preview.dart';
import 'package:scanner/screens/camera/utils/inherited_model.dart';
import 'package:scanner/screens/camera/widgets/custom_camera_preview.dart';
import 'package:scanner/screens/camera/widgets/shutter.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.navigateBack();
              context.read<CustomCameraPageHandler>().removeAllData();
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
        title: const Text(
          "Camera",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          context.watch<CustomCameraPageHandler>().cameraImages.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    context.replaceScreen(child: const CameraPreviewImages());
                  },
                  icon: const Icon(Icons.done))
              : const SizedBox()
        ],
      ),
      body: CameraInheritedWidget(
        controller: cameraController,
        child: Center(
          child: Column(
            children: const [
              CustomCameraPreview(),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: CameraShutterRow(),
              )))
            ],
          ),
        ),
      ),
    );
  }
}

class CameraShutterRow extends StatelessWidget {
  const CameraShutterRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          width: 45,
        ),
        const CameraShutter(),
        context.watch<CustomCameraPageHandler>().cameraImages.isNotEmpty
            ? InkWell(
                onTap: () {
                  context.navigateTo(const CameraPreviewImages());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                      image: DecorationImage(
                          image: FileImage(File(context
                              .watch<CustomCameraPageHandler>()
                              .cameraImages[context
                                      .watch<CustomCameraPageHandler>()
                                      .cameraImages
                                      .length -
                                  1]
                              .path)),
                          fit: BoxFit.cover)),
                ),
              )
            : const SizedBox(
                width: 45,
              )
      ],
    );
  }
}
