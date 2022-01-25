import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scanner/extensions/ext.navigate.dart';
import 'package:scanner/screens/make_pdf/util.dart';
import 'package:scanner/screens/make_pdf/widgets/compresser_setting_row.dart';
import 'package:scanner/Widgets/rename_bottom_sheet.dart';
import 'package:scanner/tools/create_pdf.dart';

class MakePDF extends StatefulWidget {
  const MakePDF(
      {Key? key,
      required this.color,
      required this.method,
      required this.paths})
      : super(key: key);

  final Color color;
  final String method;
  final List<String> paths;

  @override
  _MakePDFState createState() => _MakePDFState();
}

class _MakePDFState extends State<MakePDF> {
  String title = getTimeTitle();

  onSave(String renamedTitle) {
    if (renamedTitle != "") {
      title = renamedTitle;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 3,
              backgroundColor: widget.color,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.method)
          ],
        ),
        leading: IconButton(
            onPressed: () {
              context.navigateBack();
            },
            icon: const Icon(CupertinoIcons.multiply)),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Creating file..."),
            behavior: SnackBarBehavior.floating,
          ));
          PdfCreation.createPDF(widget.paths, title, widget.method);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("File Created"),
            behavior: SnackBarBehavior.floating,
          ));
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black,
          ),
          child: const Center(
            child: Text(
              "Create PDF",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CustomRenameBottomSheet(
                        title: title,
                        onSave: onSave,
                      ),
                    );
                  },
                  icon: const Icon(
                    Iconsax.edit,
                    size: 25,
                  )),
            ),
            const SizedBox(
              height: 45,
            ),
            Text(
              "Compresser value",
              style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
            ),
            const SizedBox(
              height: 5,
            ),
            const CompresserSettingsRow()
          ],
        ),
      )),
    );
  }
}
