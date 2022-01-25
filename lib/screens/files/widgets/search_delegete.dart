import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/Widgets/card_bottom_sheet.dart';
import 'package:scanner/Widgets/file_card.dart';
import 'package:scanner/models/files.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate(this.files)
      : super(textInputAction: TextInputAction.search);

  final List<CreatedFile> files;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query == "") {
              close(context, null);
            }
            query = "";
          },
          icon: const Icon(CupertinoIcons.multiply))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(CupertinoIcons.left_chevron));
  }

  @override
  Widget buildResults(BuildContext context) {
    var data = files
        .where((e) => e.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return data.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemBuilder: (context, index) => Center(
                  child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => CustomCardInfoBottomSheet(
                                file: data.elementAt(index),
                              ),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true);
                    },
                    child: FilesCard(cardInfo: data[index])),
              )),
            ),
          )
        : const Center(
            child: Text("File not Found !"),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var data = files
        .where((e) => e.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return data.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemBuilder: (context, index) => Center(
                  child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => CustomCardInfoBottomSheet(
                                file: data.elementAt(index),
                              ),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true);
                    },
                    child: FilesCard(cardInfo: data[index])),
              )),
            ),
          )
        : const Center(
            child: Text("File not Found !"),
          );
  }
}
