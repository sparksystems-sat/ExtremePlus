import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/widgets/body_text.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Center(
                child: medium_text_page(text_value: lang(context).bottom_home),
              ),
            ]),
          ),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              return Card(
                child: Center(
                  child: body_text_page(text_value: 'Subject $index'),
                ),
              );
            },
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
