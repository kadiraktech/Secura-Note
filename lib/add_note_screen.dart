import 'package:flutter/material.dart';
import 'note_service.dart';

class AddNoteScreen extends StatelessWidget {
  final String userEmail;
  final VoidCallback onNoteAdded;

  AddNoteScreen({required this.userEmail, required this.onNoteAdded});

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NoteService.addNote(userEmail, {
                  'title': titleController.text,
                  'content': contentController.text,
                });
                onNoteAdded();
                Navigator.pop(context);
              },
              child: Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
