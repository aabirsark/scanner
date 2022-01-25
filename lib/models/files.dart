import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'files.g.dart';

@HiveType(typeId: 0)
class CreatedFile extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  DateTime? time;

  @HiveField(2)
  String? method;

  @HiveField(3)
  String? paths;
}
