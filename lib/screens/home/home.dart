import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:scanner/screens/files/files_page.dart';

// import 'package:pdf/widgets.dart';
import 'package:scanner/screens/home/widgets/header.dart';
import 'package:scanner/screens/home/widgets/recent_file.dart';
import 'package:scanner/screens/home/widgets/tools.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.navigateTo(const FilesPage());
              },
              icon: const Icon(Iconsax.folder))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [
            Header(),
            SizedBox(
              height: 10,
            ),
            Tools(),
            RecentFiles(),
            Text(
              "App desgined and made by Aabir Sarkar",
              textScaleFactor: .7,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
