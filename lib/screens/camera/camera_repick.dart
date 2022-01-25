import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/constants.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:scanner/screens/camera/utils/inherited_model.dart';
import 'package:scanner/screens/camera/widgets/custom_camera_preview.dart';
import 'package:scanner/screens/camera/widgets/shutter.dart';

class CameraRepickPage extends StatefulWidget {
  const CameraRepickPage({Key? key}) : super(key: key);

  @override
  State<CameraRepickPage> createState() => _CameraRepickPageState();
}

class _CameraRepickPageState extends State<CameraRepickPage> {
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
              // context.read<CustomCameraPageHandler>().removeAllData();
            },
            icon: const Icon(CupertinoIcons.multiply)),
        title: const Text(
          "Camera",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: CameraInheritedWidget(
        controller: cameraController,
        child: Center(
          child: Column(
            children: [
              const CustomCameraPreview(),
              Expanded(
                  child: Center(
                      child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CameraShutter(
                  onTap: () async {
                    XFile file = await cameraController.takePicture();
                    Navigator.pop(context , file);
                  },
                ),
              )))
            ],
          ),
        ),
      ),
    );
  }
}
