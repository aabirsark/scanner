import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scanner/Widgets/dargline.dart';
import 'package:scanner/extensions/ext.details.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:scanner/models/files.dart';
import 'package:open_file/open_file.dart';
import 'package:scanner/Widgets/rename_bottom_sheet.dart';
import 'package:scanner/tools/create_pdf.dart';
import 'package:share/share.dart';

class CustomCardInfoBottomSheet extends StatelessWidget {
  const CustomCardInfoBottomSheet({Key? key, required this.file})
      : super(key: key);

  final CreatedFile file;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      width: double.infinity,
      padding: EdgeInsets.only(top: context.responsive(14)),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DragLine(),
          const SizedBox(
            height: 25,
          ),
          Text(
            file.title ?? "",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _actions
                .map((e) => _FunctionRow(
                      file: file,
                      element: e,
                    ))
                .toList(),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class _FunctionRow extends StatelessWidget {
  const _FunctionRow({
    Key? key,
    required this.file,
    required this.element,
  }) : super(key: key);

  final CreatedFile file;
  final _Actions element; // e => element

  onSave(String val) async {
    if (val != "") {
      final path = await getLocalPath();

      File newFile =
          File(file.paths!).renameSync("$path/${val.replaceAll(" ", "_")}.pdf");

      file
        ..paths = newFile.path
        ..title = val
        ..save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (element.actionSysnopsis) {
          case "Delete":
            File(file.paths!).deleteSync();
            file.delete();
            context.navigateBack();
            break;
          case "Open":
            OpenFile.open(file.paths);
            context.navigateBack();
            break;
          case "Share":
            Share.shareFiles([file.paths ?? ""]);
            context.navigateBack();
            break;
          case "Rename":
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) =>
                  CustomRenameBottomSheet(title: file.title!, onSave: onSave),
            );
            break;
          default:
        }
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: Center(
            child: Icon(
          element.actionIcon,
          color: element.actionColors,
        )),
      ),
    );
  }
}

class _Actions {
  final String actionSysnopsis;
  final IconData actionIcon;
  final Color actionColors;

  _Actions(
      {required this.actionSysnopsis,
      required this.actionColors,
      required this.actionIcon});
}

List<_Actions> _actions = [
  _Actions(
      actionSysnopsis: "Open",
      actionColors: Colors.green,
      actionIcon: CupertinoIcons.share),
  _Actions(
      actionSysnopsis: "Rename",
      actionColors: Colors.blue,
      actionIcon: Iconsax.edit),
  _Actions(
      actionSysnopsis: "Delete",
      actionColors: Colors.red,
      actionIcon: CupertinoIcons.delete),
  _Actions(
      actionSysnopsis: "Share",
      actionColors: Colors.pinkAccent,
      actionIcon: Iconsax.share),
];
