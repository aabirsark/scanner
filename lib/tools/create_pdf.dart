import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:scanner/db/db.operation.dart';

class PdfCreation {
  static void createPDF(
      List<String> paths, String fileName, String method) async {
    final document = pdf.Document();

    // start creating pdf

    for (var i in paths) {
      final image = pdf.MemoryImage(File(i).readAsBytesSync());

      final dec = pdf.BoxDecoration(
          image: pdf.DecorationImage(image: image, fit: pdf.BoxFit.contain));

      document.addPage(pdf.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pdf.EdgeInsets.zero,
          build: (pdf.Context context) {
            return pdf.Column(children: [
              pdf.Expanded(
                child: pdf.Center(
                    child: pdf.Container(
                        decoration: dec,
                        height: double.infinity,
                        width: double.infinity)),
              ),
              pdf.SizedBox(height: 5),
              pdf.Text("Scanned by RoarX scanner",
                  style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold)),
              pdf.Text("App designed and made by Aabir Sarkar",
                  style: pdf.TextStyle(
                      fontWeight: pdf.FontWeight.bold,
                      color: const PdfColor.fromInt(0xFF616161),
                      fontSize: 5)),
              pdf.SizedBox(height: 5),
            ]); // Center
          }));
    }

    final String path = await getLocalPath();
    final File file = File("$path/${fileName.replaceAll(" ", "_")}.pdf");
    await file.writeAsBytes(await document.save());
    DBoperation.add(path: file.path, title: fileName, method: method);
  }
}

getLocalPath() async {
  final localPath = await getExternalStorageDirectory();

  return localPath!.path;
}
