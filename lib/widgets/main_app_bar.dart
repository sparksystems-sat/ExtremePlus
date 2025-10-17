import 'package:exam_practice_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class MainAppbar extends StatefulWidget {
  String title;
  List<String>? tabs;
  MainAppbar({super.key, required this.title, this.tabs});

  @override
  State<MainAppbar> createState() => _MainAppbarState();
}

class _MainAppbarState extends State<MainAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: big_text_page(text_value: widget.title),
      backgroundColor: Colors.teal,
      // Make the app bar collapsible
      pinned: true, // Keeps the App Bar and TabBar visible at the top
      floating: false, // Prevents the app bar from reappearing on any scroll
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        // background: Image.network(
        //   'https://picsum.photos/800/200', // Placeholder image
        //   fit: BoxFit.cover,
        // ),
      ),
      bottom:
          widget.tabs != null
              ? TabBar(
                isScrollable: true,
                tabs: widget.tabs!.map((tab) => Tab(text: tab)).toList(),
              )
              : null,
    );
  }
}
