import 'package:exam_practice_app/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "My Notes",
      "svg": "assets/svgs/book.svg",
      "route": AppRoutes.notes,
    },
    {"title": "Game", "svg": 'assets/svgs/game.svg', "route": AppRoutes.game},
    {
      "title": "Timer",
      "svg": "assets/svgs/timer.svg",
      "route": AppRoutes.timer,
    },
    {
      "title": "Short Notes",
      "svg": "assets/svgs/notes.svg",
      "route": AppRoutes.shortNotes,
    },
    {
      "title": "Random",
      "svg": "assets/svgs/random.svg",
      "route": AppRoutes.random,
    },
    {
      "title": "History",
      "svg": "assets/svgs/history.svg",
      "route": AppRoutes.history,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                final String title = item["title"] as String;
                final String svg = item["svg"] as String;
                return GestureDetector(
                  onTap: () {
                    final route = item["route"] as String?;
                    if (route == null) return;
                    Navigator.pushNamed(context, route);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 14,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(svg, height: 34, width: 34),
                        const SizedBox(height: 12),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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
