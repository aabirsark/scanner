import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CustomGalleryPageHandler with ChangeNotifier {
  // ? Variable
  List<XFile> _galleryImages = [];
  int _pageSliderNo = 0;

  // getter
  List<XFile> get galleryImages => _galleryImages;
  int get pageSliderNo => _pageSliderNo;

  // ? setter
  setImages(List<XFile> imgs) {
    galleryImages.addAll(imgs);
    notifyListeners();
  }

  setPageNo(int index) {
    _pageSliderNo = index;
    notifyListeners();
  }

  removeImageIndex(int i){
    _galleryImages.removeAt(i);
    notifyListeners();
  }

  exhangeImageAtIndex(int i , XFile file) {
    _galleryImages[i] = file;
    notifyListeners();
  }

  emptyAllImages(){
    _galleryImages = [];
    notifyListeners();
  }
}
