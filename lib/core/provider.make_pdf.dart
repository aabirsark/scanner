import 'package:flutter/foundation.dart';

class MakePdfPageHandler with ChangeNotifier {
  // ? variable
  String _title = "On";

  // ? getter
  String? get title => _title;

  // ? setter
  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }
}
