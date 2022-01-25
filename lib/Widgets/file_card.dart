import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanner/models/files.dart';
import 'package:scanner/tools/constants_acc_to_method.dart';
import 'package:scanner/tools/date_formate.dart';
import 'package:scanner/tools/file_size.dart';

class FilesCard extends StatelessWidget {
  const FilesCard({Key? key, required this.cardInfo}) : super(key: key);

  final CreatedFile cardInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      // margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.redAccent),
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Align(
            child: Icon(
              getMethodIcon(cardInfo.method ?? "Camera"),
              color: Colors.grey.shade100,
              size: 70,
            ),
          ),
          FilesCardLayer(
            cardInfo: cardInfo,
          )
        ],
      ),
    );
  }
}

class FilesCardLayer extends StatelessWidget {
  const FilesCardLayer({
    Key? key,
    required this.cardInfo,
  }) : super(key: key);

  final CreatedFile cardInfo;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // verticalDirection: VerticalDirection.up,
          children: [
            Text(
              cardInfo.title ?? "",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade900),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 3,
                  backgroundColor: getMethodsColor(cardInfo.method ?? "Camera"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(cardInfo.method ?? "")
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formDateFromDateTime(time: cardInfo.time ?? DateTime.now()),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  getFileSize(cardInfo.paths!, 1),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
