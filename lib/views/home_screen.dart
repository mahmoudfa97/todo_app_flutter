import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/widgets/task_list.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: Row(
        children: [
          Expanded(
            child: TaskList(section: 'To Do'),
          ),
          Expanded(
            child: TaskList(section: 'In Progress'),
          ),
          Expanded(
            child: TaskList(section: 'Done'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open Add Task Modal
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskModal(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskModal extends StatefulWidget {
  @override
  _AddTaskModalState createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final _formKey = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Task',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _taskTitleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _taskDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Due Date'),
              subtitle: Text(_dueDate != null
                  ? _dueDate!.toLocal().toString()
                  : 'No due date selected'),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _dueDate) {
                    setState(() {
                      _dueDate = pickedDate;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // If the form is valid, add the task
                  final newTask = TaskModel(
                    title: _taskTitleController.text,
                    description: _taskDescriptionController.text,
                    dueDate: _dueDate,
                    id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate a unique ID
                  );

                  // Add the task to your provider
                  Provider.of<TaskProvider>(context, listen: false).addTask(newTask);

                  // Close the modal
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
