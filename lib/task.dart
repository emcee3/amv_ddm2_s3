import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isPressed;

  Task({this.title, this.isPressed});

  @override
  String toString() {
    return '$title: $isPressed';
  }
}