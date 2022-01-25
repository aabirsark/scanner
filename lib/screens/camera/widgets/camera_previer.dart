import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:scanner/core/provider.camera.dart';
import 'package:scanner/extensions/ext.navigate.dart';

class CameraPreviewImage extends StatelessWidget {
  const CameraPreviewImage({Key? key, this.file}) : super(key: key);

  final XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.navigateBack();
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
      ),
      body: Center(
        child: Column(
            // padding: const EdgeInsets.all(8.0),
            children: [
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 450,
                  // margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.file(File(file!.path))),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AgreeButton(
                        buttonColor: Colors.grey.shade400,
                        icon: Iconsax.repeat,
                        onTap: () {
                          context.navigateBack();
                        },
                      ),
                      AgreeButton(
                        buttonColor: Colors.green,
                        icon: Icons.done,
                        onTap: () {
                          context
                              .read<CustomCameraPageHandler>()
                              .addData(file!);
                          context.navigateBack();
                        },
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}

class AgreeButton extends StatelessWidget {
  const AgreeButton(
      {Key? key,
      required this.buttonColor,
      required this.icon,
      required this.onTap})
      : super(key: key);

  final Color buttonColor;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: buttonColor,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
