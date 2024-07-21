import 'package:hive/hive.dart';

part 'clipboard_item.g.dart';

@HiveType(typeId: 0)
class ClipboardItem extends HiveObject {
  @HiveField(0)
  late String content;

  @HiveField(1)
  late DateTime timestamp;

  @HiveField(2)
  late bool isFavorite;

  ClipboardItem(
      {required this.content,
      required this.timestamp,
      this.isFavorite = false});
}
