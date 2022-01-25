import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scanner/screens/camera/utils/inherited_model.dart';
import 'package:scanner/extensions/ext.details.dart';

class CustomCameraPreview extends StatelessWidget {
  const CustomCameraPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: context.screenHeight * 0.7,
        child: CameraInheritedWidget.of(context)!.controller.value.isInitialized
            ? CameraPreview(CameraInheritedWidget.of(context)!.controller)
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}