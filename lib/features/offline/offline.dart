import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});
  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: medium_text_page(textValue: t(context).bottom_offline),
      ),
    );
  }
}
