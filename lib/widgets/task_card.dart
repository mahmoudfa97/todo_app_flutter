import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../views/add_edit_task_modal.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskModel>(
      data: task,
      feedback: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            task.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: Card(
          color: Colors.grey[300],
          child: ListTile(
            title: Text(task.title),
            subtitle: task.description.isNotEmpty ? Text(task.description) : null,
          ),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
        child: ListTile(
          title: Text(
            task.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.description.isNotEmpty) Text(task.description),
              if (task.dueDate != null)
                Text(
                  'Due: ${DateFormat.yMMMd().format(task.dueDate!)}',
                  style: const TextStyle(color: Colors.redAccent),
                ),
            ],
          ),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                showDialog(
                  context: context,
                  builder: (context) => EditTaskModal(task: task),
                );
              } else if (value == 'delete') {
                Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
              }
            },
          ),
        ),
      ),
    );
  }
}