import 'package:flutter/material.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import '../data/short_notes_repository.dart';
import '../models/short_note_model.dart';

class UnderlineTabIndicator extends Decoration {
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry insets;

  const UnderlineTabIndicator({
    required this.color,
    this.thickness = 2,
    this.insets = const EdgeInsets.symmetric(horizontal: 14),
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return RoundedUnderlinePainter(
      color: color,
      thickness: thickness,
      insets: insets,
    );
  }
}

class RoundedUnderlinePainter extends BoxPainter {
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry insets;

  RoundedUnderlinePainter({
    required this.color,
    required this.thickness,
    required this.insets,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final indicatorRect = insets
        .resolve(configuration.textDirection ?? TextDirection.ltr)
        .deflateRect(rect);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        indicatorRect.left,
        indicatorRect.bottom - thickness,
        indicatorRect.width,
        thickness,
      ),
      const Radius.circular(999),
    );

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);
  }
}

class ShortNotesPage extends StatefulWidget {
  final String subjectTitle;

  const ShortNotesPage({super.key, this.subjectTitle = 'Physics'});

  @override
  State<ShortNotesPage> createState() => _ShortNotesPageState();
}

class _ShortNotesPageState extends State<ShortNotesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final Set<String> _bookmarkedIds = <String>{};

  late final List<String> chapters;
  late final Map<String, List<TextSpan>> chapterContents;

  @override
  void initState() {
    super.initState();
    chapters = ShortNotesRepository.getChapters();
    chapterContents = ShortNotesRepository.getChapterContents();
    _tabController = TabController(length: chapters.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static String _flattenSpanList(List<TextSpan> spans) {
    final buffer = StringBuffer();
    for (final span in spans) {
      buffer.write(_flattenSpan(span));
    }
    return buffer.toString();
  }

  static String _flattenSpan(TextSpan span) {
    final buffer = StringBuffer();
    if (span.text != null) buffer.write(span.text);
    final children = span.children;
    if (children != null) {
      for (final child in children) {
        if (child is TextSpan) buffer.write(_flattenSpan(child));
      }
    }
    return buffer.toString();
  }

  static String _firstBoldTitle(List<TextSpan> spans) {
    for (final span in spans) {
      if (span.style?.fontWeight == FontWeight.bold && span.text != null) {
        return span.text!.trim();
      }
    }
    final fallback = _flattenSpanList(spans).trim();
    if (fallback.isEmpty) return 'Short Note';
    final firstLine = fallback.split('\n').first.trim();
    return firstLine.isEmpty ? 'Short Note' : firstLine;
  }

  List<ShortNoteEntry> _notesForChapter(String chapter) {
    final spans = chapterContents[chapter];
    if (spans == null || spans.isEmpty) return const [];

    final title = _firstBoldTitle(spans);
    var fullText = _flattenSpanList(spans).trim();
    if (fullText.startsWith(title)) {
      fullText = fullText.substring(title.length).trimLeft();
    }
    fullText = fullText.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();

    final paragraphs =
        fullText
            .split(RegExp(r'\n\s*\n'))
            .map((p) => p.trim())
            .where((p) => p.isNotEmpty)
            .toList();

    if (paragraphs.isEmpty) {
      return [ShortNoteEntry(id: '$chapter-0', title: title, body: fullText)];
    }

    final entries = <ShortNoteEntry>[];
    final buffer = StringBuffer();
    var chunkIndex = 0;

    void flush() {
      final text = buffer.toString().trim();
      if (text.isEmpty) return;
      entries.add(
        ShortNoteEntry(id: '$chapter-$chunkIndex', title: title, body: text),
      );
      chunkIndex++;
      buffer.clear();
    }

    for (final paragraph in paragraphs) {
      if (buffer.isNotEmpty) buffer.writeln('\n');
      buffer.write(paragraph);
      if (buffer.length >= 420) flush();
    }
    flush();

    return entries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.appbar_color,
                AppColors.appbar_color.withOpacity(0.0),
              ],
              stops: const [0.7, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: AppBar(
            title: Text(
              '${widget.subjectTitle} - Short Notes',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _tabController.animateTo(0);
                },
                icon: const Icon(Icons.sync, color: Colors.black),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  dividerColor: Colors.transparent,
                  dividerHeight: 0,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  indicator: UnderlineTabIndicator(
                    color: AppColors.button3Color,
                    thickness: 9,
                    insets: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  indicatorPadding: EdgeInsets.zero,
                  tabs: chapters.map((c) => Tab(text: c)).toList(),
                ),
                Container(height: 1, color: Colors.grey.shade300),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  chapters.map((chapter) {
                    final notes = _notesForChapter(chapter);
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                      itemCount: notes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        final isBookmarked = _bookmarkedIds.contains(note.id);
                        return Container(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.button3Color.withOpacity(0.6),
                              width: 1.2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      note.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (isBookmarked) {
                                          _bookmarkedIds.remove(note.id);
                                        } else {
                                          _bookmarkedIds.add(note.id);
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      isBookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: AppColors.button3Color,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                note.body,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
