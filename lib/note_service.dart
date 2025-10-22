class NoteService {
  static final Map<String, List<Map<String, String>>> _userNotes = {};

  static void addNote(String email, Map<String, String> note) {
    if (!_userNotes.containsKey(email)) {
      _userNotes[email] = [];
    }
    _userNotes[email]!.add(note);
  }

  static List<Map<String, String>> getNotes(String email) {
    return _userNotes[email] ?? [];
  }
}
