import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:scanner/screens/camera/utils/inherited_model.dart';
import 'package:scanner/screens/camera/widgets/camera_previer.dart';

class CameraShutter extends StatelessWidget {
  const CameraShutter({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap ??
            () async {
              XFile? file = await CameraInheritedWidget.of(context)
                  ?.controller
                  .takePicture();
              context.navigateTo(CameraPreviewImage(
                file: file,
              ));
            },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 65,
          width: 65,
          child: const Center(
            child: Icon(
              Iconsax.camera,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
