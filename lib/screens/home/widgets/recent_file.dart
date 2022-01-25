import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scanner/Widgets/card_bottom_sheet.dart';
import 'package:scanner/Widgets/file_card.dart';
import 'package:scanner/db/db.operation.dart';
import 'package:scanner/models/files.dart';
import 'package:scanner/screens/files/files_page.dart';
import 'package:scanner/extensions/ext.navigate.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      // color: Colors.black,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeIn(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recents",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    context.navigateTo(const FilesPage());
                  },
                  child: const Text(
                    "Watch all ",
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ValueListenableBuilder<Box<CreatedFile>>(
            valueListenable: Boxes.createFileBox.listenable(),
            builder: (context, value, child) {
              var data =
                  value.values.cast<CreatedFile>().toList().reversed.toList();
              return SizedBox(
                height: 250,
                child: data.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length <= 5 ? data.length : 5,
                        itemBuilder: (context, index) => FadeInUp(
                            child: Container(
                          height: 200,
                          width: 170,
                          margin: const EdgeInsets.only(right: 12),
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
                            child: FilesCard(
                              cardInfo: data.elementAt(index),
                            ),
                          ),
                        )),
                        scrollDirection: Axis.horizontal,
                      )
                    : const Center(
                        child: Text("No File yet made"),
                      ),
              );
            },
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
