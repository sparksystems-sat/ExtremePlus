import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});
  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: medium_text_page(textValue: t(context).appName)),
    );
  }
}
