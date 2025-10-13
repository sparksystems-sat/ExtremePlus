import 'package:flutter/material.dart';

class LearningPage extends StatefulWidget {
    final int subject_id;
  const LearningPage({super.key ,required this.subject_id});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("GeeksForGeeks"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_filled),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.account_box_outlined),
                text: "Account",
              ),
              Tab(
                icon: Icon(Icons.alarm),
                text: "Alarm",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Icon(Icons.home),
            ),
            Center(
              child: Icon(Icons.account_circle),
            ),
            Center(
              child: Icon(Icons.alarm),
            )
          ],
        ),
      ),
    );
  }
}
