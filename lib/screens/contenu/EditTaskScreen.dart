import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditTaskScreen extends StatefulWidget {
  final String taskId;
  final String initialTitle;
  final String initialDescription;

  const EditTaskScreen({
    Key? key,
    required this.taskId,
    required this.initialTitle,
    required this.initialDescription,
  }) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier la tâche'),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.save_add,
              color: Colors.black,
              size: 30,
            ),
            onPressed: _saveTask,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTask() async {
    final newTitle = _titleController.text;
    final newDescription = _descriptionController.text;

    if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.taskId)
          .update({
        'title': newTitle,
        'description': newDescription,
      });

      Navigator.of(context).pop();
    }
  }
}
