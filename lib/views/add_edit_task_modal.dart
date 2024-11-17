import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';

class EditTaskModal extends StatefulWidget {
  final TaskModel? task;

  const EditTaskModal({super.key, this.task});

  @override
  State<EditTaskModal> createState() => _EditTaskModalState();
}

class _EditTaskModalState extends State<EditTaskModal> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    selectedDate = widget.task?.dueDate;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Task' : 'Add Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  selectedDate != null
                      ? 'Due Date: ${DateFormat.yMMMd().format(selectedDate!)}'
                      : 'No Due Date',
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Pick Date'),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final taskProvider =
                Provider.of<TaskProvider>(context, listen: false);

            final newTask = TaskModel(
              id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
              title: titleController.text,
              description: descriptionController.text,
              dueDate: selectedDate,
              status: widget.task?.status ?? 'To Do',
            );

            if (isEditing) {
              taskProvider.updateTask(widget.task!.id as TaskModel);
            } else {
              taskProvider.addTask(newTask);
            }

            Navigator.of(context).pop();
          },
          child: Text(isEditing ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
