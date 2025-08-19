import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: medium_text_page(text_value: t(context).bottom_book_mark),
      ),
    );
  }
}
