import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'task_card.dart';

class TaskList extends StatelessWidget {
  final String section;

  const TaskList({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks.where((task) => task.status == section).toList();

    return DragTarget<TaskModel>(
      onWillAccept: (task) => task != null && task.status != section,
      onAccept: (task) {
        taskProvider.updateTask(
          TaskModel(
            id: task.id,
            title: task.title,
            description: task.description,
            status: section,
            dueDate: task.dueDate,
          ),
        );
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                section,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(task: tasks[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}