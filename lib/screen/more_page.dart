import 'package:exam_practice_app/screen/quiz/subject_battle_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Note",
      "icon": FontAwesomeIcons.book,
      "color": Color(0xFF2196F3),
      "route": null,
    },
    {
      "title": "Game",
      "icon": FontAwesomeIcons.gamepad,
      "color": Color(0xFF9C27B0),
      "route": "game",
    },
    {
      "title": "Time",
      "icon": FontAwesomeIcons.clock,
      "color": Color(0xFFFF9800),
      "route": null,
    },
    {
      "title": "Short Notes",
      "icon": FontAwesomeIcons.solidBookmark,
      "color": Color(0xFF4CAF50),
      "route": null,
    },
    {
      "title": "Random",
      "icon": FontAwesomeIcons.dice,
      "color": Color(0xFFF44336),
      "route": null,
    },
    {
      "title": "History",
      "icon": FontAwesomeIcons.clockRotateLeft,
      "color": Color(0xFF2196F3),
      "route": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.0,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return GestureDetector(
                  onTap: () {
                    if (item["route"] == "game") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubjectBattlePage(),
                        ),
                      );
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FaIcon(
                            item["icon"],
                            size: 40,
                            color: item["color"],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item["title"],
                          style: TextStyle(
                            fontSize: 16,
                            color: item["color"],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
