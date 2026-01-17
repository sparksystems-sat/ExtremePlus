import 'package:flutter/material.dart';

import 'package:exam_practice_app/utility/appColors.dart';

class ShortNoteEntry {
  final String id;
  final String title;
  final String body;

  const ShortNoteEntry({
    required this.id,
    required this.title,
    required this.body,
  });
}

class UnderlineTabIndicator extends Decoration {
  final Color color;
  final double thickness;
  final EdgeInsetsGeometry insets;

  const UnderlineTabIndicator({
    required this.color,
    this.thickness = 6,
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

  final List<String> chapters = ['Ch 1', 'Ch 2', 'Ch 3', 'Ch 4', 'Ch 5'];

  final Map<String, List<TextSpan>> chapterContents = {
    'Ch 1': [
      const TextSpan(
        text: 'Cell: The Basic Unit of Life\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'All living organisms are made up of cells. The cell is the structural and functional unit of life. '
            'Cells can exist as independent units of life (as in unicellular organisms) or may form tissues and organs in multicellular organisms.\n\n',
      ),
      const TextSpan(
        text: 'There are two types of cells: prokaryotic and eukaryotic. ',
      ),
      const TextSpan(
        text:
            'Prokaryotic cells (like bacteria) do not have a true nucleus, while eukaryotic cells (found in plants, animals, fungi, and protists) '
            'have a well-defined nucleus and membrane-bound organelles.\n\n',
      ),
      const TextSpan(
        text: 'Cell Organelles and Their Functions:\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(
        children: [
          const TextSpan(text: '- '),
          const TextSpan(
            text: 'Nucleus: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
                'Contains genetic material (DNA) and controls the cell\'s activities.\n',
          ),
          const TextSpan(text: '- '),
          const TextSpan(
            text: 'Mitochondria: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
                'Known as the powerhouse of the cell, they produce energy (ATP) via cellular respiration.\n',
          ),
          const TextSpan(text: '- '),
          const TextSpan(
            text: 'Endoplasmic Reticulum (ER): ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
                'Rough ER is involved in protein synthesis, and Smooth ER is involved in lipid synthesis and detoxification.\n',
          ),
          const TextSpan(text: '- '),
          const TextSpan(
            text: 'Golgi Apparatus: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
                'Modifies, sorts, and packages proteins and lipids for storage or transport out of the cell.\n',
          ),
          const TextSpan(text: '- '),
          const TextSpan(
            text: 'Lysosomes: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
                'Contain digestive enzymes that help break down waste materials and cellular debris.\n',
          ),
          const TextSpan(text: '- '),
          const TextSpan(
            text: 'Chloroplasts (in plant cells): ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
                'Site of photosynthesis, contain chlorophyll that captures light energy.\n',
          ),
        ],
      ),
    ],
    'Ch 2': [
      const TextSpan(
        text: 'Nutrition in Plants\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'Plants prepare their own food by the process of photosynthesis. This process mainly takes place in the leaves of the plant. '
            'It requires sunlight, carbon dioxide, water, and chlorophyll. The food prepared is stored in the form of glucose or starch.\n\n',
      ),
      const TextSpan(
        text:
            'There are also some non-green plants and insectivorous plants that get their nutrition in other ways.\n',
      ),
    ],
    'Ch 3': [
      const TextSpan(
        text: 'Transportation in Animals and Plants\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'Transportation is the process of movement of water, minerals, and food to all parts of the plant body. In animals, it refers to the circulation of blood.\n\n',
      ),
      const TextSpan(
        text:
            'In humans, the circulatory system includes the heart, blood, and blood vessels. In plants, xylem transports water and minerals, while phloem transports food.\n',
      ),
    ],
    'Ch 4': [
      const TextSpan(
        text: 'Respiration in Organisms\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'Respiration is the biochemical process in which food is broken down to release energy. '
            'It occurs in all living organisms and can be aerobic (with oxygen) or anaerobic (without oxygen).\n\n',
      ),
      const TextSpan(
        text:
            'The energy released is stored in the form of ATP (Adenosine Triphosphate), which is then used for various activities of the body.\n',
      ),
    ],
    'Ch 5': [
      const TextSpan(
        text: 'Reproduction in Plants\n\n',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const TextSpan(
        text:
            'Reproduction is the biological process by which new individual organisms are produced. In plants, reproduction can be sexual or asexual.\n\n',
      ),
      const TextSpan(
        text:
            'Sexual reproduction involves the fusion of male and female gametes. Asexual reproduction includes methods like budding, fragmentation, and vegetative propagation.\n',
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
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
      final weight = span.style?.fontWeight;
      final text = (span.text ?? '').trim();
      if (text.isNotEmpty && weight == FontWeight.bold) {
        return text.replaceAll('\n', '').trim();
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
      appBar: AppBar(
        title: Text(
          '${widget.subjectTitle} - Short Notes',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: AppColors.appbar_color,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _tabController.animateTo(0);
            },
            icon: const Icon(Icons.sync, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Material(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              dividerColor: Colors.grey.shade300,
              dividerHeight: 1,
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
                thickness: 8,
                insets: const EdgeInsets.symmetric(horizontal: 12),
              ),
              indicatorPadding: EdgeInsets.zero,
              tabs: chapters.map((c) => Tab(text: c)).toList(),
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
                              color: AppColors.button3Color.withValues(
                                alpha: 0.6,
                              ),
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
