class Note {
  const Note({
    required this.id,
    required this.title,
    required this.body,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String body;
  final DateTime updatedAt;

  String get bodyPreview {
    final String trimmed = body.trim();
    return trimmed.isEmpty ? 'No content' : trimmed;
  }

  String get updatedLabel {
    const List<String> months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final String month = months[(updatedAt.month - 1).clamp(0, 11)];
    return '$month ${updatedAt.day}, ${updatedAt.year}';
  }

  Note copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

final List<Note> notes = <Note>[
  Note(
    id: '1',
    title: 'English - Tenses',
    body:
        'Present simple vs present continuous. Use present simple for habits and facts; present continuous for actions happening now.',
    updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Note(
    id: '2',
    title: 'Biology - Cell',
    body:
        'Cell membrane controls what enters/leaves. Mitochondria produce ATP. Nucleus stores DNA.',
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Note(
    id: '3',
    title: 'Math - Trigonometry',
    body:
        'SOH-CAH-TOA. Remember sin^2(x)+cos^2(x)=1. Use unit circle for common angles.',
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Note(
    id: '4',
    title: 'Physics - Motion',
    body:
        'v = u + at, s = ut + 1/2 at^2. Use consistent units and identify knowns before solving.',
    updatedAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
];
