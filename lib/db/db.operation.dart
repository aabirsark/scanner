import 'package:hive/hive.dart';
import 'package:scanner/constants.dart';
import 'package:scanner/models/files.dart';

class Boxes {
  static Box<CreatedFile> get createFileBox => Hive.box<CreatedFile>(boxName);
}

class DBoperation {
  static add(
      {required String path, required String title, required String method}) {
    final CreatedFile model = CreatedFile()
      ..title = title
      ..method = method
      ..paths = path
      ..time = DateTime.now();

    final box = Boxes.createFileBox;

    // ? adding data
    box.add(model);
 
  }
}
