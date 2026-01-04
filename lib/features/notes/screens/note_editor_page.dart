import 'package:exam_practice_app/features/notes/models/note.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key, this.note});

  final Note? note;

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  late final TextEditingController _title;
  late final TextEditingController _body;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note?.title ?? '');
    _body = TextEditingController(text: widget.note?.body ?? '');
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  void _save() {
    final String title = _title.text.trim();
    final String body = _body.text.trim();
    if (title.isEmpty && body.isEmpty) {
      Navigator.of(context).pop<Note>(null);
      return;
    }

    final Note result = (widget.note ??
            Note(
              id: DateTime.now().toString(),
              title: '',
              body: '',
              updatedAt: DateTime.now(),
            ))
        .copyWith(
          title: title.isEmpty ? 'Untitled' : title,
          body: body,
          updatedAt: DateTime.now(),
        );

    Navigator.of(context).pop<Note>(result);
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.18), width: 1.2),
    );

    return Scaffold(
      backgroundColor: AppColors.main_background_color,
      appBar: AppBar(
        title: Text(
          widget.note == null ? 'New Note' : 'Edit Note',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 10, bottom: 10),
            child: SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button3Color,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _title,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Note title',
                  hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  enabledBorder: outlineBorder.copyWith(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  focusedBorder: outlineBorder.copyWith(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.35),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: TextField(
                  controller: _body,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Start writing your note...',
                    hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                    enabledBorder: outlineBorder,
                    focusedBorder: outlineBorder.copyWith(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.35),
                        width: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
