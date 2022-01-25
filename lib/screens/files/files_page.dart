import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scanner/Widgets/card_bottom_sheet.dart';
import 'package:scanner/Widgets/file_card.dart';
import 'package:scanner/db/db.operation.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:scanner/models/files.dart';
import 'package:scanner/screens/files/widgets/search_delegete.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<CreatedFile> data;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Files"),
        leading: IconButton(
            onPressed: () {
              context.navigateBack();
            },
            icon: FadeInLeft(child: const Icon(CupertinoIcons.left_chevron))),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: CustomSearchDelegate(data));
              },
              icon: FadeInRight(child: const Icon(Iconsax.search_normal)))
        ],
      ),
      body: ValueListenableBuilder<Box<CreatedFile>>(
        valueListenable: Boxes.createFileBox.listenable(),
        builder: (context, value, child) {
          data = value.values.cast<CreatedFile>().toList().reversed.toList();
          return data.isNotEmpty
              ? FadeInUpBig(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.7),
                      itemBuilder: (context, index) => Center(
                          child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      CustomCardInfoBottomSheet(
                                        file: data.elementAt(index),
                                      ),
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true);
                            },
                            child: FilesCard(cardInfo: data[index])),
                      )),
                    ),
                  ),
                )
              : const Center(
                  child: Text("No File yet made"),
                );
        },
      ),
    );
  }
}
