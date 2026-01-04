class HistoryItem {
  const HistoryItem({
    required this.id,
    required this.title,
    required this.dateLabel,
  });

  final String id;
  final String title;
  final String dateLabel;
}

final List<HistoryItem> items = <HistoryItem>[
  const HistoryItem(
    id: '1',
    title: 'Lesson 5: Past Perfect Tense',
    dateLabel: 'October 10, 2023',
  ),
  const HistoryItem(id: '2', title: 'Exam study', dateLabel: 'October 5, 2023'),
  const HistoryItem(
    id: '3',
    title: 'Homework help - Math exercises',
    dateLabel: 'October 5, 2024',
  ),
  const HistoryItem(
    id: '4',
    title: 'Lesson 4: Elements of Periodic Table',
    dateLabel: 'September 30, 2023',
  ),
];
