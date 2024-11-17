import 'package:hive/hive.dart';

part 'task_model.g.dart';  // This is important for generating the adapter file

@HiveType(typeId: 0) // Ensure that typeId is unique across all your models
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String status; // "To Do", "In Progress", "Done"

  @HiveField(4)
  DateTime? dueDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.status = "To Do",
    this.dueDate,
  });
}
