import 'package:flutter/material.dart';
import 'note_service.dart';
import 'add_note_screen.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;
  HomeScreen({required this.userEmail});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> notes = [];

  @override
  void initState() {
    super.initState();
    notes = NoteService.getNotes(widget.userEmail);
  }

  void refreshNotes() {
    setState(() {
      notes = NoteService.getNotes(widget.userEmail);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes'),
        actions: [
          Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
              activeColor: Theme.of(context).colorScheme.secondary,
              activeTrackColor: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
        ],
      ),
      body: notes.isEmpty
          ? Center(child: Text("No notes yet."))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, index) {
          final note = notes[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(note['title'] ?? ""),
              subtitle: Text(note['content'] ?? ""),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNoteScreen(
                userEmail: widget.userEmail,
                onNoteAdded: refreshNotes,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
