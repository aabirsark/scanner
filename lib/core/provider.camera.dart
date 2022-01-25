import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';

class CustomCameraPageHandler with ChangeNotifier {
  List<XFile> _cameraImages = [];
  int _pageCount = 0;

  // getter
  List<XFile> get cameraImages => _cameraImages;
  int get pageCount => _pageCount;

  // setter
  void addData(XFile file) {
    _cameraImages.add(file);

    notifyListeners();
  }

  void removeAllData() {
    _cameraImages = [];
    notifyListeners();
  }

  void removeDataAt(int i) {
    _cameraImages.removeAt(i);
    notifyListeners();
  }

  void changePageCount(int i) {
    _pageCount = i;
    notifyListeners();
  }

  void exchangeCurrentPage(XFile file) {
    _cameraImages[_pageCount] = file;
    notifyListeners();
  }

  emptyAllImages() {
    _cameraImages = [];
    notifyListeners();
  }
}
