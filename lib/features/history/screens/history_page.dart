import 'package:exam_practice_app/features/history/models/history_item.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Set<String> _selectedIds = <String>{};

  bool get _allSelected =>
      items.isNotEmpty && _selectedIds.length == items.length;

  void _toggleAll(bool value) {
    setState(() {
      _selectedIds.clear();
      if (value) {
        _selectedIds.addAll(items.map((e) => e.id));
      }
    });
  }

  void _toggleItem(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void _deleteSelected() {
    if (_selectedIds.isEmpty) {
      _showToast('No item selected');
      return;
    }

    setState(() {
      items.removeWhere((item) => _selectedIds.contains(item.id));
      _selectedIds.clear();
    });

    _showToast('History deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _deleteSelected,
            icon: const Icon(Icons.delete, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => _toggleAll(!_allSelected),
            child: Container(
              height: 52,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE6E6E6))),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child:
                  items.isEmpty
                      ? const SizedBox.shrink()
                      : Row(
                        children: [
                          Checkbox(
                            value: _allSelected,
                            onChanged: (v) => _toggleAll(v ?? false),
                          ),
                          const Spacer(),
                          const Text(
                            'Select All',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final HistoryItem item = items[index];
                final bool selected = _selectedIds.contains(item.id);

                return InkWell(
                  onTap: () => _toggleItem(item.id),
                  child: SizedBox(
                    height: 72,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.dateLabel,
                                style: const TextStyle(
                                  color: Color(0xFF6B85B7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: selected,
                          onChanged: (_) => _toggleItem(item.id),
                        ),
                        const SizedBox(width: 6),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
