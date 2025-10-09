import 'package:animated_background/animated_background.dart';
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/screen/book_mark.dart';
import 'package:exam_practice_app/screen/home.dart';
import 'package:exam_practice_app/screen/offline.dart';
import 'package:exam_practice_app/screen/profile.dart';
import 'package:exam_practice_app/widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  ParticleOptions particles = ParticleOptions(
    baseColor: Colors.red,
    spawnOpacity: 0.1,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    spawnMinSpeed: 30.0,
    spawnMaxSpeed: 70.0,
    spawnMinRadius: 7.0,
    spawnMaxRadius: 15.0,
    particleCount: 30,
  );
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BookMarkPage(),
    OfflinePage(),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.house,
                color:
                    _selectedIndex == 0 ? Colors.black : Colors.grey.shade700,
              ),
              label: t(context).bottom_home,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.bookmark,
                color:
                    _selectedIndex == 1 ? Colors.black : Colors.grey.shade700,
              ),
              label: t(context).bottom_book_mark,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.wifi_off,
                color:
                    _selectedIndex == 2 ? Colors.black : Colors.grey.shade700,
              ),
              label: t(context).bottom_offline,
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.user,
                color:
                    _selectedIndex == 3 ? Colors.black : Colors.grey.shade700,
              ),
              label: t(context).bottom_profile,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade700,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options: particles,
          paint:
              Paint()
                ..strokeWidth = 10.0
                ..style = PaintingStyle.stroke,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              App_Bar(),
              SliverFillRemaining(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
