import 'package:camera/camera.dart';

class XFileToPathsConverter {
  static List<String> xfilesToPath(List<XFile> files) {
    List<String> paths = [];
    for (var item in files) {
      paths.add(item.path);
    }

    return paths;
  }
}
