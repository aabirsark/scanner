String getTimeTitle() {
  DateTime now = DateTime.now();
  String title =
      "Rx ${now.day}${now.year}${now.month}${now.millisecond}${now.microsecond}";

  return title;
}
