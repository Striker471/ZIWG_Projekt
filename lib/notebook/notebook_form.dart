import 'package:flutter/material.dart';
import 'package:health_care_app/model/notebook.dart';


class NotebookForm extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final Function(Notebook) onNoteAdded;

  NotebookForm({required this.onNoteAdded});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Note'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            _addNote();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void _addNote() {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      Notebook newNote = Notebook(
        creationDate: DateTime.now().toString(),
        noteTitle: title,
        noteContent: content,
      );
      onNoteAdded(newNote);
    }
  }
}
