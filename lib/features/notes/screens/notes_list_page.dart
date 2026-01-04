import 'package:exam_practice_app/features/notes/models/note.dart';
import 'package:exam_practice_app/features/notes/screens/note_card.dart';
import 'package:exam_practice_app/features/notes/screens/note_editor_page.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Note> get _filteredNotes {
    if (_query.isEmpty) return notes;
    return notes
        .where((note) {
          return note.title.toLowerCase().contains(_query) ||
              note.body.toLowerCase().contains(_query);
        })
        .toList(growable: false);
  }

  Future<void> _openEditor({Note? note}) async {
    final Note? result = await Navigator.of(
      context,
    ).push<Note>(MaterialPageRoute(builder: (_) => NoteEditorPage(note: note)));
    if (result == null) return;

    setState(() {
      final int index = notes.indexWhere((n) => n.id == result.id);
      if (index >= 0) {
        notes[index] = result;
      } else {
        notes.insert(0, result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Note> notes = _filteredNotes;

    return Scaffold(
      backgroundColor: AppColors.main_background_color,
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.button3Color,
        onPressed: () => _openEditor(),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search notes',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  notes.isEmpty
                      ? const Center(
                        child: Text(
                          'No notes yet',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: notes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final Note note = notes[index];
                          return NoteCard(
                            note: note,
                            onTap: () => _openEditor(note: note),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
