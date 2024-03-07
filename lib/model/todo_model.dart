import 'package:hive/hive.dart';
part "todo_model.g.dart";

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime? date;
  @HiveField(3)
  int priority;
  @HiveField(4)
  bool isCompleted;
  @HiveField(5)
  String id;
  @HiveField(6)
  DateTime createdAt;
  TodoModel({
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.id,
    this.isCompleted = false,
    required this.createdAt,
  });
}
